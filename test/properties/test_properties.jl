@testset "Test generic functions for morphological properties" begin
    verb = LMFFiniteVerb(LMPPerson(3), LMPNumber(1), LMPTense(4), LMPMood(1), LMPVoice(1))
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

    infinitive = LMFInfinitive(lmpTense("present"), lmpVoice("active"))
    @test isnothing(lmpNumber(infinitive))
end