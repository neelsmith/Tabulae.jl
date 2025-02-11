"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct TabulaeStringParser <: CitableParser
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




"""Find all analyses that can be composed from
the stems and rules in a given dataset.
$(SIGNATURES)
"""
function analyses(ds::Tabulae.Dataset)
    analysisvect = []
    rules = rulesarray(ds)
    for stem in stemsarray(ds)
        for a in analyses(stem, rules)
            push!(analysisvect, a)
        end
    end
    analysisvect
end

"""Find all analyses for a given lexeme in a given dataset.
$(SIGNATURES)
"""
function analyses(lex::LexemeUrn, ds::Tabulae.Dataset)
    analysisvect = []
    stems = filter(st -> lexeme(st) == lex, stemsarray(ds)) 
    rules = rulesarray(ds)
    for stem in stems
        for a in analyses(stem, rules)
            push!(analysisvect, a)
        end
    end
    analysisvect
end


"""True if form IDs are built from the `Rule` of a
stem-rule pair.
$(SIGNATURES)
"""
function buildfromrule(r::T) where {T <: TabulaeRule}
    isa(r, TabulaePronounRule) == false  &&
    isa(r, TabulaeUninflectedRule)  ==  false &&    
    (r isa TabulaeIrregularRule) == false
end


"""True if a form ID can be built from a given stem.
$(SIGNATURES)
"""
function buildfromstem(st::T) where {T <: TabulaeStem}
    isa(st, TabulaePronounStem)  ||
    isa(st, TabulaeUninflectedStem)  ||
    isa(st, TabulaeIrregularStem) 
end

"""True if a form ID can be built from a given morphological form object.
$(SIGNATURES)
"""
function buildfromstem(frm::T)::Vector{String} where {T <: LatinMorphologicalForm}
    isa(st, LMFPronoun)  ||
    isa(st, TabulaeUninflectedStem)  ||
    isa(st, TabulaeIrregularStem) 
end

"""Find all possible analyses from crossing a given stem with a set of rules.
$(SIGNATURES)
"""
function analyses(stem::S, rules::Vector{Rule}; delimiter = "|")::Vector{Analysis} where S <: Union{TabulaeStem, TabulaeIrregularStem}
    generated = Analysis[]


    initialCP = 64
    if stem isa TabulaeNounStem
        classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && lmpGender(r) == lmpGender(stem), rules)
        for (idx, rule) in enumerate(classrules)
            tokenid = "A" # Char(initialCP + idx) |> string
            @debug("Cross $stem with $(rule)")
            push!(generated, analysis(stem,rule; tokenid = tokenid))
        end
    else
        classrules = filter(r -> inflectionclass(r) == inflectionclass(stem), rules)
        for (idx, rule) in enumerate(classrules)
            #tokenid = Char(initialCP + idx) |> string
            tokenid = "A"
            push!(generated, analysis(stem,rule; tokenid = tokenid))
        end
    end
    generated
end




function analysisforencliticseq(a::Analysis, otoken::AbstractString, mtokenid::AbstractString)
    Analysis(
        otoken,
        lexemeurn(a),
        CitableParserBuilder.formurn(a),
        stemurn(a),
        CitableParserBuilder.ruleurn(a),
        mtoken(a),
        mtokenid
    )
end



enclitics = ["que", "ve", "ne", "cum","n'"]


"""Parse a Latin orthographic token, checking for possibility of enclitics.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, parser::TabulaeStringParser; verbose = false)
    ptrn = lowercase(s) * delimiter(parser)
    verbose ? @warn("Looking for $(s) in parser data") :     @debug("Looking for $(s) in parser data")
    matches = filter(ln -> startswith(ln, ptrn), datasource(parser))
    @debug("Got $(matches)")
    
    if isempty(matches)
        # Try again for enclitics if result is empty!    
        results = Analysis[]
        endings = orthography(parser) isa Latin23 ? map(enc -> replace(enc, "v" => "u"), enclitics) : enclitics
        for e in endings
            vebose ? @warn("Check for enclitic $(e) in string $(s)") :        @info("Check for enclitic $(e) in string $(s)")
            if endswith(s,e) && ! isequal(s,e)
                verbose ? @warn("Found  possible  enclitic") :    @debug("Found  possible  enclitic")
                
                rng = findlast(e, s)
                lastch = rng[1] - 1
                mtkn = s[1:lastch]
                otkn = s
                verbose ? @warn("Tokens: $(tkn) + $(e)") : @debug("Tokens: $(tkn) + $(e)")
                for prs in parsetoken(mtkn, parser)
                    push!(results, analysisforencliticseq(prs, s, "A"))
                end

                for prs in parsetoken(e, parser)
                    push!(results, analysisforencliticseq(prs, s, "B"))
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




"""Instantiate a generic `StringParser` (from the `CitableParserBuilder` package) from a `TabulaeStringParser`.
$(SIGNATURES)
"""
function stringParser(p::TabulaeStringParser)
    StringParser(p.entries, p.ortho, p.delimiter)
end


function tsp(tds::Tabulae.Dataset; ortho = latin25(), delimiter = "|")
    tabulaeStringParser(tds; ortho = ortho, delimiter = delimiter)
end

"""Instantiate a `TabulaeStringParser` from a set of analyses read from a local file.
$(SIGNATURES)
"""
function tabulaeStringParser(f, freader::Type{FileReader}; ortho = latin25(), delimiter = "|")
    TabulaeStringParser(readlines(f), ortho, delimiter)
end

"""Instantiate a `TabulaeStringParser` from a set of analyses read from a URL.
$(SIGNATURES)
"""
function tabulaeStringParser(u, ureader::Type{UrlReader}; ortho = latin25(), delimiter = "|")
    tmpfile = Downloads.download(u) 
    sp = TabulaeStringParser(readlines(tmpfile), ortho, delimiter )
    rm(tmpfile)
    sp
end

"""Instantiate a `TabulaeStringParser` for `td`.
$(SIGNATURES)
"""
function tabulaeStringParser(tds::Tabulae.Dataset; ortho = latin25(), delimiter = "|")
    TabulaeStringParser(cex.(analyses(tds)), ortho, delimiter)
end
