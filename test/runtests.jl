using Tabulae
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using Test



include("test_dataset.jl")
include("test_registry.jl")

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
include("forms/test_noun.jl")
include("forms/test_infinitive.jl")


include("rules/test_nounrules.jl")
include("stems/test_nounstems.jl")
