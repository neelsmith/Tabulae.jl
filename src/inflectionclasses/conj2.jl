
const debeo = LexemeUrn("ls.n12387")
const conj2 = TabulaeInflectionClass(
    "conj2",
    "Regular second conjugation verbs with all principal parts predictable from a single stem.",
    [debeo],
    PartOfSpeech.verb
)

const vereor = LexemeUrn("ls.n50537")
const conj2dep = TabulaeInflectionClass(
    "conj2dep",
    "Regular deponent verbs of the second conjugation with all principal parts predicatible from a single stem.",
    [vereor],
    PartOfSpeech.verb
)
