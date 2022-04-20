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


"""Generate a complete list of possible morphological forms.
$(SIGNATURES)
"""
function allforms(td::Tabulae.Dataset)
    formlist = []
    stems = stemsarray(td)
    nounstems = filter(s -> s isa TabulaeNounStem, stems)
    for nounstem in nounstems
        
        # Filter nounforms() for matching gender.
       
        # THEN generate for those forms
        for f in filter(nf -> lmpGender(nf) == lmpGender(nounstem),  nounforms())
            generated = generate(f, lexeme(nounstem), td)
            # four urns?
            # a = Analysis(s, )
#=
struct Analysis
    token::AbstractString
    lexeme::LexemeUrn
    form::FormUrn
    stem::StemUrn
    rule::RuleUrn
end

            =#
            for str in generated
                a = Analysis(str, lexeme(nounstem), formurn(f), urn(nounstem), RuleUrn("dummy.rule"))
                push!(formlist, a)
            end
        end
    end
    formlist
end

