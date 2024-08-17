"""Pronouns have gender, case and number."""
struct LMFPronoun <: LatinMorphologicalForm
    pngender::LMPGender
    pncase::LMPCase
    pnnumber::LMPNumber
end



"""Override Base.show for a pronoun form.
$(SIGNATURES)
"""
function show(io::IO, noun::LMFPronoun)
    print(io, label(noun))
end

"""Override Base.== for a pronoun form.
$(SIGNATURES)
"""
function ==(pn1::LMFPronoun, pn2::LMFPronoun)
    lmpGender(pn1)  == lmpGender(pn2) &&
    lmpCase(pn1)  == lmpCase(pn2) &&
    lmpNumber(pn1)  == lmpNumber(pn2) 
end


CitableTrait(::Type{LMFPronoun}) = CitableByCite2Urn()
"""Pronoun forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFPronoun})
    CitableByCite2Urn()
end

"""Compose a label for a `LMFPronoun`
$(SIGNATURES)
"""
function label(pronoun::LMFPronoun)    
    join([ label(pronoun.pngender), label(pronoun.pncase), label(pronoun.pnnumber)], " ")
end

"""Compose a Cite2Urn for a `LMFPronoun`.
$(SIGNATURES)
"""
function urn(pronoun::LMFPronoun)
    Cite2Urn(code(pronoun))
end


"""Construct a `LMFPronoun` from string values.
$(SIGNATURES)
"""
function lmfPronoun(g::AbstractString, c::AbstractString, n::AbstractString)
    LMFPronoun(
        gendercodedict[g] |> LMPGender,
        casecodedict[c] |> LMPCase,
        numbercodedict[n] |> LMPNumber
    )
end


"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function pronounformcodes()
    genderints = keys(Tabulae.genderlabeldict) |> collect |> sort
    caseints = keys(Tabulae.caselabeldict) |> collect |> sort
    numints = keys(Tabulae.numberlabeldict) |> collect |> sort
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "$(Tabulae.PRONOUN)0$(n)000$(g)$(c)00")
            end
        end
    end
    formlist
end

"""Generate list of all noun forms.
$(SIGNATURES)
"""
function pronounforms()
    pronounforms() .|> lmfPronoun
end


"""Create a `GMFPronoun` from a string value.

$(SIGNATURES)
"""
function lmfPronoun(code::AbstractString)
    morphchars = split(code, "")
    pngender = lmpGender(parse(Int64, morphchars[7]))
    pncase = lmpCase(parse(Int64, morphchars[8]))
    pnnumber = lmpNumber(parse(Int64,morphchars[3]))
    
    LMFPronoun(pngender, pncase, pnnumber)
end

"""Create a `LMFPronoun` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfPronoun(u::Cite2Urn)
    lmfPronoun(objectcomponent(u))
end

"""Create a `GMFPronoun` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfPronoun(f::FormUrn)
    lmfPronoun(f.objectid)
end


"""Compose a `FormUrn` for a `LMFPronoun`.

$(SIGNATURES)
"""
function latinForm(pronoun::LMFPronoun)
    FormUrn(string("forms.", PRONOUN,"0",code(pronoun.pnnumber),"000", code(pronoun.pngender), code(pronoun.pncase), "00"))
end


"""Sequence of digits encoding form `noun`
$(SIGNATURES)
"""
function code(pronoun::LMFPronoun)
     # PosPNTMVGCDCat
     #string(BASE_MORPHOLOGY_URN, PRONOUN,"0",code(pronoun.pnnumber),"000",code(pronoun.pngender),code(pronoun.pncase),"00")
     string(PRONOUN,"0",code(pronoun.pnnumber),"000",code(pronoun.pngender),code(pronoun.pncase),"00")
end


"""Find gender of a `LMFPronoun`.

$(SIGNATURES)
"""
function lmpGender(pronoun::LMFPronoun)
    pronoun.pngender
end


"""Find case of a `LMFPronoun`.

$(SIGNATURES)
"""
function lmpCase(pronoun::LMFPronoun)
    pronoun.pncase
end

"""Find number of a `LMFPronoun`.

$(SIGNATURES)
"""
function lmpNumber(noun::LMFPronoun)
    noun.pnnumber
end

"""Generate a complete list of all possible noun forms.
$(SIGNATURES)
"""
function pronounanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)
    pronounstems = filter(s -> s isa TabulaePronounStem, stems)
    
    for (i, pronounstem) in enumerate(pronounstems)
        # Filter nounforms() for matching gender.
        @debug("Analyzing pronoun $(i)/$(length(pronounstem))")
       
        # THEN generate for those forms
        for f in filter(nf -> lmpGender(nf) == lmpGender(pronounstem),  pronounforms())
            generated = analyses(lexeme(nounstem), f,  td)
            for g in generated
                push!(formlist, g)
            end
        end
    end

    
    formlist
end




"""Compose a `FormUrn` for a `LMFFiniteVerb`.

$(SIGNATURES)
"""
function formurn(pron::LMFPronoun)
    FormUrn(string("forms.", code(pron)))
end