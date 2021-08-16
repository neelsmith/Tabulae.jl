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


##############################################
#
# Functions to get individual values from a FormUrn
#


"""Extract "part of speech" code from a `FormUrn`.
$SIGNATURES
"""
function poscode(f::FormUrn)::Int64
    parse(Int64, split(f.objectid, "")[1])
end

"""Look up label for "part of speech" code from a `FormUrn`.
$SIGNATURES
"""
function poslabel(f::FormUrn)
    poscode(f) == 0 ? "none" : valuedict(pospairs)[poscode(f)]
end

"""Extract person code from a `FormUrn`.
$SIGNATURES
"""
function personcode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[2])
end

"""Look up label for person code from a `FormUrn`.
$SIGNATURES
"""
function personlabel(f::FormUrn)
    personcode(f) == 0 ? "none" : valuedict(personpairs)[personcode(f)]
end


"""Extract number code from a `FormUrn`.
$SIGNATURES
"""
function numbercode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[3])
end

"""Look up label for number code from a `FormUrn`.
$SIGNATURES
"""
function numberlabel(f::FormUrn)
    numbercode(f) == 0 ? "none" : valuedict(numberpairs)[numbercode(f)]
end


"""Extract tense code from a `FormUrn`.
$SIGNATURES
"""
function tensecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[4])
end

"""Look up label for tense code from a `FormUrn`.
$SIGNATURES
"""
function tenselabel(f::FormUrn)
    tensecode(f) == 0 ? "none" : valuedict(tensepairs)[tensecode(f)]
end


"""Extract mood code from a `FormUrn`.
$SIGNATURES
"""
function moodcode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[5])
end


"""Look up label for mood code from a `FormUrn`.
$SIGNATURES
"""
function moodlabel(f::FormUrn)
    moodcode(f) == 0 ? "none" : valuedict(moodpairs)[moodcode(f)]
end



"""Extract voice code from a `FormUrn`.
$SIGNATURES
"""
function voicecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[6])
end

"""Look up label for voice code from a `FormUrn`.
$SIGNATURES
"""
function voicelabel(f::FormUrn)
    voicecode(f) == 0 ? "none" :  valuedict(voicepairs)[voicecode(f)]
end


"""Extract gender code from a `FormUrn`.
$SIGNATURES
"""
function gendercode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[7])
end

"""Look up label for gender code from a `FormUrn`.
$SIGNATURES
"""
function genderlabel(f::FormUrn)
    gendercode(f) == 0 ? "none" :  valuedict(genderpairs)[gendercode(f)]
end



"""Extract case code from a `FormUrn`.
$SIGNATURES
"""
function casecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[8])
end

"""Look up label for case code from a `FormUrn`.
$SIGNATURES
"""
function caselabel(f::FormUrn)
    casecode(f) == 0 ? "none" :  valuedict(casepairs)[casecode(f)]
end



"""Extract case code from a `FormUrn`.
$SIGNATURES
"""
function degreecode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[9])
end


"""Look up label for degree code from a `FormUrn`.
$SIGNATURES
"""
function degreelabel(f::FormUrn)
    degreecode(f) == 0 ? "none" :  valuedict(degreepairs)[degreecode(f)]
end


"""Extract case code from a `FormUrn`.
$SIGNATURES
"""
function uninflectedcode(f::FormUrn)
    parse(Int64, split(f.objectid, "")[10])
end



"""Look up label for uninflected code from a `FormUrn`.
$SIGNATURES
"""
function uninflectedlabel(f::FormUrn)
    uninflectedcode(f) == 0 ? "none" :  valuedict(uninflectedpairs)[uninflectedcode(f)]
end

# PosPNTMVGCDCat