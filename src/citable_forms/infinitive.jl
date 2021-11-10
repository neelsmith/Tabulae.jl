"""Infinitive verbs have tense and voice."""
struct LMFInfinitive <: LatinMorphologicalForm
    tense::LMPTense
    voice::LMPVoice
end

"""Infinitive forms are citable by Cite2Urn"""
CitableTrait(::Type{LMFInfinitive}) = CitableByCite2Urn()


"""Compose a label for a `LMFInfinitive`.

$(SIGNATURES)
"""
function label(inf::LMFInfinitive)
    join([label(inf.tense), label(inf.voice), "infinitive"]," ")
end


"""Compose a Cite2Urn for a `LMFInfinitive`.

$(SIGNATURES)
"""
function urn(inf::LMFInfinitive)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, INFINITIVE,"00",code(inf.tense),"0", code(inf.voice),"0000"))
end






"""Create an `LMFInfinitive` from a string value.

$(SIGNATURES)
"""
function lmfInfinitive(code::AbstractString)
    morphchars = split(code, "")
    tense = lmpTense(parse(Int64, morphchars[4]))
    voice = lmpVoice(parse(Int64, morphchars[6]) )
    LMFInfinitive(tense, voice)
end