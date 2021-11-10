@testset "Test number property" begin
    num = lmpNumber("plural")
    @test num == lmpNumber(2)
    @test lmpNumber(2) == LMPNumber(2)
    @test code(num) == 2
    @test label(num) == "plural"
    @test_throws DomainError lmpPerson("present")
    @test_throws DomainError lmpPerson(5)
end