
@testset "Test CITE interfaces on adjective rules" begin
    cexsrc = "latcommonadjinfl.us_a_um9|us_a_um|os|masculine|accusative|plural|positive"
    rule = fromcex(cexsrc, TabulaeAdjectiveRule)


    @test citable(rule)
    @test label(rule) == "Adjective inflection rule: ending -os in class us_a_um can be masculine accusative plural positive."
    @test urn(rule) == RuleUrn("latcommonadjinfl.us_a_um9")


    @test cexserializable(rule)
    @test cex(rule) == "latcommonadjinfl.us_a_um9|us_a_um|os|masculine|accusative|plural|positive"
    @test fromcex(cex(rule), TabulaeAdjectiveRule) == rule

    dict = Dict(
        "latcommonadjinfl" => "urn:cite2:tabulae:latcommonadjinfl.v1:"
    )
     @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommonadjinfl.v1:us_a_um9")
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:latcommonadjinfl.v1:us_a_um9|us_a_um|os|masculine|accusative|plural|positive"
 
     #@test Tabulae.ruleurn(rule) == RuleUrn("tabulaeforms.2010003100")
end

@testset "Test data accessors on adjective rule" begin
    cexsrc = "latcommonadjinfl.us_a_um9|us_a_um|os|masculine|accusative|plural|positive"
    rule = fromcex(cexsrc, TabulaeAdjectiveRule)
    @test id(rule) == RuleUrn("latcommonadjinfl.us_a_um9")
    @test inflectionclass(rule) == "us_a_um"
    @test ending(rule) == "os"

    @test label(lmpGender(rule)) == "masculine"
    @test label(lmpCase(rule)) == "accusative"
    @test label(lmpNumber(rule)) == "plural"
end
