
@testset "Test CITE interfaces on irregular infinitive stems" begin
    cexsrc = "latcommon.irreginf65|ls.n65|abire|present|active|irregularinfinitive"
    stem = fromcex(cexsrc, TabulaeIrregularInfinitive)
    @test stem isa TabulaeIrregularInfinitive

    @test citable(stem)
    @test label(stem) == "Irregular infinitive form abire (present active)"
    @test urn(stem) == StemUrn("latcommon.irreginf65")
    

    @test cexserializable(stem)
    @test cex(stem) ==  cexsrc
    @test fromcex(cex(stem), TabulaeIrregularInfinitive) == stem

end