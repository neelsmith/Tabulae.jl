@testset "Test basics of stem type" begin
    s = "latcommon.pron49339a|ls.n49339|tu|masculine|nominative|singular|personal"
    st = fromcex(s, TabulaePronounStem)
    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:",
        "ls" => "urn:cite2:tabulae:ls.v1:"
    )

    @test citable(st)
    @test label(st) == "Pronoun stem tu- (masculine)"
    @test urn(st) == StemUrn("latcommon.pron49339a")
    @test urn(st; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:pron49339a")


    @test cexserializable(st)
    @test cex(st) == s
    @test cex(st; registry = dict) == "urn:cite2:tabulae:latcommon.v1:pron49339a|urn:cite2:tabulae:ls.v1:n49339|tu|masculine|nominative|singular|personal"
    @test fromcex(cex(st), TabulaePronounStem) == st

    @test lexeme(st) == LexemeUrn("ls.n49339")
end