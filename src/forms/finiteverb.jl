"""Finite verbs have person, number, tense, mood and voice."""
struct LMFFiniteVerb <: LatinMorphologicalForm
    vperson::LMPPerson
    vnumber::LMPNumber
    vtense::LMPTense
    vmood::LMPMood
    vvoice::LMPVoice
end



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
        persondict = labeldict(personpairs)
        numberdict = labeldict(numberpairs)
        tensedict = labeldict(tensepairs)
        mooddict = labeldict(moodpairs)
        voicedict = labeldict(voicepairs)
        verbform = LMFFiniteVerb(persondict[p],numberdict[n],
        tensedict[t], mooddict[m], voicedict[v])        
    end
end
