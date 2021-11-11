@testset "Test copying of FST files to target directory" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])


    # CHANGE THIS WHEN WORKING
    parserdir =  joinpath(tempdir(), "testtabbuild")
    if ! ispath(parserdir)
        mkdir(parserdir)
    end

    Tabulae.installalphabet(tds, parserdir)      
    fstsrc = joinpath(repo, "fst")

    Tabulae.installsymbols(fstsrc, parserdir)

    @test isfile(joinpath(parserdir, "symbols.fst"))
    symbolsdir = joinpath(parserdir, "symbols")
    @test isfile(joinpath(symbolsdir, "alphabet.fst"))
    @test isfile(joinpath(symbolsdir, "markup.fst"))
    @test isfile(joinpath(symbolsdir, "morphsymbols.fst"))
    @test isfile(joinpath(symbolsdir, "stemtypes.fst"))
    
    # Clean up: remove temporary files
    rm(parserdir; recursive = true)
    @test isfile(parserdir) == false
end