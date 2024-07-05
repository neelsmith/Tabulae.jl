

@testset "Test CITE interfaces for irregular rules type" begin
    s = "irreginfl.irregular1|irregularnoun"
    rule = fromcex(s, TabulaeIrregularRule)
    @test rule isa TabulaeIrregularRule
    @test cexserializable(rule)
    @test cex(rule) == s
    @test fromcex(cex(rule), TabulaeIrregularRule) == rule


    @test citable(rule)
    @test urn(rule) == RuleUrn("irreginfl.irregular1")
    @test label(rule) == "Uninflected rule: irreginfl.irregular1 applies to type irregularnoun."
end

@testset "Test accessors on irregular rules type" begin
    s = "irreginfl.irregular1|irregularnoun"
    rule = fromcex(s, TabulaeIrregularRule)

    @test inflectionclass(rule) == "irregularnoun"
    @test urn(rule) == RuleUrn("irreginfl.irregular1")
    @test isempty(ending(rule))
end