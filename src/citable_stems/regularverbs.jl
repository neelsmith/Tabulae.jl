"A record for a single verb stem."
struct TabulaeVerbStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    inflectionclass
end


"""Override Base.show for verb stem type.
$(SIGNATURES)
"""
function show(io::IO, vb::TabulaeVerbStem)
    print(io, label(vb))
end

"""Override Base.== for verb stem type.
$(SIGNATURES)
"""
function ==(s1::TabulaeVerbStem, s2::TabulaeVerbStem)
    id(s1) == id(s2) &&
    lexeme(s1) == lexeme(s2) &&
    stemvalue(s1) == stemvalue(s2)  &&

    inflectionclass(s1) == inflectionclass(s2)
end




CitableTrait(::Type{TabulaeVerbStem}) = CitableByCite2Urn()
"""Verb stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeVerbStem})
    CitableByCite2Urn()
end


"""Human-readable label for a `TabulaeVerbStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(vs::TabulaeVerbStem)
    string("Verb stem ", vs.form, "-")
end


"""Identifying URN for a `TabulaeVerbStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(vs::TabulaeVerbStem; registry = nothing)
    if isnothing(registry)
        vs.stemid
    else
        expand(vs.stemid, registry)
    end
end


struct TabulaeVerbStemCex <: CexTrait end
"""Verb stems are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeVerbStem})  
    TabulaeVerbStemCex()
end


"""Compose CEX text for a `TabulaeVerbStem`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(s::TabulaeVerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([id(s), lexeme(s), stemvalue(s),
        inflectionclass(s)
        ], delimiter)
    else
        c2urn = expand(id(s), registry)
        join([c2urn, lexeme(s), stemvalue(s),
        inflectionclass(s)], delimiter)
    end
end



"""Instantiate a verb stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeVerbStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 4
        throw(DomainError("Too few parts in $(delimited)"))
    else
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        stem = parts[3]
        inflclass = parts[4]
        TabulaeVerbStem(stemid,lexid,stem,inflclass)
    end
end


"""Identifier for a `TabulaeVerbStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(vs::TabulaeVerbStem)
    vs.stemid
end

"""Lexeme for a `TabulaeVerbStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(vs::TabulaeVerbStem)
    vs.lexid
end

"""Identify inflection type for `verb`.
$(SIGNATURES)
"""
function inflectionclass(vs::TabulaeVerbStem)
    vs.inflectionclass
end

"""Identify stem string for `verb`.
$(SIGNATURES)
"""
function stemvalue(vs::TabulaeVerbStem)
    vs.form
end
