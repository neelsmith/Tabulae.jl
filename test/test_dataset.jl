@testset "Test constructing a dataset from files, and creating rules and stems objects" begin
   repo = dirname(pwd())
   srcdir = joinpath(repo, "datasets", "core-infl-shared") 
   tds = dataset([srcdir])
   @test isa(tds, Tabulae.Dataset)
   
   rules = rulesarray(tds)
   @test isa(rules, Vector{Rule})

   stems = stemsarray(tds)
   @test isa(stems, Vector{Stem})
end
