"""Mood of finite verb form."""
struct LMPMood <: LatinMorphologicalProperty
    code::Int64
    function LMPMood(code)
        code in keys(moodlabeldict) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end



"""Override Base.show for a mood property.
$(SIGNATURES)
"""
function show(io::IO, prop::LMPMood)
    print(io, label(prop))
end



"""Create `LMPMood` from descriptive string.

$(SIGNATURES)
"""
function lmpMood(s::AbstractString)
    s in keys(moodcodedict) ? LMPMood(moodcodedict[s]) : throw(DomainError(string(s, " is not a valid value for mood.")) )
end

"""Create `LMPMood` from integer code.

$(SIGNATURES)
"""
function lmpMood(code::Int64)
    LMPMood(code)
end

"""Integer code for a `LMPMood` value.

$(SIGNATURES)
"""
function code(mood::LMPMood)
    mood.code
end

"""Human-readable label for a `LMPMood` value.

$(SIGNATURES)
"""
function label(mood::LMPMood)
   moodlabeldict[mood.code]
end

"""Dictionary mapping codes to labels for mood.

$(SIGNATURES)
"""
const moodlabeldict = Dict(
    1 => "indicative",
    2 => "subjunctive",
    3 => "imperative"
)

"""Dictionary mapping labels to codes for mood.

$(SIGNATURES)
"""
const moodcodedict = Dict(
    "indicative" => 1,
    "subjunctive" => 2,
    "imperative" => 3,  
)
