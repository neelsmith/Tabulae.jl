"""Nouns have gender, case and number."""
struct LMFNoun <: LatinMorphologicalForm
    ngender::LMPGender
    ncase::LMPCase
    nnumber::LMPNumber
end

"""Construct a `LMFNoun` from string values.
$(SIGNATURES)
"""
function lmfNoun(g::AbstractString, c::AbstractString, n::AbstractString)
    LMFNoun(
        gendercodedict[g] |> LMPGender,
        casecodedict[c] |> LMPCase,
        numbercodedict[n] |> LMPNumber
    )
end


"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function nounformcodes()
    genderints = keys(Tabulae.genderlabeldict) |> collect |> sort
    caseints = keys(Tabulae.caselabeldict) |> collect |> sort
    numints = keys(Tabulae.numberlabeldict) |> collect |> sort
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "20$(n)000$(g)$(c)00")
            end
        end
    end
    formlist
end

"""Generate list of all noun forms.
$(SIGNATURES)
"""
function nounforms()
    nounformcodes() .|> lmfNoun
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
function formurn(noun::LMFNoun)
    FormUrn(string("forms.", NOUN,"0",code(noun.nnumber),"000", code(noun.ngender), code(noun.ncase), "00"))
end


"""Sequence of digits encoding form `noun`
$(SIGNATURES)
"""
function code(noun::LMFNoun)
    urn(noun) |> objectcomponent
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





"""Generate a complete list of all possible noun forms.
$(SIGNATURES)
"""
function nounanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)

    nounstems = filter(s -> s isa TabulaeNounStem, stems)
    for (i, nounstem) in enumerate(nounstems)
        # Filter nounforms() for matching gender.
        @info("Analyzing noun $(i)/$(length(nounstems))")
       
        # THEN generate for those forms
        for f in filter(nf -> lmpGender(nf) == lmpGender(nounstem),  nounforms())
            generated = generate(f, lexeme(nounstem), td)
            for g in generated
                push!(formlist, g)
            end
        end
    end

    
    formlist
end
