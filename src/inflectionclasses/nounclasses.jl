decl1 = [a_ae, a_ae_pl]
decl2 = [us_i, os_i, null_i]
decl3 = [en_inis, us_eris, null_is, x_cis, s_tis, null_dis]
decl4 = [us_us]
decl5 = [es_ei]



const nihil =  LexemeUrn("ls.n30954")
const indeclinable = TabulaeInflectionClass(
    "indeclinable",
    "Indeclinable neuter nouns.",
    [nihil],
    PartOfSpeech.noun
)

indecl = [indeclinable]


function nounclasses()
    vcat(decl1, decl2, decl3, decl4, decl5, indecl)
end



