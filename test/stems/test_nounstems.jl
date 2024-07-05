@testset "Test noun stems" begin
    cexsrc = "latcommon.nounn14736|ls.n14736|don|neuter|us_i"
    stem = fromcex(cexsrc, TabulaeNounStem)
    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:"
    )

    @test citable(stem)
    @test label(stem) == "Noun stem don- (neuter)"
    @test urn(stem) == StemUrn("latcommon.nounn14736")
    @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:nounn14736")


    @test cexserializable(stem)
    @test cex(stem) == cexsrc
    @test cex(stem; registry = dict) == "urn:cite2:tabulae:latcommon.v1:nounn14736|ls.n14736|don|neuter|us_i"
    @test fromcex(cex(stem), TabulaeNounStem) == stem

end