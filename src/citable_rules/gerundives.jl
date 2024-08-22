
"Inflectional rule for a gerundive form."
struct TabulaeGerundiveRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    ggender::LMPGender
    gcase::LMPCase
    gnumber::LMPNumber
end


"""Override Base.show for gerundive rule type.
$(SIGNATURES)
"""
function show(io::IO, grndv::TabulaeGerundiveRule)
    print(io, label(grndv))
end

"""Override Base.== for gerundive rule type.
$(SIGNATURES)
"""
function ==(g1::TabulaeGerundiveRule, g2::TabulaeGerundiveRule)
    g1.ruleid == g2.ruleid &&
    g1.inflectionclass == g2.inflectionclass &&
    g1.ending == g2.ending &&
    lmpGender(g1) == lmpGender(g2) && 
    lmpCase(g1) == lmpCase(g2) && 
    lmpNumber(g1) == lmpNumber(g2) 
end



CitableTrait(::Type{TabulaeGerundiveRule}) = CitableByCite2Urn()
"""Gerundive rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeGerundiveRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeGerundiveRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(r::TabulaeGerundiveRule)
    string("Gerundive inflection rule: ending -", r.ending, " in class ", r.inflectionclass, " can be ", label(r.ggender), " ", label(r.gcase), " ", label(r.gnumber), ".")
end

"""Identifying URN for a `TabulaeGerundiveRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(r::TabulaeGerundiveRule; registry = nothing)
    if isnothing(registry)
        r.ruleid
    else
        expand(r.ruleid, registry)
    end
end


struct TabulaeGerundiveRuleCex <: CexTrait end
"""Noun rules are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeGerundiveRule})  
    TabulaeGerundiveRuleCex()
end


"""Compose CEX text for a `TabulaeGerundiveRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(r::TabulaeGerundiveRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([urn(r), inflectionclass(r), ending(r),
        label(lmpGender(r)), label(lmpCase(r)), label(lmpNumber(r))
        ], delimiter)
    else
        c2urn = expand(r.ruleid, registry)
        join([c2urn, inflectionclass(r), ending(r),
        label(lmpGender(r)), label(lmpCase(r)), label(lmpNumber(r))], delimiter)
    end
end


"""Instantiate a gerundive rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeGerundiveRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 6
        msg = "Invalid syntax for gerundive rule: too few components in $(cexsrc)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflclass = parts[2]
        ending = parts[3]
        g = lmpGender(parts[4])
        c = lmpCase(parts[5])
        n = lmpNumber(parts[6])
 
        TabulaeGerundiveRule(ruleid, inflclass, ending, g,c,n)
    end
end


function lmpGender(r::TabulaeGerundiveRule)
    r.ggender
end

function lmpCase(r::TabulaeGerundiveRule)
    r.gcase
end

function lmpNumber(r::TabulaeGerundiveRule)
    r.gnumber
end


"""Identifier for a  `TabulaeGerundiveRule`, as an abbreviated URN.

$(SIGNATURES)
"""
function id(r::TabulaeGerundiveRule)
    r.ruleid
end

"""Create a `LMFNoun` form from a rule.
$(SIGNATURES)
"""
function latinForm(rule::TabulaeGerundiveRule)
    LMFGerundive(rule.ggender, rule.gcase, rule.gnumber)
end

"""Identify inflection type for `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::TabulaeGerundiveRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeGerundiveRule)
    rule.ending
end