@testset "Test CITE interfaces on uninflected rules" begin
    cexsrc = "uninflrules.uninfl1|preposition"
    rule = fromcex(cexsrc, TabulaeUninflectedRule)

    @test citable(rule)
    @test label(rule) == "Rule for uninflected form: type of rule uninflrules.uninfl1 is preposition"
    @test urn(rule) == RuleUrn("uninflrules.uninfl1")


    @test cexserializable(rule)
    @test cex(rule) == cexsrc
    @test fromcex(cex(rule), TabulaeUninflectedRule) == rule

    dict = Dict(
        "uninflrules" => "urn:cite2:tabulae:uninflrules.v1:"
    )
     @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:uninflrules.v1:uninfl1")
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:uninflrules.v1:uninfl1|preposition"
 
end

