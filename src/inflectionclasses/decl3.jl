const nomen = LexemeUrn("ls.n31131")
const en_inis = TabulaeInflectionClass(
    "en_inis",
    "Third declension nouns with nominative singular in -en for stem in -in-.",
    [nomen],
    PartOfSpeech.noun
)

const consul = LexemeUrn("ls.n10676")
const null_is = TabulaeInflectionClass(
    "0_is",
    "Third declension nouns with nominative singular identical to stem.",
    [consul],
    PartOfSpeech.noun
)

const auctoritas = LexemeUrn("ls.n4422")
const s_tis = TabulaeInflectionClass(
    "s_tis",
    "Third declension nouns with nominative singular ending in -s, genitive singular in -tis.",
    [auctoritas],
    PartOfSpeech.noun
)


const genus = LexemeUrn("ls.n19477")
const us_eris = TabulaeInflectionClass(
    "us_eris",
    "Third declension nouns with nominative singular ending in -us, genitive singular in -eris.",
    [genus],
    PartOfSpeech.noun
)



const dux = LexemeUrn("ls.n15002")
const x_cis = TabulaeInflectionClass(
    "x_cis",
    "Third declension nouns with nominative singular ending in -x, genitive singular in -cis.",
    [dux],
    PartOfSpeech.noun
)