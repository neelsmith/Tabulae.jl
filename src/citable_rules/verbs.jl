
"Inflectional rule for a noun rule."
struct TabulaeFiniteVerbRule <: TabulaeRule
    ruleid
    inflectionclass
    ending
    vperson::LMPPerson
    vnumber::LMPNumber
    vtense::LMPTense
    vmood::LMPMood
    vvoice::LMPVoice
end
#RuleUrn|InflectionClasses|Ending|Person|Number|Tense|Mood|Voice


function formrule(id::AbstractString, infltype::AbstractString, ending::AbstractString, v::LMFFiniteVerb)
    TabulaeFiniteVerbRule(id, infltype, ending,
    lmpPerson(v), lmpNumber(v), lmpTense(v), 
    lmpMood(v), lmpVoice(v)
    )
end



function lmfPerson(v::TabulaeFiniteVerbRule)
    v.vperson
end



function lmfNumber(v::TabulaeFiniteVerbRule)
    v.vnumber
end

function lmfTense(v::TabulaeFiniteVerbRule)
    v.vtense
end

function lmfMoode(v::TabulaeFiniteVerbRule)
    v.vmood
end

function lmfVoice(v::TabulaeFiniteVerbRule)
    v.vvoice
end


"""Create a `LMFFiniteVerb` from `rule`.
$(SIGNATURES)
"""
function lmForm(rule::TabulaeFiniteVerbRule)
    LMFFiniteVerb(rule.vperson, rule.vnumber, rule.vtense, rule.vmood, rule.vvoice)
end


"""Identify inflection type for `rule`.
$(SIGNATURES)
"""
function inflectionType(rule::TabulaeFiniteVerbRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeFiniteVerbRule)
    rule.ending
end

"""Read one row of a rules table for verb tokens,
and create a `TabulaeFiniteVerbRule`.

$(SIGNATURES) 
"""
function readrulerow(usp::VerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 8
        msg = "Invalid syntax for finite verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        p = lmpPerson(parts[4])
        n = lmpNumber(parts[5])
        t = lmpTense(parts[6])
        m = lmpMood(parts[7])
        v = lmpVoice(parts[8])
 
        TabulaeFiniteVerbRule(ruleid, inflclass, ending, p, n, t, m, v)
    end
    
end

"""Verb rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeFiniteVerbRule}) = CitableByCite2Urn()


"""Human-readlable label for a `TabulaeFiniteVerbRule`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(rule::TabulaeFiniteVerbRule)
    string("Verb inflection rule: ending -", rule.ending, " in class ", rule.inflectionclass, " can be ", label(rule.vperson), " ", label(rule.vnumber), " ", label(rule.vtense), " ", label(rule.vmood), " ", label(rule.vvoice), ".")
end


"""Identifying URN for a `TabulaeFiniteVerbRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(rule::TabulaeFiniteVerbRule; registry = nothing)
    if isnothing(registry)
        rule.ruleid
    else
        expand(rule.ruleid, registry)
    end
end

"""Compose CEX text for a `TabulaeFiniteVerbRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(rule::TabulaeFiniteVerbRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([rule.ruleid, label(rule)], delimiter)
    else
        c2urn = expand(rule.ruleid, registry)
        join([c2urn, label(rule)], delimiter)
    end
end

"""Identifier for a  `TabulaeFiniteVerbRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(rule::TabulaeFiniteVerbRule)
    rule.ruleid
end

"""Compose an abbreviated URN for a rule from a `TabulaeFiniteVerbRule`.

$(SIGNATURES)
"""
function ruleurn(rule::TabulaeFiniteVerbRule)
    # PosPNTMVGCDCat
    RuleUrn(string("tabulaeforms.", FINITEVERB,code(rule.vperson),code(rule.vnumber),code(rule.vtense), code(rule.vmood), code(rule.vvoice) ,"0000"))
end
