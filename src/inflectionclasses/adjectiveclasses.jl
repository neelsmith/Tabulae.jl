



const carus =  LexemeUrn("ls.n6903")
const us_a_um = TabulaeInflectionClass(
    "us_a_um",
    "Stem for regular three-termination adjectives with 2/1/2 declension pattern.",
    [carus],
    PartOfSpeech.adjective
)


const dexter =  LexemeUrn("ls.n13648")
const er_era_erum = TabulaeInflectionClass(
    "er_era_erum",
    "Stem for regular three-termination adjectives with 2/1/2 declension pattern, nominative singular ending in -er-, genitive singular stem ending in -er-.",
    [dexter],
    PartOfSpeech.adjective
)


const noster =  LexemeUrn("ls.n31216")
const er_ra_rum = TabulaeInflectionClass(
    "er_ra_rum",
    "Stem for regular three-termination adjectives with 2/1/2 declension pattern, nominative singular ending in -er-, genitive singular stem ending in -r-.",
    [noster],
    PartOfSpeech.adjective
)


const bonus =  LexemeUrn("ls.n5558")
const us_a_um_positive = TabulaeInflectionClass(
    "us_a_um_positive",
    "Stem for the positive degree of a regular three-termination adjectives with 2/1/2 declension pattern.",
    [bonus],
    PartOfSpeech.adjective
)

const melior =  LexemeUrn("ls.n5558")
const comparative = TabulaeInflectionClass(
    "comparative",
    "Stem for the comparative degree of an adjective with distinct stems for different degrees.",
    [melior],
    PartOfSpeech.adjective
)


const optimus =  LexemeUrn("ls.n5558")
const superlative = TabulaeInflectionClass(
    "superlative",
    "Stem for the superlative degree of an adjective with distinct stems for different degrees.",
    [optimus],
    PartOfSpeech.adjective
)


regularadjectiveclasses = [
    us_a_um,
    er_era_erum, er_ra_rum,


    us_a_um_positive,
    comparative,
    superlative 
    
]

irregularadjectiveclasses = [
]

function adjectiveclasses()
    vcat(regularadjectiveclasses, irregularadjectiveclasses)
end
