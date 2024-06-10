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



function latinForm(r::T) where {T <: TabulaeRule}
    formurn(r) |> latinForm
end

function delimitedrule(r::T; delimiter = "|") where {T <: TabulaeRule}
    data = [
        id(r),
        inflectionType(r),
        ending(r),
        abbreviate(urn(lmForm(r)))
    ]
    join(data, delimiter)
end

function fromdelimited(row::AbstractString; delimiter = "|")
    cols = split(row, delimiter)
    if length(cols) < 4
        throw(DomainError("Too few columns in $(row)"))
    end

    frm = cols[4] |> FormUrn |> latinForm
    formrule(cols[1], cols[2], cols[3], frm)
end

function formrule(id::AbstractString, infltype::AbstractString, ending::AbstractString, f::LatinMorphologicalForm)
    @warn("No implementation of formrule function for type $(typeof(f))")
end