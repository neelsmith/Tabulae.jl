"Inflectional rule for a noun rule."
struct TabulaeAdjectiveRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    adjgender::LMPGender
    adjcase::LMPCase
    adjnumber::LMPNumber
    adjdegree::LMPDegree
end


"""Override Base.show for adjective rule type.
$(SIGNATURES)
"""
function show(io::IO, adj::TabulaeAdjectiveRule)
    print(io, label(adj))
end

"""Override Base.== for noun rule type.
$(SIGNATURES)
"""
function ==(a1::TabulaeAdjectiveRule, a2::TabulaeAdjectiveRule)
    a1.ruleid == a2.ruleid &&
    a1.inflectionclass == a2.inflectionclass &&
    a1.ending == a2.ending &&
    lmpGender(a1) == lmpGender(a2) && 
    lmpCase(a1) == lmpCase(a2) && 
    lmpNumber(a1) == lmpNumber(a2)  &&
    lmpDegree(a1) == lmpDegree(a2)
end



CitableTrait(::Type{TabulaeAdjectiveRule}) = CitableByCite2Urn()
"""Adjective rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeAdjectiveRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeAdjedtiveRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adj::TabulaeAdjectiveRule)
    string("Adjective inflection rule: ending -", adj.ending, " in class ", adj.inflectionclass, " can be ", label(adj.adjgender), " ", label(adj.adjcase), " ", label(adj.adjnumber), " ", label(adj.adjdegree), ".")
end

"""Identifying URN for a `TabulaeAdjectiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::TabulaeAdjectiveRule; registry = nothing)
    if isnothing(registry)
        adj.ruleid
    else
        expand(adj.ruleid, registry)
    end
end



struct TabulaeAdjectiveRuleCex <: CexTrait end
"""Adjective rules are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeAdjectiveRule})  
    TabulaeAdjectiveRuleCex()
end


"""Compose CEX text for a `TabulaeAdjectiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::TabulaeAdjectiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        @info("Making adj cex with no registry")
        join([
            urn(adj), 
            inflectionclass(adj), ending(adj),
            label(lmpGender(adj)), label(lmpCase(adj)), label(lmpNumber(adj)), label(lmpDegree(adj))
        ], delimiter)
    else
        c2urn = expand(adj.ruleid, registry)
        join([c2urn, inflectionclass(adj), ending(adj),
        label(lmpGender(adj)), label(lmpCase(adj)), label(lmpNumber(adj)), label(lmpDegree(adj))], delimiter)
    end
end


"""Instantiate an adjective rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeAdjectiveRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 7
        msg = "Invalid syntax for adjective rule: too few components in $(cexsrc)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = lmpGender(parts[4])
        c = lmpCase(parts[5])
        n = lmpNumber(parts[6])
        d = lmpDegree(parts[7])
 
        TabulaeAdjectiveRule(ruleid, inflclass, ending, g,c,n, d)
    end
end

"""Instantiate an adjective rule from an adjective form and associated information.
$(SIGNATURES)
"""
function formrule(id::RuleUrn, infltype::AbstractString, ending::AbstractString, adj::LMFAdjective)
    TabulaeAdjectiveRule(id, infltype, ending,
    lmpGender(adj), lmpCase(adj), lmpNumber(adj), lmpDegree(adj)
    )
    
end

"""Create a `LMFAdjective` form from a rule.
$(SIGNATURES)
"""
function latinForm(adj::TabulaeAdjectiveRule)
    LMFAdjective(adj.adjgender, adj.adjcase, adj.adjnumber, adj.adjdegree)
end

"""Identify inflection type for `rule`.
$(SIGNATURES)
"""
function inflectionclass(adj::TabulaeAdjectiveRule)
    adj.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(adj::TabulaeAdjectiveRule)
    adj.ending
end


function lmpGender(adj::TabulaeAdjectiveRule)
    adj.adjgender
end

function lmpCase(adj::TabulaeAdjectiveRule)
    adj.adjcase
end

function lmpNumber(adj::TabulaeAdjectiveRule)
    adj.adjnumber
end

function lmpDegree(adj::TabulaeAdjectiveRule)
    adj.adjdegree
end
"""Identifier for a  `TabulaeNounRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(adj::TabulaeAdjectiveRule)
    adj.ruleid
end

