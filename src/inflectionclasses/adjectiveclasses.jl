



const carus =  LexemeUrn("ls.n6903")
const us_a_um = TabulaeInflectionClass(
    "us_a_um",
    "Stem for regular three-termination adjectives with 2/1/2 declension pattern.",
    [carus],
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


regularadjectiveclasses = [
    us_a_um,
    us_a_um_positive,
    comparative
]

irregularadjectiveclasses = [
]

function adjectiveclasses()
    vcat(regularadjectiveclasses, irregularadjectiveclasses)
end
