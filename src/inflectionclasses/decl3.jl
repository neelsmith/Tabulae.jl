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