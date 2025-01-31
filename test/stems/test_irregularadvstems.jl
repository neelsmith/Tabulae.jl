
@testset "Test CITE interfaces on irregular adverb stems" begin
    cexsrc = "latcommonirregadv.n31151|ls.n31151|non|positive|irregularadverb"
    stem = fromcex(cexsrc, TabulaeIrregularAdverbStem)
    @test stem isa TabulaeIrregularAdverbStem

    @test citable(stem)
    @test label(stem) == "Irregular adverb form non (positive)"
    @test urn(stem) == StemUrn("latcommonirregadv.n31151")
    

    @test cexserializable(stem)
    @test cex(stem) ==  cexsrc
    @test fromcex(cex(stem), TabulaeIrregularAdverbStem) == stem

end