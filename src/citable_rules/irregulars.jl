
# Single rule pattern for all irregular forms.

"Inflectional rule for an irregular form."
struct TabulaeIrregularRule <: TabulaeRule
    ruleid::AbbreviatedUrn
    inflectionclass::AbstractString
end


"""Override Base.show for infinitive rule type.
$(SIGNATURES)
"""
function show(io::IO, irr::TabulaeIrregularRule)
    print(io, label(irr))
end

"""Override Base.== for infinitive rule type.
$(SIGNATURES)
"""
function ==(irr1::TabulaeIrregularRule, irr2::TabulaeIrregularRule)
    irr1.ruleid == irr2.ruleid &&
    irr1.inflectionclass == irr2.inflectionclass
end


CitableTrait(::Type{TabulaeIrregularRule}) = CitableByCite2Urn()
"""Rules for irregular forms are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeIrregularRule})
    CitableByCite2Urn()
end


"""Human-readlable label for an `TabulaeIrregularRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(irreg::TabulaeIrregularRule)
    string("Uninflected rule: ", irreg.ruleid, " applies to type ", inflectionclass(irreg), ".")
end

"""Identifying URN for a `UninflectedRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(irreg::TabulaeIrregularRule; registry = nothing)
    if isnothing(registry)
        irreg.ruleid
    else
        expand(irreg.ruleid, registry)
    end
end


struct TabulaeIrregularRuleCex <: CexTrait end
"""Rules for irregular forms are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeIrregularRule})  
    TabulaeIrregularRuleCex()
end

"""Compose CEX text for a `TabulaeIrregularRule`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
"""
function cex(irreg::TabulaeIrregularRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([irreg.ruleid, inflectionclass(irreg)], delimiter)
    else
        c2urn = expand(ur.ruleid, registry)
        join([c2urn, inflectionclass(irreg)], delimiter)
    end
end

"""Instantiate an infinitive rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeIrregularRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for irregular rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        TabulaeIrregularRule(ruleid, inflectionaltype)
    end
end

"""Identify inflectional class for `irreg`.
$(SIGNATURES)
"""
function inflectionclass(irreg::TabulaeIrregularRule)
    irreg.inflectionclass
end

function ending(irreg::TabulaeIrregularRule)
    ""
end

"""Instantiate `LatinMorphologicalForm` identified by `rule`.
$(SIGNATURES)
"""
function latinForm(rule::TabulaeIrregularRule) 
    nothing
end


function id(rule::TabulaeIrregularRule)
    rule.id
end

#=
function ruleurn(irreg::TabulaeIrregularRule)
    irreg.ruleid
end
=#


#=
"""Compose an abbreviated URN for a rule from a `VerbalAdjectiveRule`.

$(SIGNATURES)
"""
function formurn(irreg::TabulaeIrregularRule)
    #FormUrn(string("$(COLLECTION_ID).", irreg.ruleid))
    ruleurn(irreg)
end

=#