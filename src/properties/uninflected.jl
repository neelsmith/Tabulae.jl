"""Type of uninflected form ("part of speech")."""
struct LMPUninflectedType <: LatinMorphologicalProperty
    code::Int64
    function LMPUninflectedType(code)
        code in keys(uninflectedlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end


"""Override Base.show for a property of uninflected type.
$(SIGNATURES)
"""
function show(io::IO, prop::LMPUninflectedType)
    print(io, label(prop))
end



"""Create `LMPGender` from descriptive string.

$(SIGNATURES)
"""
function lmpUninflectedType(s::AbstractString)
    s in keys(uninflectedcodes) ? LMPUninflectedType(uninflectedcodes[s]) : throw(DomainError(string(s, " is not a valid value for uninflected part of speech.")) )
end

"""Create `LMPUninflectedType` from integer code.

$(SIGNATURES)
"""
function lmpUninflectedType(code::Int64)
    LMPUninflectedType(code)
end

"""Integer code for a `LMPUninflectedType` value.

$(SIGNATURES)
"""
function code(uninfl::LMPUninflectedType)
    uninfl.code
end

"""Human-readable label for a `LMPUninflectedType` value.

$(SIGNATURES)
"""
function label(uninfl::LMPUninflectedType)
    uninflectedlabels[uninfl.code]
end

"""Dictionary mapping codes to labels for case.

$(SIGNATURES)
"""
const uninflectedlabels = Dict(
    1 => "conjunction",
    2 => "preposition",
    3 => "adverb",
    4 => "numeral",
    5 => "interjection"

)

"""Dictionary mapping labels to codes for case.

$(SIGNATURES)
"""
const uninflectedcodes = Dict(
    "conjunction" => 1,
    "preposition" => 2,
    "adverb" => 3,
    "numeral" => 4,
    "interjection" => 5
)
