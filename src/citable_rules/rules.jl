abstract type TabulaeRule <: Rule end



"""
Required function for TabulaeIO subtypes.

$(SIGNATURES)
"""
function fst(rule::T) where {IOT <: TabulaeIO, T <: TabulaeRule}
    throws(DomainError("fst function has not been implemented for type $(typeof(io))"))
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