abstract type TabulaeStem <: Stem end


"""Find lexeme identifier recorded in `stem`.
$(SIGNATURES)
"""
function lexemeurn(stem::T) where {T <: TabulaeStem}
    @warn "Function lexeme not implemented for stems of type $(typeof(stem))."
    nothing
end

"""Identify inflection type for `stem`.
$(SIGNATURES)
"""
function inflectionType(stem::T) where {T <: TabulaeStem}
    @warn "Function inflectionType not implemented for stems of type $(typeof(stem))."
    nothing
end

"""Identify stem form for `stem`.
$(SIGNATURES)
"""
function stemvalue(stem::T) where {T <: TabulaeStem}
    @warn "Function stemvalue not implemented for stems of type $(typeof(stem))."
    nothing
end


function lmpGender(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpGender not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpCase(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpCase not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpNumber(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpNumber not implemented for stems of type $(typeof(stem))."
    nothing
end


function lmpPerson(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpPerson not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpTense(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpTense not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpMood(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpMood not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpVoice(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpVoice not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpDegree(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpDegree not implemented for stems of type $(typeof(stem))."
    nothing
end

function lmpUninflected(stem::T) where {T <: TabulaeStem}
    @warn "Function lmpUninflected not implemented for stems of type $(typeof(stem))."
    nothing
end
