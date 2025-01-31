#=
latcommon.verbn11525a|ls.n11525|cred|c3pres
latcommon.verbn11525b|ls.n11525|credid|pftact
latcommon.verbn11525c|ls.n11525|credit|pftpass
=#

#=
latcommon.verbn11525a|ls.n11525|cred|c3pres
latcommon.verbn11525b|ls.n11525|credid|pftact
latcommon.verbn11525c|ls.n11525|credit|pftpass
=#




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