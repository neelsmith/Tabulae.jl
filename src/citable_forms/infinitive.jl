"""Infinitive verbs have tense and voice."""
struct LMFInfinitive <: LatinMorphologicalForm
    tense::LMPTense
    voice::LMPVoice
end

"""Override Base.show for a infinitive form.
$(SIGNATURES)
"""
function show(io::IO, vb::LMFInfinitive)
    print(io, label(vb))
end

"""Override Base.== for a finite verb form.
$(SIGNATURES)
"""
function ==(vb1::LMFInfinitive, vb2::LMFInfinitive)
    lmpTense(vb1)  == lmpTense(vb2) &&
    lmpVoice(vb1)  == lmpVoice(vb2) 
end


CitableTrait(::Type{LMFInfinitive}) = CitableByCite2Urn()
"""Infinitive forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFInfinitive})
    CitableByCite2Urn()
end


"""Compose a label for a `LMFInfinitive`.
$(SIGNATURES)
"""
function label(inf::LMFInfinitive)
    join([label(inf.tense), label(inf.voice), "infinitive"]," ")
end




"""Find tense value for an infinitive.
$(SIGNATURES)
"""
function lmpTense(inf::LMFInfinitive)
    inf.tense
end

"""Find tense voice for an infinitive.
$(SIGNATURES)
"""
function lmpVoice(inf::LMFInfinitive)
    inf.voice
end


"""Sequence of digits encoding form `verb`
$(SIGNATURES)
"""
function code(infinitive::LMFInfinitive)
    string(INFINITIVE, "00" ,
    code(infinitive.tense), "0", code(infinitive.voice), "0000")
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


"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function infinitiveformcodes()

    formlist = []

    v = lmpVoice("active") |> code
    act_tenses = [lmpTense("present"), lmpTense("future"),lmpTense("perfect")]
    for t in code.(act_tenses)
        push!(formlist, "$(INFINITIVE)00$(t)0$(v)0000")
    end
    
    v = lmpVoice("passive") |> code
    t = lmpTense("present") |> code
    push!(formlist, "$(INFINITIVE)00$(t)0$(v)0000")

    formlist
end


