@testset "Test parsing rules in core inflection for adjective classes" begin
    p = Tabulae.coreparser(dirname(pwd()))
    

    melius = parsetoken("melius", p)
    @test length(melius) == 2
end