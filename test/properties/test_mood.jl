@testset "Test mood property" begin
    mood = lmpMood("subjunctive")
    @test mood == LMPMood(2)
    
    @test lmpMood(2) == LMPMood(2)
    @test code(mood) == 2
    @test label(mood) == "subjunctive"

end