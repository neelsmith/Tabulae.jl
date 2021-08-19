"""Nouns have gender, case and number."""
struct LatinNoun <: LatinMorphologicalForm
    ngender::Int64 
    ncase::Int64
    nnumber::Int64
end


"""Compose a `LatinNoun` for a FormUrn.
"""
function nounfromurn(frm::FormUrn)
end

"""Compose a FormUrn for a `LatinNoun`.

$(SIGNATURES)
"""
function formurn(noun::LatinNoun)
    FormUrn(string("morphforms.",  NOUN,"0",
    noun.nnumber,"000",noun.ngender,noun.ncase,"00"))
end

"""Parse a string of SFST output into a `LatinNoun` form.

$(SIGNATURES)
"""
function nounfromfst(fstdata)
    nounrulere = r"<([^<]+)><([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(nounrulere, fstdata))
    
    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\"")
        nothing

    else
        (g,c,n) = matchedup[1].captures
        
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)

        LatinNoun(genderdict[g], casedict[c], numberdict[n])
    end

end