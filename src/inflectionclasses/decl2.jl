const donum = LexemeUrn("ls.n14736")
const animus = LexemeUrn("ls.n2636")
const us_i = TabulaeInflectionClass(
    "us_i",
    "Second declension nouns with genitive singular in -i.",
    [animus, donum],
    PartOfSpeech.noun
)


const puer = LexemeUrn("ls.n39429")
const null_i = TabulaeInflectionClass(
    "0_i",
    "Second declension nouns with genitive singular in -i and nominative singular with empty stem.",
    [puer],
    PartOfSpeech.noun
)

const mythos = LexemeUrn("ls.n30316")
const os_i = TabulaeInflectionClass(
    "os_i",
    "Masculine Greek nouns with nominative singular in -os assimilated to second declension.",
    [mythos],
    PartOfSpeech.noun
)