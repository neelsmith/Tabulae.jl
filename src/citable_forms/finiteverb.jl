"""Finite verbs have person, number, tense, mood and voice."""
struct LMFFiniteVerb <: LatinMorphologicalForm
    vperson::LMPPerson
    vnumber::LMPNumber
    vtense::LMPTense
    vmood::LMPMood
    vvoice::LMPVoice
end

"""Finite verb forms are citable by Cite2Urn"""
CitableTrait(::Type{LMFFiniteVerb}) = CitableByCite2Urn()

"""Compose a label for a `LMFFiniteVerb`

$(SIGNATURES)
"""
function label(verb::LMFFiniteVerb)
    join(
        [
        label(verb.vtense), 
        label(verb.vmood), 
        label(verb.vvoice),
        label(verb.vperson),  
        label(verb.vnumber)
        ], " ")
end

"""Compose a Cite2Urn for a `LMFFiniteVerb`.

$(SIGNATURES)
"""
function urn(verb::LMFFiniteVerb)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, FINITEVERB, code(verb.vperson),code(verb.vnumber), code(verb.vtense), code(verb.vmood), code(verb.vvoice),"0000"))
end


"""Create a `GMFFiniteVerb` from a string value.

$(SIGNATURES)
"""
function lmfFiniteVerb(code::AbstractString)
    morphchars = split(code,"")
    # PosPNTMVGCDCat
    
    tns = lmpTense(parse(Int64, morphchars[4]))
    md = lmpMood(parse(Int64, morphchars[5]))
    vc = lmpVoice(parse(Int64,morphchars[6]))
    prsn = lmpPerson(parse(Int64, morphchars[2]))
    nmbr = lmpNumber(parse(Int64, morphchars[3]))
    
    LMFFiniteVerb(
        prsn,
        nmbr,
        tns,
        md, 
        vc
    )
end


"""Create a `LMFFiniteVerb` from a `Cite2URN`.

$(SIGNATURES)
"""
function lmfFiniteVerb(urn::Cite2Urn)
    lmfFiniteVerb(objectcomponent(urn))
end


"""Create a `LMFFiniteVerb` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfFiniteVerb(f::FormUrn)
    lmfFiniteVerb(f.objectid)
end

"""Create a `LMFFiniteVerb` from an `Analysis`.

$(SIGNATURES)
"""
function lmfFiniteVerb(a::Analysis)
    lmfFiniteVerb(a.form)
end


"""Parse a string of SFST output into a `LMFFiniteVerb`.

$(SIGNATURES)
"""
function verbfromfst(fstdata)
    # Extract PNTMV from a string like this:
    #<3rd><sg><pft><indic><act>
    #verbrulere = r"<[^<]+><verb>[^<]*
    verbrulere = r"<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(verbrulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing

    else
        (p,n, t, m, v) = matchedup[1].captures
        LMFFiniteVerb(lmpPerson(p),lmpNumber(n),
        lmpTense(t), lmpMood(m), lmpVoice(v))        
    end
end

"""Compose URN for finite verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function irregularverbfromfst(fstdata)
    @warn("Reading irregular verbs from FST not yet implemented")
    nothing
end

#=

"""Compose a `LMFFiniteVerb` for a FormUrn.
"""
function verbfromurn(frm::FormUrn)
    digitchars = split(frm.objectid,"")
    p = parse(Int64, digitchars[2])
    n = parse(Int64, digitchars[3])
    t = parse(Int64, digitchars[4])
    m = parse(Int64, digitchars[5])
    v = parse(Int64, digitchars[6])
    LMFFiniteVerb(p,n,t,m,v)
end


"""Compose a FormUrn for a `LatinVerbForm`.

$(SIGNATURES)
"""
function formurn(verbform::LMFFiniteVerb)
    FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
    verbform.vtense, verbform.vmood, verbform.vvoice, "0000"))
end

=#