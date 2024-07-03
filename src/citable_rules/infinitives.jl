
"Inflectional rule for a noun rule."
struct TabulaeInfinitiveRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    vtense::LMPTense
    vvoice::LMPVoice
end

"""Override Base.show for infinitive rule type.
$(SIGNATURES)
"""
function show(io::IO, inf::TabulaeInfinitiveRule)
    print(io, label(inf))
end

"""Override Base.== for infinitive rule type.
$(SIGNATURES)
"""
function ==(inf1::TabulaeInfinitiveRule, inf2::TabulaeInfinitiveRule)
    inf1.ruleid == inf2.ruleid &&
    inf1.inflectionclass == inf2.inflectionclass &&
    inf1.ending == inf2.ending &&
    inf1.vtense == inf2.vtense && 
    inf1.vvoice == inf2.vvoice 
end



CitableTrait(::Type{TabulaeInfinitiveRule}) = CitableByCite2Urn()
"""Infinitive rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeInfinitiveRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeInfinitiveRule`.
$(SIGNATURES)
"""
function label(rule::TabulaeInfinitiveRule)
    string("Infinitive inflection rule: ending -", rule.ending, " in class ", rule.inflectionclass, " can be ", " label(rule.vtense) ", label(rule.vvoice), ".")
end


"""Identifying URN for a `TabulaeInfinitiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
"""
function urn(rule::TabulaeInfinitiveRule; registry = nothing)
    if isnothing(registry)
        rule.ruleid
    else
        expand(rule.ruleid, registry)
    end
end

struct TabulaeInfinitiveRuleCex <: CexTrait end
"""Infinitive rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeInfinitiveRule})  
    TabulaeInfinitiveRuleCex()
end

"""Compose CEX text for a `TabulaeInfinitiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(rule::TabulaeInfinitiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([id(rule), inflectionclass(rule), ending(rule),
        label(lmpTense(rule)), label(lmpVoice(rule))
        ], delimiter)
    else
        c2urn = expand(id(rule), registry)
        join([c2urn, inflectionclass(rule), ending(rule),
        label(lmpTense(rule)), label(lmpVoice(rule))], delimiter)
    end
end

"""Instantiate an infinitive rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeInfinitiveRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 5
        msg = "Invalid syntax for infinitive verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
    
        t = lmpTense(parts[4])
      
        v = lmpVoice(parts[5])
 
        TabulaeInfinitiveRule(ruleid, inflclass, ending,  t, v)
    end
end


"""Find tense value for infintive rule.
$(SIGNATURES)
"""
function lmpTense(r::TabulaeInfinitiveRule)
    r.vtense
end


"""Find voice value for infintive rule.
$(SIGNATURES)
"""
function lmpVoice(r::TabulaeInfinitiveRule)
    r.vvoice
end

function formrule(id::AbstractString, infltype::AbstractString, ending::AbstractString, inf::LMFInfinitive)
    @debug("INFINITIVE: $(inf)")
    TabulaeInfinitiveRule(id, infltype, ending,
    lmpTense(inf), lmpVoice(inf)
    )
end

"""Create a `LMFInfinitive` from `rule`.
$(SIGNATURES)
"""
function lmForm(rule::TabulaeInfinitiveRule)
    LMFInfinitive(rule.vtense, rule.vvoice)
end


"""Identify inflection type for infinitive `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::TabulaeInfinitiveRule)
    rule.inflectionclass
end

"""Identify ending for infinitive `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeInfinitiveRule)
    rule.ending
end

"""Identifier for a  `TabulaeInfinitiveRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(rule::TabulaeInfinitiveRule)
    rule.ruleid
end

"""Compose an abbreviated URN for a rule from a `TabulaeInfinitiveRule`.

$(SIGNATURES)
"""
function ruleurn(rule::TabulaeInfinitiveRule)
    # PosPNTMVGCDCat
    RuleUrn(string("tabulaeforms.", INFINITIVE,"00",code(rule.vtense), "0", code(rule.vvoice) ,"0000"))
end
