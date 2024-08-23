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
import CitableParserBuilder: formurn



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


export analysis, analyses

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

export LatinMorphologicalForm, latinForm, code
export analyses
export LMFFiniteVerb, lmfFiniteVerb, perfectsystem, finiteverbforms
export LMFInfinitive, lmfInfinitive
export LMFGerundive, lmfGerundive
export LMFParticiple, lmfParticiple
export LMFUninflected, lmfUninflected

export LMFNoun, lmfNoun, nounformcodes, nounforms
export LMFPronoun, lmfPronoun, pronounformcodes, pronounforms
export latinForm

export TabulaeRule, inflectionclass, ending, id
export delimitedrule
export formrule, formurn
export TabulaeNounRule
export TabulaePronounRule
export TabulaeFiniteVerbRule
export TabulaeGerundiveRule
export TabulaeGerundRule
export TabulaeInfinitiveRule
export TabulaeParticipleRule
export TabulaeUninflectedRule
export TabulaeIrregularRule

export TabulaeStem, TabulaeIrregularStem, lexeme, stemvalue
export TabulaeNounStem
export TabulaePronounStem
export TabulaeVerbStem, TabulaeIrregularVerb
export TabulaeIrregularInfinitive
export TabulaeStringParser, tabulaeStringParser, tsp
export TabulaeUninflectedStem
export orthography

export md_declension
export md_tenseconjugation, md_verb_conjugation
export md_tenseconjugation_deponent, md_deponent_conjugation



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
include("citable_forms/pronoun.jl")
include("citable_forms/finiteverb.jl")
include("citable_forms/infinitive.jl")
include("citable_forms/gerundive.jl")
include("citable_forms/gerund.jl")
include("citable_forms/participle.jl")
include("citable_forms/uninflected.jl")

include("citable_stems/stems.jl")
include("citable_stems/regularnouns.jl")
include("citable_stems/pronouns.jl")
include("citable_stems/regularverbs.jl")
include("citable_stems/irregularfiniteverbs.jl")
include("citable_stems/irregularinfinitives.jl")
include("citable_stems/compoundverbs.jl")
include("citable_stems/uninflected.jl")



include("citable_rules/rules.jl")
include("citable_rules/nouns.jl")
include("citable_rules/pronouns.jl")
include("citable_rules/verbs.jl")
include("citable_rules/infinitives.jl")
include("citable_rules/gerundives.jl")
include("citable_rules/gerunds.jl")
include("citable_rules/participles.jl")
include("citable_rules/irregulars.jl")
include("citable_rules/uninflected.jl")



include("dataset/rulesarray.jl")
include("dataset/stemsarray.jl")
include("urnregistry/registry.jl")


include("generate/validverbs.jl")
include("generate/generate.jl")

include("parser/stringparser.jl")

include("for-apps/mddeclension.jl")
include("for-apps/verbparadigms.jl")
include("for-apps/deponentverbs.jl")

include("utils/coredata.jl")

end # module
