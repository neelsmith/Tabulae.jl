"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct TabulaeStringParser <: AbstractStringParser
    entries
    ortho::LatinOrthographicSystem
    delimiter::AbstractString

    TabulaeStringParser(
        entries, #::Vector{AbstractString}, 
        ortho::LatinOrthographicSystem = latin24(), delim::AbstractString = "|") = new(entries, ortho, delim)
end


"""Override Base.show for parse.
$(SIGNATURES)
"""
function show(io::IO, p::TabulaeStringParser)
    msg = string("Latin parser covering $(length(p.entries)) analyses.")
    print(io, msg)
end


"""Instantiate a generic `StringParser` (from the `CitableParserBuilder` package) from a `TabulaeStringParser`.
$(SIGNATURES)
"""
function stringParser(p::TabulaeStringParser)
    StringParser(p.entries, p.ortho, p.delimiter)
end


"""Get data source for parser.
$(SIGNATURES)
"""
function datasource(p::TabulaeStringParser)
    p.entries
end



"""Get delimiter used in parser.
$(SIGNATURES)
"""
function delimiter(p::TabulaeStringParser)
    p.delimiter
end


"""Get orthography for parser.
$(SIGNATURES)
"""
function orthography(p::TabulaeStringParser)
    p.ortho
end

"""Write entries to file.
$(SIGNATURES)
"""
function tofile(p::TabulaeStringParser, f)
    open(f, "w") do io
        write(f, cex(p))
    end
end

"""Instantiate a `TabulaeStringParser` for `td`.
$(SIGNATURES)
"""
function tabulaeStringParser(td::Tabulae.Dataset)
    analyses = []
    rules = rulesarray(td)
    for stem in stemsarray(td)
        append!(analyses, buildparseable(stem, rules))
    end
    analyses |> TabulaeStringParser
end

"""Instantiate a `TabulaeStringParser` from a set of analyses read from a local file.
$(SIGNATURES)
"""
function tabulaeStringParser(f, freader::Type{FileReader})
    TabulaeStringParser(readlines(f))
end

"""Instantiate a `TabulaeStringParser` from a set of analyses read from a URL.
$(SIGNATURES)
"""
function tabulaeStringParser(u, ureader::Type{UrlReader})
    tmpfile = Downloads.download(u) 
    sp = readlines(tmpfile) |> TabulaeStringParser
    rm(tmpfile)
    sp
end


"""True if form IDs are build from the `Rule` of a
stem-rule pair.
$(SIGNATURES)
"""
function buildfromrule(r::T) where {T <: TabulaeRule}
    isa(r, TabulaePronounRule) == false  &&
    isa(r, TabulaeUninflectedRule)  ==  false &&    
    (r isa TabulaeIrregularRule) == false
end


"""Generate all forms possible for `stem`.
$(SIGNATURES)
"""
function buildparseable(stem::TabulaeNounStem,  rules::Vector{Rule}; delimiter = "|") 
    generated = []        
    classrules = filter(rules) do r
        inflectionclass(r) == inflectionclass(stem) &&
        lmpGender(r) == lmpGender(stem)
    end
    @debug("$(stem) matches rules $(classrules)")
    for rule in classrules
        mtoken = string(stemvalue(stem), ending(rule))
        mtokenid = "a"
        
        if buildfromrule(rule)
            #push!(generated, string(token, delimiter, lexeme(stem), delimiter, Tabulae.formurn(latinForm(rule)), delimiter, urn(stem), delimiter, urn(rule),delimiter,token, delimiter, mtoken))
            #pieces = [token, lexeme(stem), Tabulae.formurn(latinForm(rule)), urn(stem), urn(rule), mtoken, mtokenid]
            pieces = [token, lexeme(stem), Tabulae.formurn(latinForm(rule)), urn(stem), urn(rule), mtoken, mtokenid]
            record = join(pieces, delimiter)
            push!(generated, record)
        else
            pieces = [token, lexeme(stem), Tabulae.formurn(latinForm(stem)), urn(stem), urn(rule), mtoken, mtokenid]
            record = join(pieces, delimiter) 
            push!(generated, record)
        end
    end
    generated
