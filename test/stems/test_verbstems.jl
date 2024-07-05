@testset "Test verb stems" begin
    cexsrc = "latcommon.verbn2280|ls.n2280|am|conj1"
    stem = fromcex(cexsrc, TabulaeVerbStem)
    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:"
    )


    @test citable(stem)
    @test label(stem) == "Verb stem am-"
    @test urn(stem) == StemUrn("latcommon.verbn2280")
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:verbn2280")


    @test cexserializable(stem)
    @test cex(stem) == cexsrc
    @test cex(stem; registry = dict) == "urn:cite2:tabulae:latcommon.v1:verbn2280|ls.n2280|am|conj1"
    @test fromcex(cex(stem), TabulaeVerbStem) == stem
end