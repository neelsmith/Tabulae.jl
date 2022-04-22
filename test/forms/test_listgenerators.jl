@testset "Test generating lists of forms" begin
    nouns = nounforms()
    total = length(Tabulae.genderlabeldict) * length(Tabulae.caselabeldict) * length(Tabulae.numberlabeldict) 
    @test length(nouns) == total
end