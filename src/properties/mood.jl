struct LMPMood <: LatinMorphologicalProperty
    code::Int64
    function LMPMood(code)
        code in keys(moodlabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPMood` from descriptive string.

$(SIGNATURES)
"""
function lmpMood(s::AbstractString)
    s in keys(moodcodes) ? LMPMood(moodcodes[s]) : throw(DomainError(string(s, " is not a valid value for mood.")) )
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
   moodlabels[mood.code]
end

"""Dictionary mapping codes to labels for mood.

$(SIGNATURES)
"""
const moodlabels = Dict(
    1 => "indicative",
    2 => "subjunctive",
    3 => "imperative"
)

"""Dictionary mapping labels to codes for mood.

$(SIGNATURES)
"""
const moodcodes = Dict(
    "indicative" => 1,
    "subjunctive" => 2,
    "imperative" => 3,
   
)
