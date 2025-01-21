@testset "Test adjective stems" begin
    cexsrc = "latcommon.adjn5558|ls.n5558|bon|us_a_um"
    stem = fromcex(cexsrc, TabulaeAdjectiveStem)
    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:"
    )

    @test citable(stem)
    @test label(stem) == "Adjective stem bon-"
    @test urn(stem) == StemUrn("latcommon.adjn5558")
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:adjn5558")


    @test cexserializable(stem)
    @test cex(stem) == cexsrc
    @test cex(stem; registry = dict) == "urn:cite2:tabulae:latcommon.v1:adjn5558|ls.n5558|bon|us_a_um"
    @test fromcex(cex(stem), TabulaeAdjectiveStem) == stem

end