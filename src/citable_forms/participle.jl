"""Infinitive verbs have tense and voice."""
struct LMFParticiple <: LatinMorphologicalForm
    pgender::LMPGender
    pcase::LMPCase
    pnumber::LMPNumber
    ptense::LMPTense
    pvoice::LMPVoice
end


"""Override Base.show for a participle form.
$(SIGNATURES)
"""
function show(io::IO, p::LMFParticiple)
    print(io, label(p))
end

"""Override Base.== for a participle form.
$(SIGNATURES)
"""
function ==(p1::LMFParticiple, p2::LMFParticiple)
    lmpGender(p1)  == lmpGender(p2) &&
    lmpCase(p1)  == lmpCase(p2) &&
    lmpNumber(p1)  == lmpNumber(p2) &&
    lmpTense(p1)  == lmpTense(p2) &&
    lmpVoice(p1)  == lmpVoice(p2) 
end


CitableTrait(::Type{LMFParticiple}) = CitableByCite2Urn()
"""Participle forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFParticiple})
    CitableByCite2Urn()
end


"""Compose a Cite2Urn for a `LMFParticiple`.

$(SIGNATURES)
"""
function urn(p::LMFParticiple)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, PARTICIPLE,"0", code(p.pnumber),code(p.ptense),"0", code(p.pvoice),code(p.pgender),code(p.pcase),"00"))
end


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


"""Gender value for a participle form.
$(SIGNATURES)
"""
function lmpGender(p::LMFParticiple)
    p.pgender
end


"""Case value for a participle form.
$(SIGNATURES)
"""
function lmpCase(p::LMFParticiple)
    p.pcase
end


"""Number value for a participle form.
$(SIGNATURES)
"""
function lmpNumber(p::LMFParticiple)
    p.pnumber
end


"""Tense value for a participle form.
$(SIGNATURES)
"""
function lmpTense(p::LMFParticiple)
    p.ptense
end



"""Voice value for a participle form.
$(SIGNATURES)
"""
function lmpVoice(p::LMFParticiple)
    p.pvoice
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
function formurn(p::LMFParticiple)
    FormUrn(string("forms.", PARTICIPLE,"0", code(p.pnumber),code(p.ptense),"0", code(p.pvoice),code(p.pgender),code(p.pcase),"00"))
end


function participleformcodes()
    genderints = keys(genderlabeldict) |> collect |> sort
    caseints = keys(caselabeldict) |> collect |> sort
    numints = keys(numberlabeldict) |> collect |> sort


    formlist = []
    t = lmpTense("present") |> code
    v = lmpVoice("active") |> code
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "$(PARTICIPLE)0$(n)$(t)0$(v)$(g)$(c)00")
            end
        end
    end

    t = lmpTense("future") |> code
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "$(PARTICIPLE)0$(n)$(t)0$(v)$(g)$(c)00")
            end
        end
    end

    t = lmpTense("perfect") |> code
    v = lmpVoice("passive") |> code
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "$(PARTICIPLE)0$(n)$(t)0$(v)$(g)$(c)00")
            end
        end
    end



    #=for t in tenseints
        for v in voiceints
            
            for n in numints
                for g in genderints
                    for c in caseints
                        push!(formlist, "$(PARTICIPLE)0$(n)$(t)0$(v)$(g)$(c)00")
                    end
                end
            end
           
        end
    end
    =#
    formlist
end

function participleforms()
    participleformcodes() .|> latinForm
end