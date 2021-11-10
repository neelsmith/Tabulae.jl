struct LMPDegree <: LatinMorphologicalProperty
    code::Int64
    function LMPDegree(code)
        code in keys(numberlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPPerson` from descriptive string.

$(SIGNATURES)
"""
function lmpDegree(s::AbstractString)
    s in keys(numbercodes) ? LMPDegree(numbercodes[s]) : throw(DomainError(string(s, " is not a valid value for number.")) )
end

"""Create `LMPPerson` from integer code.

$(SIGNATURES)
"""
function lmpDegree(code::Int64)
    LMPDegree(code)
end

"""Integer code for a `LMPPerson` value.

$(SIGNATURES)
"""
function code(degree::LMPDegree)
    degree.code
end

"""Human-readable label for a `LMPPerson` value.

$(SIGNATURES)
"""
function label(degree::LMPDegree)
    degreelabels[degree.code]
end

"""Dictionary mapping codes to labels for number.

$(SIGNATURES)
"""
const degreelabels = Dict(
    1 => "positive",
    2 => "comparative",
    3 => "superlative"
)

"""Dictionary mapping labels to codes for number.

$(SIGNATURES)
"""
const degreecodes = Dict(
    "positive" => 1,
    "comparative" => 2,
    "superlative" => 3
)
