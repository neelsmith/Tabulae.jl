
"Inflectional rule for a noun rule."
struct TabulaeParticipleRule <: TabulaeRule
    ruleid
    inflectionclass
    ending
    pgender::LMPGender
    pcase::LMPCase
    pnumber::LMPNumber
    ptense::LMPTense
    pvoice::LMPVoice
end

#RuleUrn|InflectionClasses|Ending|Gender|Case|Number|Tense|Voice

function formrule(id::AbstractString, infltype::AbstractString, ending::AbstractString, p::LMFParticiple)
    TabulaeParticipleRule(id, infltype, ending,
    lmpGender(p), lmpCase(p), lmpNumber(p),
    lmpTense(p), lmpVoice(p)
    )
end

function lmpGender(p::TabulaeParticipleRule)
    p.pgender
end

function lmpCase(p::TabulaeParticipleRule)
    p.pcase
end

function lmpNumber(p::TabulaeParticipleRule)
    p.pnumber
end

function lmpTense(p::TabulaeParticipleRule)
    p.ptense
end

function lmpVoice(p::TabulaeParticipleRule)
    p.pvoice
end


"""Create a `LMFParticiple` from `rule`.
$(SIGNATURES)
"""
function lmForm(rule::TabulaeParticipleRule)
    LMFParticiple(rule.pgender, rule.pcase, rule.pnumber, rule.ptense, rule.pvoice)
end


"""Identify inflection type for participle `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::TabulaeParticipleRule)
    rule.inflectionclass
end

"""Identify ending for a participle `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeParticipleRule)
    rule.ending
end

"""Read one row of a rules table for verb tokens,
and create a `TabulaeParticipleRule`.

$(SIGNATURES) 
"""
function readrulerow(usp::ParticipleIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 8
        msg = "Invalid syntax for participle verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        @debug("readrulerow: here are the parts: $(parts)")
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = lmpGender(parts[4])
        c = lmpCase(parts[5])
        n = lmpNumber(parts[6])

        t = lmpTense(parts[7])
      
        v = lmpVoice(parts[8])
 
        TabulaeParticipleRule(ruleid, inflclass, ending, g, c, n, t, v)
    end
    
end

"""Participle rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeParticipleRule}) = CitableByCite2Urn()


"""Human-readlable label for a `TabulaeParticipleRule`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(rule::TabulaeParticipleRule)
    string("Participle inflection rule: ending -", rule.ending, " in class ", rule.inflectionclass, " can be ", label(rule.ptense), " ", label(rule.pvoice), "participle, ", label(rule.vgender), " ", label(rule.pcase), " ", label(rule.pnumber), ".")
end


"""Identifying URN for a `TabulaeParticipleRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(rule::TabulaeParticipleRule; registry = nothing)
    if isnothing(registry)
        rule.ruleid
    else
        expand(rule.ruleid, registry)
    end
end

"""Compose CEX text for a `TabulaeParticipleRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(rule::TabulaeParticipleRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([rule.ruleid, label(rule)], delimiter)
    else
        c2urn = expand(rule.ruleid, registry)
        join([c2urn, label(rule)], delimiter)
    end
end

"""Identifier for a  `TabulaeParticipleRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(rule::TabulaeParticipleRule)
    rule.ruleid
end

"""Compose an abbreviated URN for a rule from a `TabulaeParticipleRule`.

$(SIGNATURES)
"""
function ruleurn(rule::TabulaeParticipleRule)
    # PosPNTMVGCDCat
    RuleUrn(string("forms.", PARTICIPLE,"0", code(p.pnumber),code(p.tense),"0", code(p.voice),code(p.gender),code(p.case),"00"))
end
