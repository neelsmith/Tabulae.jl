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


"""Parse a string of SFST output into a `LatinFiniteVerb`

$(SIGNATURES)
"""
function verbfromfst(fstdata)

    # Example rule string:
    #  "<w_regular><finiteverb>ει<third><singular><present><indicative><active>"
    # Extract PNTMV from a string like the example:
    verbrulere = r"<[^<]+><finiteverb>[^<]*<([^<]+)><([^<]+)><([^<]+)><([^<]+)><([^<]+)>"
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
        verbform = FiniteVerbForm(persondict[p], p,
        numberdict[n], n,
        tensedict[t], t,
        mooddict[m], m,
        voicedict[v], v
        )

        FormUrn(string("morphforms.", FINITEVERB,verbform.vperson, verbform.vnumber, 
        verbform.vtense, verbform.vmood, verbform.vvoice, "000"))
    end
end


#abduxit
#<u>latcommon.compoundn55_0</u><u>ls.n55</u><#>abdux<verb><pftact><div><pftact><verb>it<3rd><sg><pft><indic><act><u>latcommon.pftact_pft3</u>
