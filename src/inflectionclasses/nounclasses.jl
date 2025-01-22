
const donum = LexemeUrn("ls.n14736")
const animus = LexemeUrn("ls.n2636")
const us_i = TabulaeInflectionClass(
    "us_i",
    "Second declension nouns with genitive singular in -i.",
    [animus, donum],
    PartOfSpeech.noun
)

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

const mythos = LexemeUrn("ls.n30316")
const os_i = TabulaeInflectionClass(
    "os_i",
    "Masculine Greek nouns with nominative singular in -os assimilated to second declension.",
    [mythos],
    PartOfSpeech.noun
)