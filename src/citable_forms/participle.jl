"""Infinitive verbs have tense and voice."""
struct LMFParticiple <: LatinMorphologicalForm
    pgender::LMPGender
    pcase::LMPCase
    pnumber::LMPNumber
    ptense::LMPTense
    pvoice::LMPVoice
end


"""Participle forms are citable by Cite2Urn"""
CitableTrait(::Type{LMFParticiple}) = CitableByCite2Urn()


"""Compose a label for a `LMFParticiple`.

$(SIGNATURES)
"""
function label(p::LMFParticiple)
    join([label(p.ptense), label(p.pvoice), "participle,", label(p.pgender), label(p.pcase), label(p.pnumber)]," ")
end

"""Sequence of digits encoding form `verb`
$(SIGNATURES)
"""
function code(verb::LMFParticiple)
    urn(verb) |> objectcomponent
end

"""Compose a Cite2Urn for a `LMFParticiple`.

$(SIGNATURES)
"""
function urn(p::LMFParticiple)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PARTICIPLE,"0", code(p.pnumber),code(p.tense),"0", code(p.voice),code(p.gender),code(p.case),"00"))
end


"""Create an `LMFParticiple` from a string value.

$(SIGNATURES)
"""
function lmfParticiple(code::AbstractString)
    morphchars = split(code, "")
    pgender = lmpGender(parse(Int64, morphchars[7])) 
    pcase = lmpCase(parse(Int64, morphchars[8])) 
    pnumber = lmpNumber(parse(Int64, morphchars[3])) 
    ptense = lmpTense(parse(Int64, morphchars[4]))
    pvoice = lmpVoice(parse(Int64, morphchars[6]) )
    LMFParticiple(pgender, pcase, pnumber, ptense, pvoice)
end

"""Create an `LMFParticiple` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfParticiple(urn::Cite2Urn)
    lmfParticiple(objectcomponent(urn))
end

"""Create a `LMFParticiple` from an `Analysis`.

$(SIGNATURES)
"""
function lmfParticiple(a::Analysis)
    lmfParticiple(a.form)
end


"""Create a `LMFParticiple` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfParticiple(f::FormUrn)
    lmfParticiple(f.objectid)
end


"""Compose a `FormUrn` for a `LMFParticiple`.

$(SIGNATURES)
"""
function formurn(ptcpl::LMFParticiple)
    FormUrn(string("forms.", PARTICIPLE,"0", code(p.pnumber),code(p.tense),"0", code(p.voice),code(p.gender),code(p.case),"00"))
end
