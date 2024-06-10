"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct TabulaeStringParser <: AbstractStringParser
    entries
    ortho::LatinOrthographicSystem
    delimiter::AbstractString

    TabulaeStringParser(
        entries, #::Vector{AbstractString}, 
        ortho::LatinOrthographicSystem = latin24(), delim::AbstractString = "|") = new(entries, ortho, delim)
end

#function tofile(p::TabulaeStringParser, outfile)
#    CitableParserBuilder.tofile(stringParser(p), outfile)
#end

function stringParser(p::TabulaeStringParser)
    StringParser(p.entries, p.ortho, p.delimiter)
end

function datasource(p::TabulaeStringParser)
    p.entries
end


function delimiter(p::TabulaeStringParser)
    p.delimiter
end


function orthography(p::TabulaeStringParser)
    p.ortho
end

"""Write entries to file.
$(SIGNATURES)
"""
function tofile(p::TabulaeStringParser, f)
    open(f, "w") do io
        write(f, join(p.entries,"\n"))
    end
end

"""Instantiate a `TabulaeStringParser` for `td`.
$(SIGNATURES)
"""
function tabulaeStringParser(td::Tabulae.Dataset)
    #analysis_lines(td) |> TabulaeStringParser

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

"""Serialize a single analysis to delimited text.
$(SIGNATURES)
"""
function analysis_line(a::Analysis; delimiter = "|")
    pieces = [
        a.token,
        string(a.lexeme),
        string(a.form),
        string(a.stem),
        string(a.rule)
    ]
    join(pieces, delimiter)
end

"""Map `Analysis` objects to string values.
$(SIGNATURES)
"""
function analysis_lines(v::Vector{Analysis})
    map(a -> analysis_line(a), v)
end

"""Map all analyses in `td` to string values.
$(SIGNATURES)
"""
function analysis_lines(td::Tabulae.Dataset)
    analyses(td) |> analysis_lines
end

#=
"""Create an `Analysis` from line of delimited text.
$(SIGNATURES)
"""
function fromline(s::AbstractString; delimiter = "|")
    pieces = split(s,delimiter)
    Analysis(
        pieces[1], 
        LexemeUrn(pieces[2]),
        FormUrn(pieces[3]),
        StemUrn(pieces[4]),
        RuleUrn(pieces[5])
    )
end
=#


"""Generate all forms possible for `stem`.
$(SIGNATURES)
"""
function buildparseable(stem::TabulaeNounStem,  rules::Vector{Rule}) 
    generated = []        
    classrules = filter(rules) do r
        inflectionType(r) == inflectionType(stem) &&
        lmpGender(r) == lmpGender(stem)
    end
    @info("$(stem) matches rules $(classrules)")
    for rule in classrules
        token = string(stemvalue(stem), ending(rule))
        
        push!(generated, string(token, "|", lexemeurn(stem), "|", Tabulae.formurn(lmForm(rule)), "|", urn(stem), "|", urn(rule)))

    end
    generated
end


function buildparseable(stem::Stem,  rules::Vector{Rule})
    generated = []        
    classrules = filter(r -> inflectionType(r) == inflectionType(stem), rules)
    #@info("$(stem) matches rules $(classrules)")
    for rule in classrules
        token = string(stemvalue(stem), ending(rule))
        
        push!(generated, string(token, "|", lexemeurn(stem), "|", Tabulae.formurn(lmForm(rule)), "|", urn(stem), "|", urn(rule)))

    end
    generated
end



#=

function buildparseable(stem::Stem,  rules::Vector{Rule})
    generated = []        
    classrules = filter(r -> inflectionType(r) == inflectionType(stem), rules)
    #@info("$(stem) matches rules $(classrules)")
    for rule in classrules
        token = string(stemvalue(stem), ending(rule))
        
        push!(generated, string(token, "|", lexemeurn(stem), "|", Tabulae.formurn(lmForm(rule)), "|", urn(stem), "|", urn(rule)))

    end
    generated
end
=#