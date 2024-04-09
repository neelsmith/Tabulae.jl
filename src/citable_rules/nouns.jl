
"Inflectional rule for a noun rule."
struct TabulaeNounRule <: TabulaeRule
    ruleid
    inflectionclass
    ending
    ngender::LMPGender
    ncase::LMPCase
    nnumber::LMPNumber
end

"""Create a `LMFNoun` form from a rule.
$(SIGNATURES)
"""
function lmForm(rule::TabulaeNounRule)
    LMFNoun(rule.ngender, rule.ncase, rule.nnumber)
end


"""Identify inflection type for `rule`.
$(SIGNATURES)
"""
function inflectionType(rule::TabulaeNounRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeNounRule)
    rule.ending
end

"""Read one row of a rules table for noun tokens,
and create a `TabulaeNounRule`.

$(SIGNATURES) 
"""
function readrulerow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    
    if length(parts) < 6
        msg = "Invalid syntax for noun rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = lmpGender(parts[4])
        c = lmpCase(parts[5])
        n = lmpNumber(parts[6])
 
        TabulaeNounRule(ruleid, inflclass, ending, g,c,n)
    end
    
end


function lmpGender(r::TabulaeNounRule)
    r.ngender
end

function lmpCase(r::TabulaeNounRule)
    r.ncase
end

function lmpNumber(r::TabulaeNounRule)
    r.nnumber
end

"""Noun rules are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeNounRule}) = CitableByCite2Urn()


"""Human-readlable label for a `TabulaeNounRule`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(nr::TabulaeNounRule)
    string("Noun inflection rule: ending -", nr.ending, " in class ", nr.inflectionclass, " can be ", label(nr.ngender), " ", label(nr.ncase), " ", label(nr.nnumber), ".")
end


"""Identifying URN for a `TabulaeNounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(nr::TabulaeNounRule; registry = nothing)
    if isnothing(registry)
        nr.ruleid
    else
        expand(nr.ruleid, registry)
    end
end

"""Compose CEX text for a `TabulaeNounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(nr::TabulaeNounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([nr.ruleid, label(nr)], delimiter)
    else
        c2urn = expand(nr.ruleid, registry)
        join([c2urn, label(nr)], delimiter)
    end
end

"""Identifier for a  `TabulaeNounRule`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::TabulaeNounRule)
    n.ruleid
end

"""Compose an abbreviated URN for a rule from a `TabulaeNounRule`.

$(SIGNATURES)
"""
function ruleurn(rule::TabulaeNounRule)
    # PosPNTMVGCDCat
    RuleUrn(string("tabulaeforms.", NOUN,"0",code(rule.nnumber),"000",code(rule.ngender),code(rule.ncase),"00"))
end
