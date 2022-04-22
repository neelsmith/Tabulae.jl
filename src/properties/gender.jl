struct LMPGender <: LatinMorphologicalProperty
    code::Int64
    function LMPGender(code)
        code in keys(genderlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPGender` from descriptive string.

$(SIGNATURES)
"""
function lmpGender(s::AbstractString)
    s in keys(gendercodedict) ? LMPGender(gendercodedict[s]) : throw(DomainError(string(s, " is not a valid value for number.")))
end

"""Create `LMPGender` from integer code.

$(SIGNATURES)
"""
function lmpGender(code::Int64)
    LMPGender(code)
end

"""Integer code for a `LMPGender` value.

$(SIGNATURES)
"""
function code(gender::LMPGender)
    gender.code
end

"""Human-readable label for a `LMPGender` value.

$(SIGNATURES)
"""
function label(gender::LMPGender)
    genderlabeldict[gender.code]
end

"""Dictionary mapping codes to labels for gender.

$(SIGNATURES)
"""
const genderlabeldict = Dict(
    1 => "masculine",
    2 => "feminine",
    3 => "neuter"
)

"""Dictionary mapping labels to codes for gender.

$(SIGNATURES)
"""
const gendercodedict = Dict(
    "masculine" => 1,
    "feminine" => 2,
    "neuter" => 3
)
