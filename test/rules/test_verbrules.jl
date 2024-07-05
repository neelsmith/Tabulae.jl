@testset "Test CITE interfaces on finite verb rules" begin
    cexsrc = "latcommon.are_conj1impft1|conj1|abam|first|singular|imperfect|indicative|active"
    rule = fromcex(cexsrc, TabulaeFiniteVerbRule)
    dict = Dict(
        "latcommon" => "urn:cite2:tabulae:latcommon.v1:"
    )

    @test citable(rule)
    @test label(rule) == "Verb inflection rule: ending -abam in class conj1 can be first singular imperfect indicative active."
    @test urn(rule) == RuleUrn("latcommon.are_conj1impft1")
    @test urn(rule; registry = dict) == Cite2Urn("urn:cite2:tabulae:latcommon.v1:are_conj1impft1")

    @test cexserializable(rule)
    @test cex(rule) == cexsrc
    @test fromcex(cex(rule), TabulaeFiniteVerbRule) == rule
     @test cex(rule; registry = dict) == "urn:cite2:tabulae:latcommon.v1:are_conj1impft1|conj1|abam|first|singular|imperfect|indicative|active"
 
     @test Tabulae.ruleurn(rule) == RuleUrn("tabulaeforms.3112110000")
end


@testset "Test accessors for finite verb rules" begin
end