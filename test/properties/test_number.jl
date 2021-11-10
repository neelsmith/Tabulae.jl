@testset "Test number property" begin
    num = lmpNumber("plural")
    @test num == lmpNumber(2)
    @test lmpPerson(2) == LMPNumber(2)
    @test code(num) == 2
    @test label(num) == "plural"
end