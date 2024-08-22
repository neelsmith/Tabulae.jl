@testset "Test CITE interfaces on gerundive rules" begin
    cexsrc = "latcommoninfl.c1pres_1|c1pres|andus|masculine|nominative|singular"
    rule = fromcex(cexsrc, TabulaeGerundiveRule)


    @test citable(rule)
    @test label(rule) == "Gerundive inflection rule: ending -andus in class c1pres can be masculine nominative singular."
    @test urn(rule) == RuleUrn("latcommoninfl.c1pres_1")


    @test cexserializable(rule)
    @test cex(rule) == "latcommoninfl.c1pres_1|c1pres|andus|masculine|nominative|singular"
    @test fromcex(cex(rule), TabulaeGerundiveRule) == rule

    dict = Dict(
        "latcommoninfl" => "urn:cite2:tabulae:latcommoninfl.v1:"
    )
     @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommoninfl.v1:c1pres_1")
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:latcommoninfl.v1:c1pres_1|c1pres|andus|masculine|nominative|singular"
 
end

@testset "Test data accessors on gerundive rule" begin
    cexsrc = "latcommoninfl.c1pres_1|c1pres|andus|masculine|nominative|singular"
    rule = fromcex(cexsrc, TabulaeGerundiveRule)
    @test id(rule) == RuleUrn("latcommoninfl.c1pres_1")
    @test inflectionclass(rule) == "c1pres"
    @test ending(rule) == "andus"

    @test label(lmpGender(rule)) == "masculine"
    @test label(lmpCase(rule)) == "nominative"
    @test label(lmpNumber(rule)) == "singular"
end
