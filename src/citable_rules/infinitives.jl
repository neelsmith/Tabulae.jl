
"Inflectional rule for a noun rule."
struct TabulaeInfinitiveRule <: TabulaeRule
    ruleid
    inflectionclass
    ending
    vtense::LMPTense
    vvoice::LMPVoice
end
#RuleUrn|InflectionClasses|Ending|Tense|Voice


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
function inflectionType(rule::TabulaeInfinitiveRule)
    rule.inflectionclass
end

"""Identify ending for infinitive `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeInfinitiveRule)
    rule.ending
end

"""Read one row of a rules table for verb tokens,
and create a `TabulaeInfinitiveRule`.

$(SIGNATURES) 
"""
function readrulerow(usp::InfinitiveIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
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

"""Infinitive rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeInfinitiveRule}) = CitableByCite2Urn()


"""Human-readlable label for a `TabulaeInfinitiveRule`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(rule::TabulaeInfinitiveRule)
    string("Infinitive inflection rule: ending -", rule.ending, " in class ", rule.inflectionclass, " can be ", " label(rule.vtense) ", label(rule.vvoice), ".")
end


"""Identifying URN for a `TabulaeInfinitiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(rule::TabulaeInfinitiveRule; registry = nothing)
    if isnothing(registry)
        rule.ruleid
    else
        expand(rule.ruleid, registry)
    end
end

"""Compose CEX text for a `TabulaeInfinitiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(rule::TabulaeInfinitiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([rule.ruleid, label(rule)], delimiter)
    else
        c2urn = expand(rule.ruleid, registry)
        join([c2urn, label(rule)], delimiter)
    end
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
