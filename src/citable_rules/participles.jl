
"Inflectional rule for a noun rule."
struct TabulaeParticipleRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    pgender::LMPGender
    pcase::LMPCase
    pnumber::LMPNumber
    ptense::LMPTense
    pvoice::LMPVoice
end
#RuleUrn|InflectionClasses|Ending|Gender|Case|Number|Tense|Voice


"""Override Base.show for participle rule type.
$(SIGNATURES)
"""
function show(io::IO, p::TabulaeParticipleRule)
    print(io, label(p))
end

"""Override Base.== for participle rule type.
$(SIGNATURES)
"""
function ==(p1::TabulaeParticipleRule, p2::TabulaeParticipleRule)
    id(p1) == id(p2)&&
    inflectionclass(p2) == inflectionclass(p2)  &&
    ending(p1) == ending(p2) &&
    lmpGender(p1) == lmpGender(p2) && 
    lmpCase(p1) == lmpCase(p2) && 
    lmpNumber(p1) == lmpNumber(p2)  &&

    lmpTense(p1) == lmpTense(p2)  &&
    lmpVoice(p1) == lmpVoice(p2)  
end



CitableTrait(::Type{TabulaeParticipleRule}) = CitableByCite2Urn()
"""Participle rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeParticipleRule})
    CitableByCite2Urn()
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

"""Human-readlable label for a `TabulaeParticipleRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(rule::TabulaeParticipleRule)
    string("Participle inflection rule: ending -", rule.ending, " in class ", rule.inflectionclass, " can be ", label(rule.ptense), " ", label(rule.pvoice), "participle, ", label(rule.pgender), " ", label(rule.pcase), " ", label(rule.pnumber), ".")
end



struct TabulaeParticipleRuleCex <: CexTrait end
"""Participle rules are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeParticipleRule})  
    TabulaeParticipleRuleCex()
end


"""Compose CEX text for a `TabulaeParticipleRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(rule::TabulaeParticipleRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([
            urn(rule), inflectionclass(rule), ending(rule),
            label(lmpGender(rule)), label(lmpCase(rule)), label(lmpNumber(rule)),
            label(lmpTense(rule)), label(lmpVoice(rule))
        ], delimiter)
    else
        c2urn = expand(nr.ruleid, registry)
        join([c2urn, inflectionclass(rule), ending(rule),
        label(lmpGender(rule)), label(lmpCase(rule)), label(lmpNumber(rule)),
        label(lmpTense(rule)), label(lmpVoice(rule))
        
        ], delimiter)
    end
end

"""Instantiate a participle rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeParticipleRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 8
        msg = "Invalid syntax for participle verb rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
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


function formrule(id::RuleUrn, infltype::AbstractString, ending::AbstractString, p::LMFParticiple)
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