end

function buildparseable(stem::T,  rules::Vector{Rule}; delimiter = "|") where {T <: TabulaeIrregularStem}
    @debug("BUILD FOR AN IRREGULAR: stem $(stem) with infl type $(inflectionclass(stem))")
    
    generated = []        
    classrules = filter(r -> inflectionclass(r) == inflectionclass(stem), rules)
    @debug("Rules $(classrules)")
    for rule in classrules
        @debug("Process rule $(rule) with infl type $(inflectionclass(rule))")
        token = tokenvalue(stem)
        mtoken = "a"
        push!(generated, string(token, delimiter, lexeme(stem), delimiter, formurn(latinForm(stem)), delimiter, urn(stem), delimiter, urn(rule),delimiter,token,delimiter,mtoken))
        @debug("Pushed $(token)")
    end
    generated
end

function buildparseable(stem::Stem,  rules::Vector{Rule}; delimiter = "|")
    generated = []        
    classrules = filter(r -> inflectionclass(r) == inflectionclass(stem), rules)
    #@info("$(stem) matches rules $(classrules)")
    for rule in classrules
        token = string(stemvalue(stem), ending(rule))
        mtoken = "a"
        push!(generated, string(token, delimiter, lexeme(stem), delimiter, Tabulae.formurn(latinForm(rule)), delimiter, urn(stem), delimiter, urn(rule), delimiter, token, delimiter, mtoken))

    end
    generated
end

function setotoken(a::Analysis, orthotoken::AbstractString)
    Analysis(
        orthotoken,
        lexemeurn(a),
        CitableParserBuilder.formurn(a),
        stemurn(a),
        CitableParserBuilder.ruleurn(a),
        mtoken(a),
        a.mtokenid

    )
end
enclitics = ["que", "ve", "ne", "cum", "met"]


"""Parse a Latin token, checking for possibility of enclitics.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, parser::TabulaeStringParser)
    ptrn = lowercase(s) * delimiter(parser)
    @info("Looking for $(s) in parser data")
    matches = filter(ln -> startswith(ln, ptrn), datasource(parser))
    @info("Got $(matches)")
    if isempty(matches)
        # Try again for enclitics if result is empty!    
        results = Analysis[]
        endings = orthography(parser) isa Latin23 ? map(enc -> replace(enc, "v" => "u"), enclitics) : enclitics
        for e in endings
            @debug("CHeck for enclitic $(e) in string $(s)")
            if endswith(s,e) && ! isequal(s,e)
                @debug("Found  possible  enclitic")
                
                rng = findlast(e, s)
                lastch = rng[1] - 1
                mtkn = s[1:lastch]
                otkn = s
                @debug("Tokens: $(tkn) + $(e)")
                for prs in parsetoken(mtkn, parser)
                    push!(results, setotoken(prs, otkn))
                end
                for prs in parsetoken(e, parser)
                    push!(results, setotoken(prs, otkn))
                end
                  
            end
        end
        results
        
    else
        @debug("Found results $(matches)")
        map(ln -> fromcex(ln, Analysis), matches)
    end

    
end


"""Value for CexTrait on TabulaeStringParser."""
struct TabulaeStringParserCex <: CexTrait end
"""Identify CEX trait for TabulaeStringParser type.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeStringParser})
    TabulaeStringParserCex()
end


"""Export parser to delimited-text format.
$(SIGNATURES)
"""
function cex(tsp::TabulaeStringParser; delimiter = "|")
    join(tsp.entries,"\n")
end

"""Instantiate a parser from delimited-text format.
Optionally identify orthographic system for parser in
parameter `configuration`.
$(SIGNATURES)
"""
function fromcex(trait::TabulaeStringParserCex, cexsrc::AbstractString, T; 
    delimiter = "|", configuration = nothing, strict = true)
    ortho = isnothing(configuration) ? latin25() : configuration
    entries = split(cexsrc, "\n")
    TabulaeStringParser(entries, ortho, delimiter)
end