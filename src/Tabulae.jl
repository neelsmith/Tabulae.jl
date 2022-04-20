module Tabulae
using CitableParserBuilder
import CitableParserBuilder: parsetoken, parsewordlist,  parselistfromfile, parselistfromurl

using LatinOrthography

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
export ruleurn



export dataset
export rulesarray, stemsarray
export registry

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

export LatinMorphologicalForm, lmForm
export analyses
export LMFFiniteVerb, lmfFiniteVerb
export LMFInfinitive, lmfInfinitive
export LMFNoun, lmfNoun, nounformcodes, nounforms

export NounIO, VerbIO

export TabulaeRule, inflectionType
export TabulaeNounRule

export TabulaeStem, lexeme, stemvalue
export TabulaeNounStem

export generate
export mddeclension

include("tabulaeio.jl")
include("dataset.jl")
include("urnregistry/registry.jl")

include("citable_forms/forms.jl")
include("formvalues.jl")

include("properties/property.jl")
include("properties/tense.jl")
include("properties/mood.jl")
include("properties/voice.jl")
include("properties/person.jl")
include("properties/number.jl")
include("properties/gender.jl")
include("properties/case.jl")
include("properties/degree.jl")
include("properties/uninflected.jl")

include("citable_forms/noun.jl")
include("citable_forms/finiteverb.jl")
include("citable_forms/infinitive.jl")

include("citable_stems/stems.jl")
include("citable_stems/regularnouns.jl")

include("citable_rules/rules.jl")
include("citable_rules/nouns.jl")

include("generate/generate.jl")


include("parser/parser.jl")
include("parser/dictparser.jl")

include("for-apps/md.jl")

end # module
