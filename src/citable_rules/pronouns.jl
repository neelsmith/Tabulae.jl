"Inflectional rule for a pronoun rule."
struct TabulaePronounRule <: TabulaeRule
    ruleid::RuleUrn
    pronountype::AbstractString
end

"""Override Base.show for pronoun rule type.
$(SIGNATURES)
"""
function show(io::IO, pronoun::TabulaePronounRule)
    print(io, label(pronoun))
end




function ==(pn1::TabulaePronounRule, pn2::TabulaePronounRule)
    pn1.ruleid == pn2.ruleid &&
    pn1.pronountype == pn2.pronountype
end

"""Pronoun rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaePronounRule}) = CitableByCite2Urn()
function citabletrait(::Type{TabulaePronounRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaePronounRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(pnr::TabulaePronounRule)
    string("Pronoun inflection rule: type of stem ", pnr.ruleid, " is ", pnr.pronountype)
end

"""Identifying URN for a `TabulaePronounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(pnr::TabulaePronounRule; registry = nothing)
    if isnothing(registry)
        pnr.ruleid
    else
        expand(pnr.ruleid, registry)
    end
end




struct TabulaePronounRuleCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{TabulaePronounRule})  
    TabulaePronounRuleCex()
end


"""Compose CEX text for a `TabulaePronounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(pnr::TabulaePronounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([pnr.ruleid, inflectionclass(pnr)], delimiter)
    else
        c2urn = expand(pnr.ruleid, registry)
        join([c2urn, inflectionclass(pnr)], delimiter)
    end
end


function fromcex(traitvalue::TabulaePronounRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    ruleid = RuleUrn(parts[1])
    pronountype = parts[2]
 
    TabulaePronounRule(ruleid,pronountype)
end

"""Identify inflectional class for `pron`.
$(SIGNATURES)
"""
function inflectionclass(pron::TabulaePronounRule)
    pron.pronountype
end



function ending(rule::TabulaePronounRule)
    ""
end

"""Compose an abbreviated URN for a rule from a `PronounStem`.

$(SIGNATURES)
"""
function ruleurn(rule::TabulaePronounRule)
    rule.ruleid
end