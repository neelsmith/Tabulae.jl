@testset "Test voice property" begin
    voice = lmpVoice("passive")
    @test voice == LMPVoice(2)
    @test lmpVoice(2) == LMPVoice(2)
    @test code(voice) == 2
    @test label(voice) == "passive"

    @test_throws DomainError lmpVoice("middle")
    @test_throws DomainError lmpVoice(3)
end