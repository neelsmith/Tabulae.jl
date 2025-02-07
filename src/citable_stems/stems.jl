abstract type TabulaeStem <: Stem end
abstract type TabulaeIrregularStem <: TabulaeStem end


"""Identify inflection type for `stem`.
$(SIGNATURES)
"""
function inflectionclass(stem::T) where {T <: TabulaeStem}
    @debug "Function inflectionclass not implemented for stems of type $(typeof(stem))."
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


"""Compose an abbreviated URN for a rule.

$(SIGNATURES)
"""
function formurn(stem::T) where {T <: TabulaeStem}
    latinForm(stem) |> formurn
end