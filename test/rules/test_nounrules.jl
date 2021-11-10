@testset "Test noun rules" begin
    cexsrc = "nouninfl.us_i13|us_i|um|neuter|nominative|singular"
    nounio = NounIO("nouns")
    rule = Tabulae.readrulerow(nounio, cexsrc)

    @test label(rule) == "Noun inflection rule: ending -um in class us_i can be neuter nominative singular."
    @test urn(rule) == RuleUrn("nouninfl.us_i13")
    @test cex(rule) == "nouninfl.us_i13|Noun inflection rule: ending -um in class us_i can be neuter nominative singular."

    dict = Dict(
        "nouninfl" => "urn:cite2:tabulae:nouninfl.v1:"
    )
     @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:nouninfl.v1:us_i13")
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:nouninfl.v1:us_i13|Noun inflection rule: ending -um in class us_i can be neuter nominative singular."
 
     @test Tabulae.ruleurn(rule) == RuleUrn("morphforms.2010003100")
end