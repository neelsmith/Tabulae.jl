@testset "Test uninflected part of speech property" begin
    uninfl = lmpUninflectedType("preposition")
    @test uninfl  == lmpUninflectedType(2)
    @test code(uninfl) == 2
    @test label(uninfl) == "preposition"

    @test_throws DomainError lmpUninflectedType("subjunctive")
    @test_throws DomainError lmpUninflectedType(0)

end