"""Finite verbs have person, number, tense, mood and voice."""
struct LMFFiniteVerb <: LatinMorphologicalForm
    vperson::LMPPerson
    vnumber::LMPNumber
    vtense::LMPTense
    vmood::LMPMood
    vvoice::LMPVoice
end

"""Finite verb forms are citable by Cite2Urn"""
CitableTrait(::Type{LMFFiniteVerb}) = CitableByCite2Urn()

"""Compose a label for a `LMFFiniteVerb`

$(SIGNATURES)
"""
function label(verb::LMFFiniteVerb)
    join(
        [
        label(verb.vtense), 
        label(verb.vmood), 
        label(verb.vvoice),
        label(verb.vperson),  
        label(verb.vnumber)
        ], " ")
end

"""Compose a Cite2Urn for a `LMFFiniteVerb`.

$(SIGNATURES)
"""
function urn(verb::LMFFiniteVerb)
    # PosPNTMVGCDCat
    Cite2Urn(string(BASE_MORPHOLOGY_URN, FINITEVERB, code(verb.vperson),code(verb.vnumber), code(verb.vtense), code(verb.vmood), code(verb.vvoice),"0000"))
end


"""Create a `GMFFiniteVerb` from a string value.

$(SIGNATURES)
"""
function lmfFiniteVerb(code::AbstractString)
    morphchars = split(code,"")
    # PosPNTMVGCDCat
    
    tns = lmpTense(parse(Int64, morphchars[4]))
    md = lmpMood(parse(Int64, morphchars[5]))
    vc = lmpVoice(parse(Int64,morphchars[6]))
    prsn = lmpPerson(parse(Int64, morphchars[2]))
    nmbr = lmpNumber(parse(Int64, morphchars[3]))
    
    LMFFiniteVerb(
        prsn,
        nmbr,
        tns,
        md, 
        vc
    )
end


"""Create a `LMFFiniteVerb` from a `Cite2URN`.

$(SIGNATURES)
"""
function lmfFiniteVerb(urn::Cite2Urn)
    lmfFiniteVerb(objectcomponent(urn))
end


"""Create a `LMFFiniteVerb` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfFiniteVerb(f::FormUrn)
    lmfFiniteVerb(f.objectid)
end

"""Create a `LMFFiniteVerb` from an `Analysis`.

$(SIGNATURES)
"""
function lmfFiniteVerb(a::Analysis)
    lmfFiniteVerb(a.form)
end


"""Find tense of a form.

$(SIGNATURES)
"""
function lmpTense(verb::LMFFiniteVerb)
    verb.vtense
end

"""Find mood of a form.

$(SIGNATURES)
"""
function lmpMood(verb::LMFFiniteVerb)
    verb.vmood
end


"""Find voice of a form.

$(SIGNATURES)
"""
function lmpVoice(verb::LMFFiniteVerb)
    verb.vvoice
end


"""Find person of a form.

$(SIGNATURES)
"""
function lmpPerson(verb::LMFFiniteVerb)
    verb.vperson
end


"""Find number of a form.

$(SIGNATURES)
"""
function lmpNumber(verb::LMFFiniteVerb)
    verb.vnumber
end


"""Compose a `FormUrn` for a `LMFFiniteVerb`.

$(SIGNATURES)
"""
function formurn(verbform::LMFFiniteVerb)
    FormUrn(string("forms.", FINITEVERB, code(verbform.vperson), code(verbform.vnumber), code(verbform.vtense), code(verbform.vmood), code(verbform.vvoice), "0000"))
end


"""Generate a complete list of all possible verb forms.
$(SIGNATURES)
"""
function verbanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)

    verbstems = filter(s -> s isa TabulaeVerbStem, stems)
    for (i, verbstem) in enumerate(verbstems)
        # Filter nounforms() for matching gender.
        @info("Analyzing verb $(i)/$(length(verbstems))")
       
        # THEN generate for those forms
        #=
        for f in filter(nf -> lmpGender(nf) == lmpGender(nounstem),  nounforms())
            generated = generate(f, lexeme(nounstem), td)
            for g in generated
                push!(formlist, g)
            end
        end
        =#
    end

    
    formlist
end
