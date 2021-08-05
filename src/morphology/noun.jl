"""Nouns have gender, case and number."""
struct LatinNoun <: LatinMorphologicalForm
    ngender::Int64
    genderlabel::AbstractString    
    ncase::Int64
    caselabel::AbstractString    
    nnumber::Int64
    numberlabel::AbstractString    
end

"""Compose a FormUrn for a `LatinNoun`.

$(SIGNATURES)
"""
function formurn(noun::LatinNoun)
    FormUrn(string("morphforms.",  NOUN,"0",
    noun.nnumber,"000",noun.ngender,noun.ncase,"00"))
end

"""Parse a string of SFST output into a `LatinNoun`.

$(SIGNATURES)
"""
function nounfromfst(fstdata)
    nounrulere = r"<([^<]+)><([^<]+)>[^>]*<([^<]+)><([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(nounrulere, fstdata))
    
    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\"")
        nothing
    else
        # 1="h_hs", 2="noun", 3="feminine", 4="accusative", 5="singular")

        (nounclass,pos, g,c,n) = matchedup[1].captures
        
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)

        LatinNoun(genderdict[g], g,
        casedict[c], c,
        numberdict[n], n)
        #FormUrn(string("morphforms.", NOUN,"0",nounform.nnumber,"000",nounform.ngender,nounform.ncase,"00"))
    end

end