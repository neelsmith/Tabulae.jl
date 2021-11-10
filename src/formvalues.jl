# Model for Form URN values:
# PosPNTMVGCDCat

"""Constants for analytical types ("parts of speech")"""
const UNANALYZED = 0
const UNINFLECTED = 1
const NOUN = 2
const FINITEVERB = 3
const INFINITIVE = 4
const PARTICIPLE = 5
const ADJECTIVE = 6
const ADVERB = 7
const PRONOUN = 8
const GERUND = 9
const GERUNDIVE = 10

"""Constants for analytical types ("parts of speech").

$(SIGNATURES)
"""
const pospairs = [
    (UNANALYZED, "unanalyzed"),
    (UNINFLECTED, "uninflected"),
    (NOUN, "noun"),
    (FINITEVERB, "verb-finite"),
    (INFINITIVE, "infinitive"),
    (PARTICIPLE, "participle"),
    (ADJECTIVE, "adjective"),
    (ADVERB, "adverb"),
    (PRONOUN, "pronoun"),
    (GERUND, "gerund"),
    (GERUNDIVE, "gerundive")

]


"""Constants for uninflected type of uninflected form.

$(SIGNATURES)
"""
const uninflectedpairs = [
    (1, "conjunction"),
    (2, "preposition"),
    (3, "adverb"),
    (4, "numeral"),
    (5, "interjection")
]


"""Constants for substantive case.

$(SIGNATURES)
"""
const casepairs = [
    (1, "nom"),
    (2, "gen"),
    (3, "dat"),
    (4, "acc"),
    (5, "abl"),
    (6, "voc")
]





