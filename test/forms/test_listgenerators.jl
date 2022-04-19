@testset "Test generating lists of forms" begin
    nouns = nounforms()
    total = length(Tabulae.genderlabels) * length(Tabulae.caselabels) * length(Tabulae.numberlabels) 
    @test length(nouns) == total
end