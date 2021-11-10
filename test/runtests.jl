using Tabulae
using CitableObject, CitableParserBuilder
using Test

#include("test_nounforms.jl")
#include("test_uninflectedforms.jl")
#include("test_verbforms.jl")
#include("test_parsing.jl")


include("properties/test_properties.jl")
include("properties/test_tense.jl")
include("properties/test_mood.jl")
include("properties/test_voice.jl")
include("properties/test_person.jl")
include("properties/test_number.jl")
include("properties/test_gender.jl")
include("properties/test_case.jl")
include("properties/test_degree.jl")
include("properties/test_uninflected.jl")

include("forms/test_finiteverb.jl")
