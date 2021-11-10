@testset "Test person property" begin
    person = lmpPerson("third")
    @test person == lmpPerson(3)
    @test lmpPerson(3) == LMPPerson(3)
    @test code(person) == 3
    @test label(person) == "third"
end