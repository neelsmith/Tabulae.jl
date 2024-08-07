module Tabulae

using Downloads
using Glob, Unicode
using DocStringExtensions, Documenter


import Base: show
import Base: ==


using CitableParserBuilder
import CitableParserBuilder: parsetoken #, parsewordlist,  parselistfromfile, parselistfromurl
import CitableParserBuilder: tofile
import CitableParserBuilder: datasource
import CitableParserBuilder: orthography
import CitableParserBuilder: delimiter
import CitableParserBuilder: generate
import CitableParserBuilder: lexemeurn, lexeme
import CitableParserBuilder: stringParser
import CitableParserBuilder: analyses



using CitableBase
import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex



using LatinOrthography
using CitableObject

#export urn, label, cex
export ruleurn

export dataset
export rulesarray, stemsarray
export rulesclasses, stemsclasses
export ruleset
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

export LatinMorphologicalForm, lmForm, code
export analyses
export LMFFiniteVerb, lmfFiniteVerb, perfectsystem, finiteverbforms
export LMFInfinitive, lmfInfinitive
export LMFParticiple, lmfParticiple

export LMFNoun, lmfNoun, nounformcodes, nounforms
export latinForm

export TabulaeRule, inflectionclass, ending, id
export delimitedrule, fromdelimited, formrule
export TabulaeNounRule
export TabulaeFiniteVerbRule
export TabulaeInfinitiveRule
export TabulaeParticipleRule
export TabulaeIrregularRule

export TabulaeStem, lexeme, stemvalue
export TabulaeNounStem
export TabulaeVerbStem, TabulaeIrregularVerb

export TabulaeStringParser, tabulaeStringParser
export orthography

export md_declension
export md_tenseconjugation, md_verb_conjugation



include("dataset/dataset.jl")

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
include("citable_forms/participle.jl")

include("citable_stems/stems.jl")
include("citable_stems/regularnouns.jl")
include("citable_stems/regularverbs.jl")
include("citable_stems/irregularfiniteverbs.jl")
include("citable_stems/compoundverbs.jl")




include("citable_rules/rules.jl")
include("citable_rules/nouns.jl")
include("citable_rules/verbs.jl")
include("citable_rules/infinitives.jl")
include("citable_rules/participles.jl")
include("citable_rules/irregulars.jl")



include("dataset/rulesarray.jl")
include("dataset/stemsarray.jl")
include("urnregistry/registry.jl")


include("generate/validverbs.jl")
include("generate/generate.jl")

include("parser/stringparser.jl")

include("for-apps/mddeclension.jl")
include("for-apps/verbparadigms.jl")

include("utils/coredata.jl")

end # module
