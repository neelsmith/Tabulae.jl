@testset "Test copying of FST files to target directory" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])

end