@testset "Test CITE interfaces on participle rules" begin
    src = "latcommoninfl.are_conj1presapl1|conj1|ans|masculine|nominative|singular|present|active"
    ptcpl = fromcex(src, TabulaeParticipleRule)

    @test citable(ptcpl)
    @test urn(ptcpl) == RuleUrn("latcommoninfl.are_conj1presapl1")
    @test label(ptcpl)== "Participle inflection rule: ending -ans in class conj1 can be present activeparticiple, masculine nominative singular."

    @test cexserializable(ptcpl)
    @test cex(ptcpl) == src
    @test fromcex(cex(ptcpl), TabulaeParticipleRule) == ptcpl
end

@testset "Test accessors for participle rules" begin
end