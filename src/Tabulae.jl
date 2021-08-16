module Tabulae
using CitableParserBuilder
using CitableObject
using Glob, Unicode
using DocStringExtensions, Documenter

#export buildparser
export LatinMorphologicalForm
export LatinNoun, LatinFiniteVerb
export fromfst, formurn

include("forms.jl")
include("formvalues.jl")
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

end # module
