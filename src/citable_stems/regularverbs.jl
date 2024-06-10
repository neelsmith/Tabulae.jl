"A record for a single verb stem."
struct TabulaeVerbStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    inflectionclass
end

function id(n::TabulaeVerbStem)
    n.stemid
end


"""
Read one row of a stems table for noun tokens and create a `TabulaeNounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::VerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
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

"""Verb stems are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeVerbStem}) = CitableByCite2Urn()

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

"""Compose CEX text for a `TabulaeVerbStem`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(vs::TabulaeVerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vs.stemid, label(vs) ], delimiter)
    else
        c2urn = expand(vs.stemid, registry)
        join([c2urn, label(vs)], delimiter)
    end
end

"""Identifier for a `TabulaeVerbStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(vs::TabulaeVerbStem)
    vs.stemid
end

"""Lexeme for a `TabulaeNounStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexemeurn(vs::TabulaeVerbStem)
    vs.lexid
end

"""Identify inflection type for `noun`.
$(SIGNATURES)
"""
function inflectionType(vs::TabulaeVerbStem)
    vs.inflectionclass
end

"""Identify stem string for `noun`.
$(SIGNATURES)
"""
function stemvalue(vs::TabulaeVerbStem)
    vs.form
end
