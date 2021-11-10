@testset "Test noun stems" begin
    cexsrc = "latcommon.nounn14736|ls.n14736|don|neuter|us_i"
    nounio = NounIO("nouns")
    stem = Tabulae.readstemrow(nounio, cexsrc)

    @test label(stem) == "Noun stem don- (neuter)"
    @test urn(stem) == StemUrn("latcommon.nounn14736")
    @test cex(stem) == "latcommon.nounn14736|Noun stem don- (neuter)"

    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:"
    )
     @test urn(stem; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:nounn14736")
     @test cex(stem; registry = dict) == "urn:cite2:tabulae:latcommon.v1:nounn14736|Noun stem don- (neuter)"
 
end