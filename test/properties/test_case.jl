@testset "Test case property" begin
    mcase = lmpCase("ablative")
    @test mcase == lmpCase(5)
    @test lmpCase(5) == LMPCase(5)
    @test code(mcase) == 5
    @test label(mcase) == "ablative"
    @test_throws DomainError lmpCase("present")
    @test_throws DomainError lmpCase(0)
end