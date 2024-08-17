
"Inflectional rule for a noun rule."
struct TabulaeNounRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    ngender::LMPGender
    ncase::LMPCase
    nnumber::LMPNumber
end

"""Override Base.show for noun rule type.
$(SIGNATURES)
"""
function show(io::IO, noun::TabulaeNounRule)
    print(io, label(noun))
end

"""Override Base.== for noun rule type.
$(SIGNATURES)
"""
function ==(n1::TabulaeNounRule, n2::TabulaeNounRule)
    n1.ruleid == n2.ruleid &&
    n1.inflectionclass == n2.inflectionclass &&
    n1.ending == n2.ending &&
    lmpGender(n1) == lmpGender(n2) && 
    lmpCase(n1) == lmpCase(n2) && 
    lmpNumber(n1) == lmpNumber(n2) 
end



CitableTrait(::Type{TabulaeNounRule}) = CitableByCite2Urn()
"""Noun rules are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeNounRule})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeNounRule`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(nr::TabulaeNounRule)
    string("Noun inflection rule: ending -", nr.ending, " in class ", nr.inflectionclass, " can be ", label(nr.ngender), " ", label(nr.ncase), " ", label(nr.nnumber), ".")
end

"""Identifying URN for a `TabulaeNounRule`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(nr::TabulaeNounRule; registry = nothing)
    if isnothing(registry)
        nr.ruleid
    else
        expand(nr.ruleid, registry)
    end
end



struct TabulaeNounRuleCex <: CexTrait end
"""Noun rules are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeNounRule})  
    TabulaeNounRuleCex()
end


"""Compose CEX text for a `TabulaeNounRule`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(nr::TabulaeNounRule; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([urn(nr), inflectionclass(nr), ending(nr),
        label(lmpGender(nr)), label(lmpCase(nr)), label(lmpNumber(nr))
        ], delimiter)
    else
        c2urn = expand(nr.ruleid, registry)
        join([c2urn, inflectionclass(nr), ending(nr),
        label(lmpGender(nr)), label(lmpCase(nr)), label(lmpNumber(nr))], delimiter)
    end
end


"""Instantiate a noun rule from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeNounRuleCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 6
        msg = "Invalid syntax for noun rule: too few components in $(cexsrc)"
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

"""Instantiate a noun rule from a noun form and associated information.
$(SIGNATURES)
"""
function formrule(id::RuleUrn, infltype::AbstractString, ending::AbstractString, noun::LMFNoun)

    @debug("Create noun form!")
    TabulaeNounRule(RuleUrn(id), infltype, ending,
    lmpGender(noun), lmpCase(noun), lmpNumber(noun)
    )
end

"""Create a `LMFNoun` form from a rule.
$(SIGNATURES)
"""
function latinForm(rule::TabulaeNounRule)
    LMFNoun(rule.ngender, rule.ncase, rule.nnumber)
end

"""Identify inflection type for `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::TabulaeNounRule)
    rule.inflectionclass
end

"""Identify ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::TabulaeNounRule)
    rule.ending
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
function formurn(rule::TabulaeNounRule)
    # PosPNTMVGCDCat
    FormUrn(string("tabulaeforms.", NOUN,"0",code(rule.nnumber),"000",code(rule.ngender),code(rule.ncase),"00"))
end
