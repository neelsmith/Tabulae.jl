
# Single rule pattern for all irregular forms.


"Inflectional rule for irregular form."
struct TabulaeIrregularRule <: TabulaeRule
    ruleid::AbbreviatedUrn
    inflectionclass
end


"""Identify inflectional class for `irreg`.
$(SIGNATURES)
"""
function inflectionType(irreg::TabulaeIrregularRule)
    irreg.inflectionclass
end

function ending(irreg::TabulaeIrregularRule)
    ""
end


"""Irregular rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeIrregularRule}) = CitableByCite2Urn()


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

"""Instantiate `LatinMorphologicalForm` identified by `rule`.
$(SIGNATURES)
"""
function lmForm(rule::TabulaeIrregularRule) 
    nothing
end

#Don't need type-specific reader: just generic Irregular 

"""Implementation of reading one row of a rules table for irregular tokens.

$(SIGNATURES) 
"""
function readrulerow(ruleparser::IrregularReaderIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for irregular rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        TabulaeIrregularRule(ruleid, inflectionaltype)
    end
end


"""Compose CEX text for an `TabulaeIrregularRule`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(irreg::TabulaeIrregularRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([irreg.ruleid, label(irreg), inflectionclass(irreg)], delimiter)
    else
        c2urn = expand(ur.ruleid, registry)
        join([c2urn, label(irreg), inflectionclass(irreg)], delimiter)
    end
end

function ruleurn(irreg::TabulaeIrregularRule)
    irreg.ruleid
end



#=
"""Compose an abbreviated URN for a rule from a `VerbalAdjectiveRule`.

$(SIGNATURES)
"""
function formurn(irreg::TabulaeIrregularRule)
    #FormUrn(string("$(COLLECTION_ID).", irreg.ruleid))
    ruleurn(irreg)
end

=#