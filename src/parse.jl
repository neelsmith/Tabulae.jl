
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
        "finiteverb" =>  Tabulae.verbfromfst,
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
        (stem, rule) = split(fst, "<div>")

        # Stem part of SFST has a regular structure:
        # always begins with stem ID, lexeme ID,
        # token, and analysis category, before
        # then appending category-specific data.
        stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"
        stemmatch = collect(eachmatch(stemre, stem))
        (stemidval, lexidval, tkn, stemtype, stemdata) = stemmatch[1].captures
        #@info("STEM ANALYSIS ", (stemidval, lexidval, tkn, stemtype, stemdata) )
        # Rule part of SFST also has a regular structure:
        # 
        rulere = r"<([^>]+)><([^>]+)>([^<]*)(.*)<u>(.+)</u>"
        rulematch = collect(eachmatch(rulere, rule))
        (inflclass, analysiscategory, ending, ruledata, ruleidval) = rulematch[1].captures
       # @info("RULE ANALYSIS ", (inflclass, analysiscategory, ending, ruledata, ruleidval) )
        fnctndict = functionforcategory()
        fnct = fnctndict[analysiscategory]
        #@info("Function is ", fnct)
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

"""Parse a string of FST output for a single token
to a list of `Analysis` objects.


$(SIGNATURES)
"""
function parsefst(fststring::AbstractString)
    analyses = []
    lines = split(fststring,"\n")
    if  length(lines) < 2
        msg = string("parsefst: bad FST string ", fststring, " with ", length(lines), " lines." )
        throw(ArgumentError(msg))
    elseif startswith(lines[2], "no result")
        # let analyses stay empty
    else
        # skip header line and empty lines
        for ln in filter(l -> ! isempty(l), lines[2:end])
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
    stripped = FstBuilder.fstgreek(tkn) 
    applyparser(parser, stripped) |> parsefst
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

