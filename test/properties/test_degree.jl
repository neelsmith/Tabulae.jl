@testset "Test degree property" begin
    degree = lmpDegree("superlative")
    @test degree  == LMPDegree(3)
    @test lmpDegree(3) == LMPDegree(3)
    @test code(degree) == 3
    @test label(degree) == "superlative"

    @test_throws DomainError lmpDegree("subjunctive")
    @test_throws DomainError lmpDegree(10)

end