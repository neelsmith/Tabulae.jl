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
const GERUNDIVE = 'a'
const SUPINE = 'b'


"""Dictionary of labels for analytical types ("parts of speech").

$(SIGNATURES)
"""
const analytical_types = Dict(
    UNANALYZED => "unanalyzed",
    UNINFLECTED => "uninflected",
    NOUN => "noun",
    FINITEVERB => "verb-finite",
    INFINITIVE => "infinitive",
    PARTICIPLE => "participle",
    ADJECTIVE => "adjective",
    ADVERB => "adverb",
    PRONOUN => "pronoun",
    GERUND => "gerund",
    GERUNDIVE => "gerundive",
    SUPINE => "supine"
)


"""True if form is a verbal form.
$(SIGNATURES)
"""
function is_verb(frm::T) where {T <: LatinMorphologicalForm}
    frm isa LMFFiniteVerb ||
	frm isa LMFInfinitive ||
	frm isa LMFParticiple ||
    frm isa LMFGerund ||
    frm isa LMFGerundive  ||
    frm isa LMFSupine
end