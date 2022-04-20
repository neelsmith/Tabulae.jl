

@testset "Test fst formatting" begin
    nounio = NounIO("nouns")
    nounrulecex = "nouninfl.us_i13|us_i|um|neuter|nominative|singular"
    nounrule = Tabulae.readrulerow(nounio, nounrulecex)
    expectednounrule = "<us_i><noun><um><neuter><nominative><singular><u>nouninfl\\.us\\_i13</u>"
    @test fst(nounrule) == expectednounrule
    nounstemcex  = "latcommon.nounn14736|ls.n14736|don|neuter|us_i"
    nounstem = Tabulae.readstemrow(nounio, nounstemcex)
    expectednounstem = "<u>latcommon\\.nounn14736</u><u>ls\\.n14736</u>don<neuter><us_i>"
    @test fst(nounstem) == expectednounstem
end