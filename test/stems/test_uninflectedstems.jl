@testset "Test basics of uninflected stem type" begin
    s = "latcommon.uninfln11872|ls.n11872|cum|preposition"
    st = fromcex(s, TabulaeUninflectedStem)
    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:",
        "ls" => "urn:cite2:tabulae:ls.v1:"
    )

    @test citable(st)
    @test label(st) == "Uninflected preposition cum"
    @test urn(st) == StemUrn("latcommon.uninfln11872")
    @test urn(st; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:uninfln11872")


    @test cexserializable(st)
    @test cex(st) == s
    @test cex(st; registry = dict) == "urn:cite2:tabulae:latcommon.v1:uninfln11872|urn:cite2:tabulae:ls.v1:n11872|cum|preposition"
    @test fromcex(cex(st), TabulaeUninflectedStem) == st

    @test lexeme(st) == LexemeUrn("ls.n11872")
end