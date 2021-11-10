@testset "Test generic functions for morphological properties" begin
    sfst = "<third><singular><perfect><indicative><active>"
    verb = Tabulae.verbfromfst(sfst)
    @test isnothing(lmpCase(verb))
    @test isnothing(lmpGender(verb))
    @test isnothing(lmpDegree(verb))
    @test isnothing(lmpUninflectedType(verb))

    noun = ""
    @test_broken isnothing(lmpTense(noun))
    @test_broken isnothing(lmpMood(noun))
    @test_broken isnothing(lmpVoice(noun))
    @test_broken isnothing(lmpPerson(noun))
    @test_broken isnothing(lmpDegree(noun))

    infinitive = ""
    @test_broken isnothing(lmpNumber(infinitive))
end