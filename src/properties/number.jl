struct LMPNumber <: LatinMorphologicalProperty
    code::Int64
    function LMPNumber(code)
        code in keys(numberlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPPerson` from descriptive string.

$(SIGNATURES)
"""
function lmpNumber(s::AbstractString)
    s in keys(numbercodes) ? LMPNumber(numbercodes[s]) : DomainError(string(s, " is not a valid value for number.")) 
end

"""Create `LMPPerson` from integer code.

$(SIGNATURES)
"""
function lmpNumber(code::Int64)
    LMPPerson(code)
end

"""Integer code for a `LMPPerson` value.

$(SIGNATURES)
"""
function code(num::LMPNumber)
    num.code
end

"""Human-readable label for a `LMPPerson` value.

$(SIGNATURES)
"""
function label(num::LMPNumber)
    numberlabels[num.code]
end

"""Dictionary mapping codes to labels for number.

$(SIGNATURES)
"""
const numberlabels = Dict(
    1 => "singular",
    2 => "plural"
)

"""Dictionary mapping labels to codes for number.

$(SIGNATURES)
"""
const personcodes = Dict(
    "singular" => 1,
    "plural" => 2
)
