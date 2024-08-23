"""Abstract type of a morphological form."""
abstract type LatinMorphologicalForm end

const BASE_MORPHOLOGY_URN = "urn:cite2:tabulae:latinforms.v1:"


"""Latin morphological forms are citable by Cite2Urn"""
CitableTrait(::T) where {T <: LatinMorphologicalForm} = CitableByCite2Urn()

"""Return Tabulae code for analytical type
encoded in first digit of `codestring`.
$(SIGNATURES)
"""
function poscode(codestring::AbstractString)
    parse(Int32, codestring[1], base = 16)
end


"""Convert a `LatinMorphologicalForm` to a Cite2Urn.

$(SIGNATURES)

All subclasses of `LatinMorphologicalForm` should implement this specifically for their subclass.
"""
function urn(mf::T) where {T <: LatinMorphologicalForm}    
    string(BASE_MORPHOLOGY_URN, code(mf)) |> Cite2Urn
end

"""Compose a `FormUrn` for a `LMFFiniteVerb`.

$(SIGNATURES)
"""
function formurn(mf::T) where {T <: LatinMorphologicalForm}
    FormUrn(string("forms.", code(mf)))
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




"""Generate a complete list of possible morphological forms.
$(SIGNATURES)
"""
function analysesXX(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]
    @debug("Analyzing all noun forms in dataset...")
    formlist = append!(formlist, nounanalyses(td)) 
    formlist = append!(formlist, verbanalyses(td)) 
end


#function hex(n, pad) = string(n, base = 16, pad = pad),

"""Create a `LatinMorphologicalForm` from a form code.
$(SIGNATURES)
"""
function latinForm(codestr::AbstractString)
    if poscode(codestr) == ADJECTIVE
        lmfAdjective(codestr)
    elseif poscode(codestr) == NOUN
        lmfNoun(codestr)
    elseif poscode(codestr) == FINITEVERB
        lmfFiniteVerb(codestr)
    elseif poscode(codestr) == INFINITIVE
        lmfInfinitive(codestr)
    elseif poscode(codestr) == PARTICIPLE
        lmfParticiple(codestr)
    elseif poscode(codestr) == PRONOUN
        lmfPronoun(codestr)
    elseif poscode(codestr) == UNINFLECTED
        lmfUninflected(codestr)
    elseif poscode(codestr) == 10
        lmfGerundive(codestr)
    end
end

"""Create a `LatinMorphologicalForm` from a `FormUrn`.
$(SIGNATURES)
"""
function latinForm(u::CitableParserBuilder.FormUrn)
    latinForm(CitableParserBuilder.objectid(u))
end

"""Create a `LatinMorphologicalForm` from `u`, a `Cite2Urn` identifying a form.
$(SIGNATURES)
"""
function latinForm(u::Cite2Urn)
    latinForm(objectcomponent(u))
end

"""Create a `LatinMorphologicalForm` from the `FormUrn` in `a`.
$(SIGNATURES)
"""
function latinForm(a::Analysis)
    @debug("Find form from analysis by looking at a.form: $(a.form) ")
    latinForm(a.form)
end
