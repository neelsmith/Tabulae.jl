@testset "Test copying of FST files to target directory" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])


    # CHANGE THIS WHEN WORKING
    BASEWRITETEST =  joinpath(repo, "testoutquick")
    
    targetdir = joinpath(BASEWRITETEST, "testtabbuild")
    fstsrc = joinpath(repo, "fst")
    Tabulae.installalphabet(tds, targetdir)
    Tabulae.installsymbols(fstsrc, targetdir)


    @test isfile(joinpath(targetdir, "symbols.fst"))
    symbolsdir = joinpath(targetdir, "symbols")
    @test isfile(joinpath(symbolsdir, "alphabet.fst"))
    @test isfile(joinpath(symbolsdir, "markup.fst"))
    @test isfile(joinpath(symbolsdir, "morphsymbols.fst"))
    @test isfile(joinpath(symbolsdir, "stemtypes.fst"))
    
    

end