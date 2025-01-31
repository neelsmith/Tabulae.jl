
const amo = LexemeUrn("ls.n2280")
const conj1 = TabulaeInflectionClass(
    "conj1",
    "Regular first conjugation verbs with all principal parts predictable from a single stem.",
    [amo],
    PartOfSpeech.verb
)

const precor = LexemeUrn("ls.n38245")
const conj1dep = TabulaeInflectionClass(
    "conj1dep",
    "Regular deponent verbs of the first conjugation with all principal parts predictable from a single stem.",
    [precor],
    PartOfSpeech.verb
)