abstract type TabulaeRule <: Rule end


"""Instantiate `LatinMorphologicalForm` identified by `rule`.
$(SIGNATURES)
"""
function lmForm(rule::T) where {T <: TabulaeRule}
    @warn "Function lmForm not implemented for rules of type $(typeof(rule))."
    nothing
end


"""Find inflection class identified by `rule`.
$(SIGNATURES)
"""
function inflectionType(rule::T) where {T <: TabulaeRule}
    @warn "Function inflectionType not implemented for rules of type $(typeof(rule))."
    nothing
end

"""Find ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::T) where {T <: TabulaeRule}
    @warn "Function ending not implemented for rules of type $(typeof(rule))."
    nothing
end


function lmpGender(stem::T) where {T <: TabulaeRule}
    @warn "Function lmpGender not implemented for rules of type $(typeof(stem))."
    nothing
end

function lmpCase(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpCase not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpNumber(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpNumber not implemented for rules of type $(typeof(rule))."
    nothing
end


function lmpPerson(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpPerson not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpTense(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpTense not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpMood(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpMood not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpVoice(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpVoice not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpDegree(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpDegree not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpUninflected(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpUninflected not implemented for rules of type $(typeof(rule))."
    nothing
end