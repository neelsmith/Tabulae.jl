@testset "Test CITE interfaces on infinitive rules" begin
    src = "latcommoninfl.are_inf1|conj1|are|present|active"
    rule = fromcex(src, TabulaeInfinitiveRule)
    @test rule isa TabulaeInfinitiveRule
    @test citable(rule)
    @test urn(rule) == RuleUrn("latcommoninfl.are_inf1")
    @test label(rule) == "Infinitive inflection rule: ending -are in class conj1 can be  label(rule.vtense) active."

    @test cexserializable(rule)
    @test fromcex(cex(rule), TabulaeInfinitiveRule) == rule

end


@testset "Test data accessors on infinitive rules" begin
    src = "latcommoninfl.are_inf1|conj1|are|present|active"
    r = fromcex(src, TabulaeInfinitiveRule)
   
    @test id(r) == RuleUrn("latcommoninfl.are_inf1")
    @test ending(r) == "are"
    @test  inflectionclass(r) == "conj1"
    @test label(lmpTense(r)) == "present"
    @test label(lmpVoice(r)) == "active"

"present"
end