
@testset "Test CITE interfaces on irregular verb stems" begin
    cexsrc = "latcommon.irregverbn46529a|ls.n46529|sum|first|singular|present|indicative|active|irregularfiniteverb"
    stem = fromcex(cexsrc, TabulaeIrregularVerb)
    @test stem isa TabulaeIrregularVerb

    @test citable(stem)
    @test label(stem) == "Irregular verb form sum (first singular present indicative active)"
    @test urn(stem) == StemUrn("latcommon.irregverbn46529a")
    


    @test cexserializable(stem)
    @test cex(stem) ==  cexsrc
    @test fromcex(cex(stem), TabulaeIrregularVerb) == stem

end