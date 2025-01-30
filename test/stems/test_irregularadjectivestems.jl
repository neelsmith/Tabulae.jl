
@testset "Test CITE interfaces on irregular adjective stems" begin
    cexsrc = "latcommon.irregpron1896p|ls.n1896|aliam|feminine|accusative|singular|positive|irregularadjective"
    
    stem = fromcex(cexsrc, TabulaeIrregularAdjectiveStem)
    @test stem isa TabulaeIrregularAdjectiveStem

    @test citable(stem)
    @test label(stem) == "Irregular adjective form aliam"
    @test urn(stem) == StemUrn("latcommon.irregpron1896p")
    

    @test cexserializable(stem)
    @test cex(stem) ==  cexsrc
    @test fromcex(cex(stem), TabulaeIrregularAdjectiveStem) == stem

end