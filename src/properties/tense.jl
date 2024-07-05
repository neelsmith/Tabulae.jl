"""Tense of finite, infinitive or participial form of verb."""
struct LMPTense <: LatinMorphologicalProperty
    code::Int64
    function LMPTense(code)
        code in keys(tenselabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end



"""Override Base.show for a tense property.
$(SIGNATURES)
"""
function show(io::IO, prop::LMPTense)
    print(io, label(prop))
end


"""Create `LMPTense` from descriptive string.

$(SIGNATURES)
"""
function lmpTense(s::AbstractString)
    s in keys(tensecodedict) ? LMPTense(tensecodedict[s]) : throw(DomainError(string(s, " is not a valid value for tense.")) )
end


"""Create `LMPTense` from integer code.

$(SIGNATURES)
"""
function lmpTense(code::Int64)
    LMPTense(code)
end

"""Integer code for  tense value.

$(SIGNATURES)
"""
function code(tense::LMPTense)
    tense.code
end


"""Human-readable label for tense value.

$(SIGNATURES)
"""
function label(tense::LMPTense)
    tenselabeldict[tense.code]
end

"""Dictionary mapping codes to labels for tense.

$(SIGNATURES)
"""
const tenselabeldict = Dict(
    1 => "present",
    2 => "imperfect",
    3 => "future",
    4 => "perfect",
    5 => "pluperfect",
    6 => "future_perfect",
)

"""Dictionary mapping labels to codes for tense.

$(SIGNATURES)
"""
const tensecodedict = Dict(
    "present" => 1,
    "imperfect" => 2,
    "future" => 3,  
    "perfect" => 4,  
    "pluperfect" => 5,  
    "future_perfect" => 6,  
)
