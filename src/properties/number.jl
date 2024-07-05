"Number of substantive or of finite verb form."
struct LMPNumber <: LatinMorphologicalProperty
    code::Int64
    function LMPNumber(code)
        code in keys(numberlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Override Base.show for a number property.
$(SIGNATURES)
"""
function show(io::IO, prop::LMPNumber)
    print(io, label(prop))
end


"""Create `LMPPerson` from descriptive string.

$(SIGNATURES)
"""
function lmpNumber(s::AbstractString)
    s in keys(numbercodedict) ? LMPNumber(numbercodedict[s]) : DomainError(string(s, " is not a valid value for number.")) 
end

"""Create `LMPPerson` from integer code.

$(SIGNATURES)
"""
function lmpNumber(code::Int64)
    LMPNumber(code)
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
    numberlabeldict[num.code]
end

"""Dictionary mapping codes to labels for number.

$(SIGNATURES)
"""
const numberlabeldict = Dict(
    1 => "singular",
    2 => "plural"
)

"""Dictionary mapping labels to codes for number.

$(SIGNATURES)
"""
const numbercodedict = Dict(
    "singular" => 1,
    "plural" => 2
)
