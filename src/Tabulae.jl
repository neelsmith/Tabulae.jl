module Tabulae
using CitableParserBuilder
import CitableParserBuilder: parsetoken, parsewordlist,  parselistfromfile, parselistfromurl

using HTTP

using CitableObject
using Glob, Unicode
using DocStringExtensions, Documenter


using CitableBase: Citable
import CitableBase: CitableTrait
import CitableBase: urn
import CitableBase: label
import CitableBase: cex

export urn, label, cex

#export dataset
#export rulesarray, stemsarray


export label, code
export LatinMorphologicalProperty
export LMPTense, lmpTense
export LMPMood, lmpMood
export LMPVoice, lmpVoice
export LMPPerson, lmpPerson
export LMPNumber, lmpNumber
export LMPGender, lmpGender
export LMPCase, lmpCase
export LMPDegree, lmpDegree
export LMPUninflectedType, lmpUninflectedType

export LatinMorphologicalForm
export LMFFiniteVerb, lmfFiniteVerb
#export LatinNoun, , LatinUninflectedForm



#export fromfst, formurn, fromanalysis
#include("forms.jl")
include("formvalues.jl")
#include("latinformurns.jl")
#include("serialization.jl")

include("properties/property.jl")
include("properties/tense.jl")
include("properties/mood.jl")
include("properties/voice.jl")
include("properties/gender.jl")
include("properties/case.jl")
include("properties/number.jl")
include("properties/degree.jl")
include("properties/uninflected.jl")

include("citable_forms/finiteverb.jl")
#include("forms/noun.jl")
#include("forms/uninflected.jl")



#include("parse.jl")

end # module
