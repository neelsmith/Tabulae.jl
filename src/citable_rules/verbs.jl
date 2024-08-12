
"Inflectional rule for a noun rule."
struct TabulaeFiniteVerbRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    vperson::LMPPerson
    vnumber::LMPNumber
    vtense::LMPTense
    vmood::LMPMood
    vvoice::LMPVoice
end
#RuleUrn|InflectionClasses|Ending|Person|Number|Tense|Mood|Voice


"""Override Base.show for finite verb rule type.
$(SIGNATURES)
"""
function show(io::IO, v::TabulaeFiniteVerbRule)
    print(io, label(v))
end

"""Override Base.== for finite verb rule type.
$(SIGNATURES)
"""
function ==(v1::TabulaeFiniteVerbRule, v2::TabulaeFiniteVerbRule)
    id(v1) == id(v2)&&
    inflectionclass(v1) == inflectionclass(v2)  &&
    ending(v1) == ending(v2) &&

    lmpPerson(v1) == lmpPerson(v2) && 
    lmpNumber(v1) == lmpNumber(v2)  &&
    
    lmpTense(v1) == lmpTense(v2)  &&
    lmpMood(v1) == lmpMood(v2) && 
    lmpVoice(v1) == lmpVoice(v2)  
end



CitableTrait(::Type{TabulaeFiniteVerbRule}) = CitableByCite2Urn()
"""Participle rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeFiniteVerbRule})
    CitableByCite2Urn()
end



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



struct TabulaeFiniteVerbRuleCex <: CexTrait end
"""Verb rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeFiniteVerbRule})  
    TabulaeFiniteVerbRuleCex()
end



"""Compose CEX text for a `TabulaeFiniteVerbRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(rule::TabulaeFiniteVerbRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([
            urn(rule), inflectionclass(rule), ending(rule),
            label(lmpPerson(rule)), label(lmpNumber(rule)),
            label(lmpTense(rule)), 
            label(lmpMood(rule)),
            label(lmpVoice(rule))
        ], delimiter)
    else
        c2urn = expand(rule.ruleid, registry)
        join([c2urn, inflectionclass(rule), ending(rule),
        label(lmpPerson(rule)), label(lmpNumber(rule)),
        label(lmpTense(rule)), 
        label(lmpMood(rule)),
        label(lmpVoice(rule))
        ], delimiter)
    end
end


"""Instantiate a participle rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeFiniteVerbRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
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


function formrule(id::RuleUrn, infltype::AbstractString, ending::AbstractString, v::LMFFiniteVerb)
    TabulaeFiniteVerbRule(id, infltype, ending,
    lmpPerson(v), lmpNumber(v), lmpTense(v), 
    lmpMood(v), lmpVoice(v)
    )
end



function lmpPerson(v::TabulaeFiniteVerbRule)
    v.vperson
end


function lmpNumber(v::TabulaeFiniteVerbRule)
    v.vnumber
end

function lmpTense(v::TabulaeFiniteVerbRule)
    v.vtense
end

function lmpMood(v::TabulaeFiniteVerbRule)
    v.vmood
end

function lmpVoice(v::TabulaeFiniteVerbRule)
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
function inflectionclass(rule::TabulaeFiniteVerbRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeFiniteVerbRule)
    rule.ending
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
