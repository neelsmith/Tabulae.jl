@testset "Test constructing a dataset from files" begin
   repo = dirname(pwd())
   srcdir = joinpath(repo, "datasets", "core-infl-shared") 
   tds = dataset([srcdir])
   @test isa(tds, Tabulae.Dataset)
end