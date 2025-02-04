
const audio = LexemeUrn("ls.n4453")
const conj4 = TabulaeInflectionClass(
    "conj4",
    "Regular fourth conjugation verbs with all principal parts predictable from a single stem.",
    [audio],
    PartOfSpeech.verb
)

const potior = LexemeUrn("ls.n37307")
const conj4dep = TabulaeInflectionClass(
    "conj4dep",
    "Regular deponent verbs of the fourth conjugation with all principal parts predictable from a single stem.",
    [potior],
    PartOfSpeech.verb
)
