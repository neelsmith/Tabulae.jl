struct LMPVoice <: LatinMorphologicalProperty
    code::Int64
    function LMPVoice(code)
        code in keys(voicelabels) ? new(code) : throw(DomainError(string(code, " is out of range.")))
    end
end

"""Create `LMPVoice` from descriptive string.

$(SIGNATURES)
"""
function lmpVoice(s::AbstractString)
    s in keys(voicecodes) ? LMPVoice(voicecodes[s]) : throw(DomainError(string(s, " is not a valid value for voice.")) )
end

"""Create `LMPVoice` from integer code.

$(SIGNATURES)
"""
function lmpVoice(code::Int64)
    LMPVoice(code)
end

"""Integer code for a `LMPVoice` value.

$(SIGNATURES)
"""
function code(voice::LMPVoice)
    voice.code
end

"""Human-readable label for a `LMPVoice` value.

$(SIGNATURES)
"""
function label(voice::LMPVoice)
    voicelabels[voice.code]
end

"""Dictionary mapping codes to labels for voice.

$(SIGNATURES)
"""
const voicelabels = Dict(
    1 => "active",
    2 => "passive"
)

"""Dictionary mapping labels to codes for voice.

$(SIGNATURES)
"""
const voicecodes = Dict(
    "active" => 1,
    "passive" => 2
)
