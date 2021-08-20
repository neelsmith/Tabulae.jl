
"""A parser"""
struct TabulaeParser <: CitableParser
    label::AbstractString
    sfstpath::AbstractString
end


"""Find full path to `fst-infl`on your system.

$(SIGNATURES)
"""
function fstinflpath()
    rawout = read(`which fst-infl`, String)
    replace(rawout, "\n" => "")
end

"""Find full path to `echo`on your system.

$(SIGNATURES)
"""
function echopath()
    rawout = read(`which echo`, String)
    replace(rawout, "\n" => "")
end

"""Dictionary of functions to use with each analytical type
to determine a `FormUrn` from the FST description of form.


$(SIGNATURES)
"""
function functionforcategory()
 
    Dict(
        #"irregular" => Tabulae.irregularfromfst,
        #"uninflected" => Tabulae.uninflectedfromfst,
        "noun" => Tabulae.nounfromfst,
        #"pronoun" => Tabulae.pronounfromfst,
        "verb" =>  Tabulae.verbfromfst,
        #"infinitive" => Tabulae.infinitivefromfst,
        #"participle" => Tabulae.participlefromfst,
        #"verbaladjective" => Tabulae.verbaladjectivefromfst,
        #"adjective" => Tabulae.adjectivefromfst
    )

end

"""Parse a single line of SFST output into an `Analysis`.

$(SIGNATURES)
"""
function analysisforline(fst::AbstractString)
    tidier = replace(fst, "<#>" => "#" )
    if ! contains(tidier, "<div>")
        @warn("BAD FST: ", tidier)
        nothing



    else
        (stem, rule) = split(tidier, "<div>")

        #
        # Stem part of SFST has a regular structure:
        # always begins with stem ID, lexeme ID,
        # token, and analysis category, before
        # then appending category-specific data.
        stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
        stemmatch = collect(eachmatch(stemre, stem))
        (stemidval, lexidval, tkn, stemtype, stemdata) = stemmatch[1].captures

        # Rule part of SFST also has a regular structure:
        # 
        rulere = r"<([^>]+)><([^>]+)>([^<]*)(.*)<u>(.+)</u>"

        # This regex will fail on old output format of irregulars, however, so 
        # need to test with try/catch.
        try
            rulematch = collect(eachmatch(rulere, rule))
            (inflclass, analysiscategory, ending, ruledata, ruleidval) = rulematch[1].captures
            # @info("RULE ANALYSIS ", (inflclass, analysiscategory, ending, ruledata, ruleidval) )
            fnctndict = functionforcategory()
            if ! haskey(fnctndict, analysiscategory)
                @warn("Could not find analysis function for ", analysiscategory)
                missing
            else
                fnct = fnctndict[analysiscategory]
                # Depends on what is regular, what is irregular!
                formcode = ""
                if analysiscategory == "irregular"
                    formcode = fnct(stemdata) |> formurn
                elseif analysiscategory == "uninflected"
                    formcode = fnct(inflclass) |> formurn
                elseif analysiscategory == "pronoun"
                    formcode = fnct(stemdata) |> formurn
                else
                    formcode =  string(ruledata) |> fnct |> formurn
                end
                
                Analysis(string(tkn,ending), LexemeUrn(lexidval), formcode, StemUrn(stemidval), RuleUrn(ruleidval))
            end


        catch e # Failed to apply rule regex
            @warn("Could not parse rule statement ", rule)
            nothing
        end
    end
end


"""Download FST output from a URL ad parse into `Analysis` objects.

$(SIGNATURES)
"""
function parseurl(url::AbstractString)
    fst = String(HTTP.get(url).body)
    parsefst(fst)
end

"""Parse FST output for multiple tokens.

$(SIGNATURES)
"""
function parsefst(fststring::AbstractString)
    lines = split(fststring,"\n")
    nonempty = filter(ln -> ! isempty(ln), lines)
    
    current = []
    rslts = []
    for ln in nonempty
    
        if isempty(current)
            push!(current, replace(ln, "> " => ""))
           
        else
            if ln[1] == '>'
                # New token
                rslt =  parsetokenfst(current)
                push!(rslts,rslt)
                current = [ln]

            elseif startswith(ln, "no result")
                push!(rslts, ln)
                current = []
            
            else   
                push!(current, ln)    
            end

        end
    end
    # Don't forget last one!
    if ! isempty(current)
        @info(string("ADDING FINAL ", current))
        push!(rslts,parsetokenfst(current))
    end
    
    rslts
end

"""Parse FST output for a single token to a list of `Analysis` objects.

$(SIGNATURES)
"""
function parsetokenfst(fstlines)
    @debug("Parse token fst ", fstlines)
    analyses = []
    if  length(fstlines) < 2
        msg = string("parsetokenfst: bad FST ", fstlines, " with ", length(fstlines), " lines." )
        throw(ArgumentError(msg))
    elseif startswith(fstlines[2], "no result")
        # let analyses stay empty
    else
        # skip header line and empty lines
        for ln in filter(l -> ! isempty(l), fstlines[2:end])
            push!(analyses, analysisforline(ln))
        end
    end
    analyses
end

"""Apply a parser to a token using `fst-infl`.

$(SIGNATURES)
"""
function applyparser(parser::TabulaeParser, tkn::AbstractString)
    fstinfl = fstinflpath()
    echo = echopath()
    cmd = pipeline(`$echo $tkn`, `$fstinfl $(parser.sfstpath)`)
    rslt = read(cmd, String)
end

"""Parse a single token to an array of `Analysis` or `nothing`.

$(SIGNATURES)
"""
function parsetoken(parser::TabulaeParser, tkn::AbstractString)
    stripped = replace(tkn, "<#>" => "#")
    applyparser(parser, stripped) |> parsetokenfst
end

"""Parse a list of words, and return a dictionary of tokens to a 
(possibly empty) Vector of `Analysis` objects.

$(SIGNATURES)

"""
function parsewordlist(p::TabulaeParser, tokens)
    parses = []
    for t in tokens
        push!(parses, parsetoken(p,t))
    end
    parses
end

function parselistfromfile(p::TabulaeParser,f)
    words = readdlm(f,'|')
    parsewordlist(p,words)
end

function parselistfromurl(p::TabulaeParser,u)
    words = split(String(HTTP.get(u).body) , "\n")
    parsewordlist(p,words)
end



