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
    (1, "masc"),
    (2, "fem"),
    (3, "neut")
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


"""Constants for persons.

$(SIGNATURES)
"""
const personpairs = [
    (1, "1st"),
    (2, "2nd"),
    (3, "3rd")
]

"""Constants for number.

$(SIGNATURES)
"""
const numberpairs = [
    (1, "sg"),
    (2, "pl")
]

"""Constants for voice.

$(SIGNATURES)
"""
const voicepairs = [
    (1, "act"),
    (2, "pass")
]

"""Constants for tense.

$(SIGNATURES)
"""
const tensepairs = [
    (1, "pres"),
    (2, "impft"),
    (3, "fut"),
    (4, "pft"),
    (5, "plupft"),
    (5, "futpft")
]

"""Constants for mood.


$(SIGNATURES)
"""
const moodpairs = [
    (1, "indic"),
    (2, "subj"),
    (3, "imptv")
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

