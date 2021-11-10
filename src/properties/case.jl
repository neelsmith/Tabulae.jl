struct LMPCase <: LatinMorphologicalProperty
    code::Int64
    function LMPCase(code)
        code in keys(genderlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPGender` from descriptive string.

$(SIGNATURES)
"""
function lmpPerson(s::AbstractString)
    s in keys(gendercodes) ? LMPCase(gendercodes[s]) : DomainError(string(s, " is not a valid value for number.")) 
end

"""Create `LMPGender` from integer code.

$(SIGNATURES)
"""
function lmpGender(code::Int64)
    LMPCase(code)
end

"""Integer code for a `LMPGender` value.

$(SIGNATURES)
"""
function code(cs::LMPCase)
    cs.code
end

"""Human-readable label for a `LMPGender` value.

$(SIGNATURES)
"""
function label(cs::LMPCase)
    caselabels[cs.code]
end

"""Dictionary mapping codes to labels for case.

$(SIGNATURES)
"""
const caselabels = Dict(
    1 => "masculine",
    2 => "feminine",
    3 => "neuter"
)

"""Dictionary mapping labels to codes for case.

$(SIGNATURES)
"""
const casecodes = Dict(
    "masculine" => 1,
    "feminine" => 2,
    "neuter" => 3
)
