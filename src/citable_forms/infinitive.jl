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

"""Create an `LMFInfinitive` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfInfinitive(urn::Cite2Urn)
    lmfInfinitive(objectcomponent(urn))
end

"""Create a `LMFInfinitive` from an `Analysis`.

$(SIGNATURES)
"""
function lmfInfinitive(a::Analysis)
    lmfInfinitive(a.form)
end


"""Create a `LMFInfinitive` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfInfinitive(f::FormUrn)
    lmfInfinitive(f.objectid)
end


"""Compose a `FormUrn` for a `LMFInfinitive`.

$(SIGNATURES)
"""
function formurn(infinitive::LMFInfinitive)
    FormUrn(string("forms.", INFINITIVE, "00" ,
    code(infinitive.tense), "0", code(infinitive.voice), "0000"))
end


"""Compose URN for infinitive verb form from FST representation of analytical data.

$(SIGNATURES)
"""
function infinitivefromfst(fstdata)
    # The fst parameter shoud look like
    # <present><active>
    # Extract TV from a string like the example:
    infinitiverulere = r"<([^<]+)><([^<]+)>"
    matchedup = collect(eachmatch(infinitiverulere, fstdata))

    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\" as verb form.")
        nothing
    else
        (t, v) = matchedup[1].captures
        LMFInfinitive(lmpTense(t),lmpVoice(v))    
    end
end