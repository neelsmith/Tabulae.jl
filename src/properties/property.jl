"""Abstract type of a morphological form in Kanones."""
abstract type LatinMorphologicalProperty end

"""Integer code for  morphological property value.

$(SIGNATURES)
"""
function code(lmp::T) where {T <: LatinMorphologicalProperty}
    @warn "Function code not implemented for forms of type $(typeof(lmp))."
    nothing
end

"""Human-readable label for morphological property value.

$(SIGNATURES)
"""
function label(lmp::T) where {T <: LatinMorphologicalProperty}
    @warn "Function label not implemented for forms of type $(typeof(lmp))."
    nothing
end

"""Find tense of a form.

$(SIGNATURES)
"""
function lmpTense(lmf::T) where {T <: LatinMorphologicalProperty}
    @warn "Function gmpTense not implemented for forms of type $typeof(lmf)."
    nothing
end

"""Find mood of a form.

$(SIGNATURES)
"""
function lmpMood(lmf::T) where {T <: LatinMorphologicalProperty}
    @warn "Function gmpMood not implemented for forms of type $typeof(lmf)."
    nothing
end


"""Find voice of a form.

$(SIGNATURES)
"""
function lmpVoice(lmf::T) where {T <: LatinMorphologicalProperty}
    @warn "Function gmpVoice not implemented for forms of type $(typeof(lmf))."
    nothing
end
