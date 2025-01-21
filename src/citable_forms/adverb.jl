"""Adverbs have degree."""
struct LMFAdverb <: LatinMorphologicalForm
    adegree::LMPDegree
end


"""Override Base.show for a noun form.
$(SIGNATURES)
"""
function show(io::IO, adv::LMFAdverb)
    print(io, label(adv))
end

"""Override Base.== for an adverb form.
$(SIGNATURES)
"""
function ==(a1::LMFAdverb, a2::LMFAdverb)
    lmpDegree(a1)  == lmpDegree(a2)
end


CitableTrait(::Type{LMFAdverb}) = CitableByCite2Urn()
"""Noun forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFAdverb})
    CitableByCite2Urn()
end

"""Compose a label for a `LMFAdverb` form.
$(SIGNATURES)
"""
function label(adv::LMFAdverb)    
    label(adv.adegree)
end


#=
"""Construct a `LMFAdverb` from string values.
$(SIGNATURES)
"""
function lmfAdverb(d::AbstractString)
    LMFAdverb(
        degreecodedict[d] |> LMPDegree
    )
end
=#

"""Generate list of codes for all adverb forms.
$(SIGNATURES)
"""
function adverbformcodes()
    degreeints = keys(Tabulae.genderlabeldict) |> collect |> sort
    
    formlist = []
    for n in degreeints
        push!(formlist, "$(ADVERB)00000000$(n)")
    end
    formlist
end

"""Generate list of all adverb forms.
$(SIGNATURES)
"""
function adverbforms()
    adverbformscodes() .|> lmfAdverb
end


"""Create a `LMFAdverb` from a string value.

$(SIGNATURES)
"""
function lmfAdverb(code::AbstractString)
    morphchars = split(code, "")
    deg = lmpDegree(parse(Int64, morphchars[end] ))
    LMFAdverb(deg)
end

"""Create a `LMFLMFAdverbNoun` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfAdverb(urn::Cite2Urn)
    lmfAdverb(objectcomponent(urn))
end

"""Create a `LMFAdverb` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfAdverb(f::FormUrn)
    lmfAdverb(f.objectid)
end


"""Sequence of digits encoding form of adverb.
$(SIGNATURES)
"""
function code(adv::LMFAdverb)::String
     string(ADVERB,"00000000", code(adv.adegree))
end


"""Find degree of a `LMFAdverb`.

$(SIGNATURES)
"""
function lmpDegree(adv::LMFAdverb)
    adv.adegree
end



"""Generate a complete list of all possible adverb forms.
$(SIGNATURES)
"""
function adverbanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)

    advstems = filter(s -> s isa TabulaeAdverbStem, stems)
    for (i, advstem) in enumerate(advstems)
        # Filter nounforms() for matching gender.
        @debug("Analyzing adv $(i)/$(length(nounstems))")
        generated = analyses(lexeme(advstem), f,  td)
        for g in generated
            push!(formlist, g)
        end
    end
    
    formlist
end
