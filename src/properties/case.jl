struct LMPCase <: LatinMorphologicalProperty
    code::Int64
    function LMPCase(code)
        code in keys(caselabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPGender` from descriptive string.

$(SIGNATURES)
"""
function lmpCase(s::AbstractString)
    s in keys(casecodes) ? LMPCase(casecodes[s]) : DomainError(string(s, " is not a valid value for number.")) 
end

"""Create `LMPGender` from integer code.

$(SIGNATURES)
"""
function lmpCase(code::Int64)
    LMPCase(code)
end

"""Integer code for a `LMPCase` value.

$(SIGNATURES)
"""
function code(cs::LMPCase)
    cs.code
end

"""Human-readable label for a `LMPCase` value.

$(SIGNATURES)
"""
function label(cs::LMPCase)
    caselabels[cs.code]
end

"""Dictionary mapping codes to labels for case.

$(SIGNATURES)
"""
const caselabels = Dict(
    1 => "nominative",
    2 => "genitive",
    3 => "dative",
    4 => "accusative",
    5 => "ablative",
    6 => "vocative"
)

"""Dictionary mapping labels to codes for case.

$(SIGNATURES)
"""
const casecodes = Dict(
    "nominative" => 1,
    "genitive" => 2,
    "dative" => 3,
    "accusative" => 4,
    "ablative" => 5,
    "vocative" => 6
)
