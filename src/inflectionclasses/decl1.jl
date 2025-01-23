
const agricola =  LexemeUrn("ls.1626")
const anima =  LexemeUrn("ls.2612")
const a_ae = TabulaeInflectionClass(
    "a_ae",
    "First declension nouns with genitive singular in -ae.",
    [anima, agricola],
    PartOfSpeech.noun
)

const tenebrae =  LexemeUrn("ls.n47755")
const a_ae_pl = TabulaeInflectionClass(
    "a_ae_pl",
    "First declension nouns in plural only with genitive plural in -arum.",
    [tenebrae],
    PartOfSpeech.noun
)