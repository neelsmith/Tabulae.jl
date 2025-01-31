"A record for a single noun stem."
struct TabulaeAdjectiveStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    inflectionclass::AbstractString
end

"""Override Base.show for adjective stem type.
$(SIGNATURES)
"""
function show(io::IO, adj::TabulaeAdjectiveStem)
    print(io, label(adj))
end

"""Override Base.== for adjective stem type.
$(SIGNATURES)
"""
function ==(a1::TabulaeAdjectiveStem, a2::TabulaeNounStem)
    id(a1) == id(a2) &&
    lexeme(a1) == lexeme(a2) &&
    stemvalue(a1) == stemvalue(a2) &&

    inflectionclass(a1) == inflectionclass(a2)

end


CitableTrait(::Type{TabulaeAdjectiveStem}) = CitableByCite2Urn()
"""Adjective stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeAdjectiveStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeAdjectiveStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adj::TabulaeAdjectiveStem)
    string("Adjective stem ", adj.form, "-")
end


"""Identifying URN for a `TabulaeAdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::TabulaeAdjectiveStem; registry = nothing)
    if isnothing(registry)
        adj.stemid
    else
        expand(adj.stemid, registry)
    end
end



struct TabulaeAdjectiveStemCex <: CexTrait end
"""Adjective stems are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeAdjectiveStem})  
    TabulaeAdjectiveStemCex()
end

"""Compose CEX text for a `TabulaeAdjectiveStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
"""
function cex(adj::TabulaeAdjectiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([id(adj), lexeme(adj), stemvalue(adj),
        inflectionclass(adj)
        ], delimiter)
    else
        c2urn = expand(id(adj), registry)
        join([c2urn,  lexeme(adj), stemvalue(adj),
        inflectionclass(adj)], delimiter)
    end
end

"""Instantiate an adjective stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeAdjectiveStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    @debug("Parts: $(parts)")
    if length(parts) < 4
        throw(DomainError("AdjectiveStem from CEX: too few parts in $(delimited)"))
    else
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        stem = parts[3]
        inflclass = parts[4]
        TabulaeAdjectiveStem(stemid,lexid,stem,inflclass)
    end
end

"""Identifier for a `TabulaeAdjectiveStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(adj::TabulaeAdjectiveStem)
    adj.stemid
end

"""Lexeme for a `TabulaeAdjectiveStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(adj::TabulaeAdjectiveStem)
    adj.lexid
end


"""Identify inflection type for an adjective.
$(SIGNATURES)
"""
function inflectionclass(adj::TabulaeAdjectiveStem)
    adj.inflectionclass
end

"""Identify stem string for `noun`.
$(SIGNATURES)
"""
function stemvalue(adj::TabulaeAdjectiveStem)
    adj.form
end
