
@testset "Test CITE interfaces on irregular noun stems" begin
    cexsrc = "latcommon.irregn13573gbis|ls.n13573|dii|masculine|nominative|plural|irregularnoun"
    
    stem = fromcex(cexsrc, TabulaeIrregularNounStem)
    @test stem isa TabulaeIrregularNounStem

    @test citable(stem)


    @test label(stem) == "Irregular noun form dii"
    @test urn(stem) == StemUrn("latcommon.irregn13573gbis")
    

    @test cexserializable(stem)
    @test cex(stem) ==  cexsrc
    @test fromcex(cex(stem), TabulaeIrregularNounStem) == stem

end