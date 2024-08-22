@testset "Test CITE interfaces on pronoun rules" begin
    cexsrc = "proninfl.pronouns4|personal"
    rule = fromcex(cexsrc, TabulaePronounRule)

    @test citable(rule)
    @test label(rule) == "Pronoun inflection rule: type of stem proninfl.pronouns4 is personal"
    @test urn(rule) == RuleUrn("proninfl.pronouns4")


    @test cexserializable(rule)
    @test cex(rule) == cexsrc
    @test fromcex(cex(rule), TabulaePronounRule) == rule

    dict = Dict(
        "proninfl" => "urn:cite2:tabulae:proninfl.v1:"
    )
     @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:proninfl.v1:pronouns4")
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:proninfl.v1:pronouns4|personal"
 
end



