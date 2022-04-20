"""Abstract type of a morphological form."""
abstract type LatinMorphologicalForm end

const BASE_MORPHOLOGY_URN = "urn:cite2:tabulae:forms.v1:"


"""Latin morphological forms are citable by Cite2Urn"""
CitableTrait(::T) where {T <: LatinMorphologicalForm} = CitableByCite2Urn()


"""Convert a `LatinMorphologicalForm` to a Cite2Urn.

$(SIGNATURES)

All subclasses of `LatinMorphologicalForm` should implement this specifically for their subclass.
"""
function urn(mf::T) where {T <: LatinMorphologicalForm}
    @warn("urn: unrecognized type of LatinMorphologicalForm.")
    nothing
end

"""Label for a form.

$(SIGNATURES)

All subclasses of `LatinMorphologicalForm` should implement this specifically for their subclass.
"""
function label(mf::T) where {T <: LatinMorphologicalForm}
    @warn("urn: unrecognized type of LatinMorphologicalForm.")
    nothing
end

"""Convert a `LatinMorphologicalForm` form to a delimited-text string. 

$(SIGNATURES)
"""
function cex(mf::T; delimiter = "|") where {T <: LatinMorphologicalForm}
    join([urn(mf), label(mf)], delimiter)
end


"""Generate a complete list of all possible noun forms.
$(SIGNATURES)
"""
function nounanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)
    nounstems = filter(s -> s isa TabulaeNounStem, stems)
    for nounstem in nounstems
        # Filter nounforms() for matching gender.
       
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

"""Generate a complete list of possible morphological forms.
$(SIGNATURES)
"""
function analyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]
    formlist = append!(formlist, nounanalyses(td)) 
end

