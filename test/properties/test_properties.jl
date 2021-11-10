@testset "Test generic functions for morphological properties" begin
    sfst = "<third><singular><perfect><indicative><active>"
    verb = Tabulae.verbfromfst(sfst)
    @test isnothing(lmpCase(verb))
    @test isnothing(lmpGender(verb))
    @test isnothing(lmpDegree(verb))
    @test isnothing(lmpUninflectedType(verb))

    noun = LMFNoun(lmpGender("masculine"), lmpCase("accusative"), lmpNumber("singular"))
    @test isnothing(lmpTense(noun))
    @test isnothing(lmpMood(noun))
    @test isnothing(lmpVoice(noun))
    @test isnothing(lmpPerson(noun))
    @test isnothing(lmpDegree(noun))

    infinitive = ""
    @test_broken isnothing(lmpNumber(infinitive))
end