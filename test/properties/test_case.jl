@testset "Test gender property" begin
    gender = lmpGender("feminine")
    @test gender == lmpGender(2)
    @test lmpGender(2) == LMPGender(2)
    @test code(gender) == 2
    @test label(gender) == "feminine"
    @test_throws DomainError lmpGender("present")
    @test_throws DomainError lmpGender(5)
end