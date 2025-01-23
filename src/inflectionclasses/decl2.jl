const donum = LexemeUrn("ls.n14736")
const animus = LexemeUrn("ls.n2636")
const us_i = TabulaeInflectionClass(
    "us_i",
    "Second declension nouns with genitive singular in -i.",
    [animus, donum],
    PartOfSpeech.noun
)


const mythos = LexemeUrn("ls.n30316")
const os_i = TabulaeInflectionClass(
    "os_i",
    "Masculine Greek nouns with nominative singular in -os assimilated to second declension.",
    [mythos],
    PartOfSpeech.noun
)