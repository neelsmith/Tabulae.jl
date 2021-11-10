struct LMPPerson <: LatinMorphologicalProperty
    code::Int64
    function LMPPerson(code)
        code in keys(personlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPPerson` from descriptive string.

$(SIGNATURES)
"""
function lmpPerson(s::AbstractString)
    s in keys(personcodes) ? LMPPerson(personcodes[s]) : DomainError(string(s, " is not a valid value for person.")) 
end

"""Create `LMPPerson` from integer code.

$(SIGNATURES)
"""
function lmpPerson(code::Int64)
    LMPPerson(code)
end

"""Integer code for a `LMPPerson` value.

$(SIGNATURES)
"""
function code(person::LMPPerson)
    person.code
end

"""Human-readable label for a `LMPPerson` value.

$(SIGNATURES)
"""
function label(person::LMPPerson)
    personlabels[person.code]
end

"""Dictionary mapping codes to labels for person.

$(SIGNATURES)
"""
const personlabels = Dict(
    1 => "first",
    2 => "second",
    3 => "third"
)

"""Dictionary mapping labels to codes for person.

$(SIGNATURES)
"""
const personcodes = Dict(
    "first" => 1,
    "second" => 2,
    "third" => 2
)
