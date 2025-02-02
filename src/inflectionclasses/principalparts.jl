
# add pres for other conjugations!

const credo = LexemeUrn("ls.n11525")
const c3pres = TabulaeInflectionClass(
    "c3pres",
    "Present stem of a third conjugation verb with irregular principal parts.",
    [credo],
    PartOfSpeech.verb
)

const pftact = TabulaeInflectionClass(
    "pftact",
    "Irregular perfect active stem.",
    [credo],
    PartOfSpeech.verb
)

const pftpass = TabulaeInflectionClass(
    "pftpass",
    "Irregular perfect passive stem.",
    [credo],
    PartOfSpeech.verb
)