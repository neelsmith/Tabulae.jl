"""Abstract type of a morphological form in Kanones."""
abstract type LatinMorphologicalProperty end

"""Integer code for  morphological property value.

$(SIGNATURES)
"""
function code(lmp::T) where {T <: LatinMorphologicalProperty}
    @warn "Function code not implemented for properties of type $(typeof(lmp))."
    nothing
end

"""Human-readable label for morphological property value.

$(SIGNATURES)
"""
function label(lmp::T) where {T <: LatinMorphologicalProperty}
    @warn "Function label not implemented for properties of type $(typeof(lmp))."
    nothing
end

"""Find tense of a form.

$(SIGNATURES)
"""
function lmpTense(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpTense not implemented for forms of type $typeof(lmf)."
    nothing
end

"""Find mood of a form.

$(SIGNATURES)
"""
function lmpMood(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpMood not implemented for forms of type $typeof(lmf)."
    nothing
end


"""Find voice of a form.

$(SIGNATURES)
"""
function lmpVoice(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpVoice not implemented for forms of type $(typeof(lmf))."
    nothing
end


"""Find person of a form.

$(SIGNATURES)
"""
function lmpPerson(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpPerson not implemented for forms of type $(typeof(lmf))."
    nothing
end


"""Find number of a form.

$(SIGNATURES)
"""
function lmpNumber(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpNumber not implemented for forms of type $(typeof(lmf))."
    nothing
end

"""Find gender of a form.

$(SIGNATURES)
"""
function lmpGender(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpGender not implemented for forms of type $(typeof(lmf))."
    nothing
end



"""Find case of a form.

$(SIGNATURES)
"""
function lmpCase(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpCase not implemented for forms of type $(typeof(lmf))."
    nothing
end


"""Find degree of a form.

$(SIGNATURES)
"""
function lmpDegree(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpDegree not implemented for forms of type $(typeof(lmf))."
    nothing
end


"""Find part of speech of an uninflected form.

$(SIGNATURES)
"""
function lmpUninflectedType(lmf::T) where {T <: LatinMorphologicalForm}
    @warn "Function lmpUninflectedType not implemented for forms of type $(typeof(lmf))."
    nothing
end
