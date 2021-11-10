module Tabulae
using CitableParserBuilder
import CitableParserBuilder: parsetoken, parsewordlist,  parselistfromfile, parselistfromurl

using HTTP

using CitableObject
using Glob, Unicode
using DocStringExtensions, Documenter

export label, code
export LatinMorphologicalProperty
export LMPTense, lmpTense
export LMPMood, lmpMood
export LMPVoice, lmpVoice
export LMPPerson, lmpPerson

export LatinMorphologicalForm
export LatinNoun, LMFFiniteVerb, LatinUninflectedForm

export fromfst, formurn, fromanalysis


include("forms.jl")
include("formvalues.jl")
include("latinformurns.jl")
include("serialization.jl")

include("properties/property.jl")
include("properties/mood.jl")

include("forms/finiteverb.jl")
include("forms/noun.jl")
include("forms/uninflected.jl")

#=
include("config.jl")
include("dataset.jl")
include("abbrurn.jl")
include("unicode.jl")
include("types.jl")
include("compiler.jl")
include("fstcomposer.jl")
include("acceptorsquashers.jl")

# Specific analytical types ("parts of speech")
include("uninflected.jl")
=#


include("parse.jl")

end # module
