"""Finite verbs have person, number, tense, mood and voice."""
struct LatinFiniteVerb <: LatinMorphologicalForm
    vperson::Int64
    personlabel::AbstractString    
    vnumber::Int64
    numberlabel::AbstractString    
    vtense::Int64
    tenselabel::AbstractString   
    vmood::Int64
    moodlabel::AbstractString    
    vvoice::Int64
    voicelabel::AbstractString 
end

"""Compose a FormUrn for a `LatinVerbForm`.

$(SIGNATURES)
"""
function formurn(verbform::LatinFiniteVerb)
    FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
    verbform.vtense, verbform.vmood, verbform.vvoice, "000"))
end

"""Parse a string of SFST output into a `LatinFiniteVerb`.

$(SIGNATURES)
"""
function verbfromfst(fstdata)
    # Extract PNTMV from a string like this:
    #<pftact><verb>it<3rd><sg><pft><indic><act>
    verbrulere = r"<[^<]+><verb>[^<]*<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
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
        verbform = LatinFiniteVerb(persondict[p], p,
        numberdict[n], n,
        tensedict[t], t,
        mooddict[m], m,
        voicedict[v], v
        )        
    end
end
