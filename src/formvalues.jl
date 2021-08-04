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

"""Constants for gender.

$(SIGNATURES)
"""
const genderpairs = [
    (1, "masculine"),
    (2, "feminine"),
    (3, "neuter")
]

"""Constants for substantive case.

$(SIGNATURES)
"""
const casepairs = [
    (1, "nominative"),
    (2, "genitive"),
    (3, "dative"),
    (4, "accusative"),
    (5, "ablative"),
    (6, "vocative")
]


"""Constants for persons.

$(SIGNATURES)
"""
const personpairs = [
    (1, "first"),
    (2, "second"),
    (3, "third")
]

"""Constants for number.

$(SIGNATURES)
"""
const numberpairs = [
    (1, "singular"),
    (2, "plural")
]

"""Constants for voice.

$(SIGNATURES)
"""
const voicepairs = [
    (1, "active"),
    (2, "passive")
]

"""Constants for tense.

$(SIGNATURES)
"""
const tensepairs = [
    (1, "present"),
    (2, "imperfect"),
    (3, "future"),
    (4, "perfect"),
    (5, "pluperfect"),
    (5, "future_perfect")
]

"""Constants for mood.


$(SIGNATURES)
"""
const moodpairs = [
    (1, "indicative"),
    (2, "subjunctive"),
    (3, "imperative")
]



"""Create a dictionary keyed by the value of a label-value pair.

$(SIGNATURES)
"""
function valuedict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[1] => pr[2])
    end
    dict
end

"""Create a dictionary keyed by the label of a label-value pair.


$(SIGNATURES)
"""
function labeldict(prs)
    dict = Dict()
    for pr in prs
        push!(dict, pr[2] => pr[1])
    end
    dict
end
