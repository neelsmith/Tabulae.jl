@testset "Test constructing a dictionary from registry of collections" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    @test isa(tds, Tabulae.Dataset)

    dict = registry(tds)
end


@testset "Test checking presence of registry files" begin
    badsrcdir = joinpath(pwd(), "datasets", "badregistry")
    @test Tabulae.registryfilesfound(badsrcdir) == false

    goodsrcdir = joinpath(pwd(), "datasets", "goodregistry")
    @test Tabulae.registryfilesfound(goodsrcdir)
end