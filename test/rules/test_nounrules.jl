@testset "Test CITE interfaces on noun rules" begin
    cexsrc = "nouninfl.us_i13|us_i|um|neuter|nominative|singular"
    rule = fromcex(cexsrc, TabulaeNounRule)


    @test citable(rule)
    @test label(rule) == "Noun inflection rule: ending -um in class us_i can be neuter nominative singular."
    @test urn(rule) == RuleUrn("nouninfl.us_i13")


    @test cexserializable(rule)
    @test cex(rule) == "nouninfl.us_i13|us_i|um|neuter|nominative|singular"
    @test fromcex(cex(rule), TabulaeNounRule) == rule

    dict = Dict(
        "nouninfl" => "urn:cite2:tabulae:nouninfl.v1:"
    )
     @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:nouninfl.v1:us_i13")
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:nouninfl.v1:us_i13|us_i|um|neuter|nominative|singular"
 
     @test Tabulae.ruleurn(rule) == RuleUrn("tabulaeforms.2010003100")
end

@testset "Test data accessors on noun rule" begin
    cexsrc = "nouninfl.us_i13|us_i|um|neuter|nominative|singular"
    rule = fromcex(cexsrc, TabulaeNounRule)
    @test id(rule) == RuleUrn("nouninfl.us_i13")
    @test inflectionclass(rule) == "us_i"
    @test ending(rule) == "um"

    @test label(lmpGender(rule)) == "neuter"
    @test label(lmpCase(rule)) == "nominative"
    @test label(lmpNumber(rule)) == "singular"
end
