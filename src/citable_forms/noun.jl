"""Nouns have gender, case and number."""
struct LMFNoun <: LatinMorphologicalForm
    ngender::LMPGender
    ncase::LMPCase
    nnumber::LMPNumber
end

"""Noun forms are citable by Cite2Urn"""
CitableTrait(::Type{LMFNoun}) = CitableByCite2Urn()

"""Compose a label for a `LMFNoun`

$(SIGNATURES)
"""
function label(noun::LMFNoun)    
    join([ label(noun.ngender), label(noun.ncase), label(noun.nnumber)], " ")
end


"""Compose a Cite2Urn for a `LMFNoun`.

$(SIGNATURES)
"""
function urn(noun::LMFNoun)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, NOUN,"0",code(noun.nnumber),"000",code(noun.ngender),code(noun.ncase),"00"))
end

"""Create a `GMFNoun` from a string value.

$(SIGNATURES)
"""
function lmfNoun(code::AbstractString)
    morphchars = split(code, "")
    ngender = lmpGender(parse(Int64, morphchars[7]))
    ncase = lmpCase(parse(Int64, morphchars[8]))
    nnumber = lmpNumber(parse(Int64,morphchars[3]))
    
    LMFNoun(ngender, ncase, nnumber)
end

"""Create a `LMFNoun` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfNoun(urn::Cite2Urn)
    lmfNoun(objectcomponent(urn))
end

"""Create a `GMFNoun` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfNoun(f::FormUrn)
    lmfNoun(f.objectid)
end


"""Compose a `FormUrn` for a `LMFNoun`.

$(SIGNATURES)
"""
function formurn(lmfNoun::LMFNoun)
    FormUrn(string("forms.", NOUN,"0",code(lmfNoun.nnumber),"000", code(lmfNoun.ngender), code(lmfNoun.ncase), "00"))
end


"""Find gender of a `LMFNoun`.

$(SIGNATURES)
"""
function lmpGender(noun::LMFNoun)
    noun.ngender
end


"""Find case of a `LMFNoun`.

$(SIGNATURES)
"""
function lmpCase(noun::LMFNoun)
    noun.ncase
end

"""Find number of a `LMFNoun`.

$(SIGNATURES)
"""
function lmpNumber(noun::LMFNoun)
    noun.nnumber
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