"Inflectional rule for a pronoun rule."
struct TabulaeUninflectedRule <: TabulaeRule
    ruleid::RuleUrn
    uninflectedtype::LMPUninflectedType
end


"""Override Base.show for uninflected rule type.
$(SIGNATURES)
"""
function show(io::IO, uninfl::TabulaeUninflectedRule)
    print(io, label(uninfl))
end

"""Override Base.== for uninflected rule type.
$(SIGNATURES)
"""
function ==(uninfl1::TabulaeUninflectedRule, uninfl2::TabulaeUninflectedRule)
    uninfl1.ruleid == uninfl2.ruleid &&
    uninfl1.uninflectedtype == uninfl2.uninflectedtype
end

"""Unflected form rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeUninflectedRule}) = CitableByCite2Urn()
function citabletrait(::Type{TabulaeUninflectedRule})
    CitableByCite2Urn()
end


"""Human-readlable label for a `TabulaeUninflectedRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(uninfl::TabulaeUninflectedRule)
    string("Rule for uninflected form: type of rule ", uninfl.ruleid, " is ", uninfl.uninflectedtype)
end

"""Identifying URN for a `TabulaeUninflectedRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(uninfl::TabulaeUninflectedRule; registry = nothing)
    if isnothing(registry)
        uninfl.ruleid
    else
        expand(uninfl.ruleid, registry)
    end
end


struct TabulaeUninflectedRuleCex <: CexTrait end
import CitableBase: cextrait
function cextrait(::Type{TabulaeUninflectedRule})  
    TabulaeUninflectedRuleCex()
end


"""Compose CEX text for a `TabulaeUninflectedRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(uninfl::TabulaeUninflectedRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([uninfl.ruleid, inflectionclass(uninfl)], delimiter)
    else
        c2urn = expand(uninfl.ruleid, registry)
        join([c2urn, inflectionclass(uninfl)], delimiter)
    end
end


function fromcex(traitvalue::TabulaeUninflectedRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    ruleid = RuleUrn(parts[1])
    uninfltype = lmpUninflectedType(parts[2])
 
    TabulaeUninflectedRule(ruleid,uninfltype)
end




function inflectionclass(r::TabulaeUninflectedRule)
    string(r.uninflectedtype)
end

function ending(r::TabulaeUninflectedRule)
    ""
end


