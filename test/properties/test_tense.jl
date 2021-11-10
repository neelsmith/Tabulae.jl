@testset "Test tense property" begin
    tense = lmpTense("present")
    @test tense  == LMPTense(1)
    @test lmpTense(1) == LMPTense(1)
    @test code(tense) == 1
    @test label(tense) == "present"

    @test_throws DomainError lmpTense("subjunctive")
    @test_throws DomainError lmpTense(10)

end