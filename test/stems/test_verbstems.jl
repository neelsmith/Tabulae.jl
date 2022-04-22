@testset "Test verb stems" begin
    cexsrc = "latcommon.verbn2280|ls.n2280|am|conj1"
    verbIO = VerbIO("verbs")
    stem = Tabulae.readstemrow(verbIO, cexsrc)

    @test label(stem) == "Verb stem am-"
    @test urn(stem) == StemUrn("latcommon.verbn2280")
    @test cex(stem) == "latcommon.verbn2280|Verb stem am-"

    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:"
    )
     @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:verbn2280")
     @test cex(stem; registry = dict) == "urn:cite2:tabulae:latcommon.v1:verbn2280|Verb stem am-"
 
end