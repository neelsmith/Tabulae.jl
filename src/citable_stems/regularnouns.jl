"A record for a single noun stem."
struct TabulaeNounStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    gender::LMPGender
    inflectionclass::AbstractString
end

"""Override Base.show for noun stem type.
$(SIGNATURES)
"""
function show(io::IO, noun::TabulaeNounStem)
    print(io, label(noun))
end

"""Override Base.== for noun stem type.
$(SIGNATURES)
"""
function ==(n1::TabulaeNounStem, n2::TabulaeNounStem)
    id(n1) == id(n2) &&
    lexeme(n1) == lexeme(n2) &&
    stemvalue(n1) == stemvalue(n2)  &&
    lmpGender(n1) == lmpGender(n2) &&

    inflectionclass(n1) == inflectionclass(n2)

end


CitableTrait(::Type{TabulaeNounStem}) = CitableByCite2Urn()
"""Noun stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeNounStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeNounStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::TabulaeNounStem)
    string("Noun stem ", ns.form, "- (", label(ns.gender), ")")
end


"""Identifying URN for a `TabulaeNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::TabulaeNounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end



struct TabulaeNounStemCex <: CexTrait end
"""Noun stems are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeNounStem})  
    TabulaeNounStemCex()
end

"""Compose CEX text for a `TabulaeNounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
"""
function cex(ns::TabulaeNounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([id(ns), lexeme(ns), stemvalue(ns),
        label(lmpGender(ns)),
        inflectionclass(ns)
        ], delimiter)
    else
        c2urn = expand(id(ns), registry)
        join([c2urn,  lexeme(ns), stemvalue(ns),
        label(lmpGender(ns)),
        inflectionclass(ns)], delimiter)
    end
end



"""Instantiate a noun stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeNounStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)

    @debug("Parts: $(parts)")
    if length(parts) < 5
        throw(DomainError("Too few parts in $(delimited)"))
    else
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        stem = parts[3]
        @debug("Look at parts4 $(parts[4])")
        gender = lmpGender(parts[4])
        inflclass = parts[5]

        @debug("Made gender object $(gender)")
        TabulaeNounStem(stemid,lexid,stem,gender,inflclass)
    end
end

"""Identifier for a `TabulaeNounStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::TabulaeNounStem)
    n.stemid
end

"""Lexeme for a `TabulaeNounStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(n::TabulaeNounStem)
    n.lexid
end

"""Gender for a `TabulaeNounStem`
$(SIGNATURES)
"""
function lmpGender(n::TabulaeNounStem)
    n.gender
end

"""Identify inflection type for `noun`.
$(SIGNATURES)
"""
function inflectionclass(noun::TabulaeNounStem)
    noun.inflectionclass
end

"""Identify stem string for `noun`.
$(SIGNATURES)
"""
function stemvalue(noun::TabulaeNounStem)
    noun.form
end
