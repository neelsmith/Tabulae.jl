"A record for a single noun stem."
struct TabulaePronounStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    gender::LMPGender
    case::LMPCase
    number::LMPNumber
    inflectionclass::AbstractString 
end

"""Override Base.show for noun stem type.
$(SIGNATURES)
"""
function show(io::IO, noun::TabulaePronounStem)
    print(io, label(noun))
end

"""Override Base.== for pronoun stem type.
$(SIGNATURES)
"""
function ==(pn1::TabulaePronounStem, pn2::TabulaePronounStem)
    id(pn1) == id(pn2) &&
    lexeme(pn1) == lexeme(pn2) &&
    stemvalue(pn1) == stemvalue(pn2)  &&
    lmpGender(pn1) == lmpGender(pn2) &&
    lmpCase(pn1) == lmpCase(pn2) &&
    lmpNumber(pn1) == lmpNumber(pn2) &&

    inflectionclass(pn1) == inflectionclass(pn2)

end


CitableTrait(::Type{TabulaePronounStem}) = CitableByCite2Urn()
"""Pronoun stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaePronounStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaePronounStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(pns::TabulaePronounStem)
    string("Pronoun stem ", pns.form, "- (", label(pns.gender), ")")
end


"""Identifying URN for a `TabulaePronounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(pns::TabulaePronounStem; registry = nothing)
    if isnothing(registry)
        pns.stemid
    else
        expand(pns.stemid, registry)
    end
end



struct TabulaePronounStemCex <: CexTrait end
"""Pronoun stems are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaePronounStem})  
    TabulaePronounStemCex()
end

"""Compose CEX text for a `TabulaePronounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
"""
function cex(pns::TabulaePronounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        data = [
            id(pns), lexeme(pns), stemvalue(pns),
            label(lmpGender(pns)),label(lmpCase(pns)),label(lmpNumber(pns)),
            inflectionclass(pns)
        ]
        @debug("No registry: basic data $(data)")
        txt  = join(data, delimiter)

        @debug("Result is $(txt)")
        txt
    else
        c2urn = expand(id(pns), registry)
        lexurn = expand(lexeme(pns), registry)

        data = [c2urn, lexurn, stemvalue(pns),
            label(lmpGender(pns)),label(lmpCase(pns)),label(lmpNumber(pns)),
            inflectionclass(pns)
        ]
        join(data, delimiter)
    end
end



"""Instantiate a pronoun stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaePronounStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)

    @debug("$(length(parts)) parts: $(parts)")
    if length(parts) < 7
        throw(DomainError("Too few parts in $(delimited)"))
    else
        
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        stem = parts[3]
        @debug("Look at parts4 $(parts[4])")
        gender = lmpGender(parts[4])
        case = lmpCase(parts[5])
        number = lmpNumber(parts[6])
        inflclass = parts[7]

        @debug("Made gender object $(gender)")
        TabulaePronounStem(stemid,lexid,stem,gender,case, number, inflclass)
    end
end

"""Identifier for a `TabulaePronounStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(pn::TabulaePronounStem)
    pn.stemid
end

"""Lexeme for a `TabulaePronounStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(pn::TabulaePronounStem)
    pn.lexid
end

"""Gender for a `TabulaePronounStem`
$(SIGNATURES)
"""
function lmpGender(pn::TabulaePronounStem)
    pn.gender
end


"""Case for a `TabulaePronounStem`
$(SIGNATURES)
"""
function lmpCase(pn::TabulaePronounStem)
    pn.case
end

"""Number for a `TabulaePronounStem`
$(SIGNATURES)
"""
function lmpNumber(pn::TabulaePronounStem)
    pn.number
end


"""Identify inflection type for `noun`.
$(SIGNATURES)
"""
function inflectionclass(pronoun::TabulaePronounStem)
    pronoun.inflectionclass
end

"""Identify stem string for `pronoun`.
$(SIGNATURES)
"""
function stemvalue(pronoun::TabulaePronounStem)
    pronoun.form
end



"""Compose a digital code string for a pronoun form.
$(SIGNATURES)
"""
function code(pns::TabulaePronounStem)
      # PosPNTMVGCDCat
     string( PRONOUN,"0",code(pns.number),"000",code(pns.gender),code(pns.case),"00")
end



"""Compose an abbreviated URN for a rule from a `PronounStem`.

$(SIGNATURES)
"""
function formurn(pns::TabulaePronounStem; cite2urn = false)
    cite2urn ? Cite2Urn("$(BASE_MORPHOLOGY_URN)." * code(pns) ) :  FormUrn("latinforms." * code(pns))
end
