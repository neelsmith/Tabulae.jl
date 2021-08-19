module Tabulae
using CitableParserBuilder
import CitableParserBuilder: parsetoken, parsewordlist,  parselistfromfile, parselistfromurl


using CitableObject
using Glob, Unicode
using DocStringExtensions, Documenter

#export buildparser
export LatinMorphologicalForm
export LatinNoun, LatinFiniteVerb
export fromfst, formurn, fromanalysis

include("forms.jl")
include("formvalues.jl")
include("latinformurns.jl")
include("serialization.jl")

include("morphology/finiteverb.jl")
include("morphology/noun.jl")

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
