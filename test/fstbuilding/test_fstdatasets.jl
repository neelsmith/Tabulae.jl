@testset "Test composing FST files for contents of Tabulae.Dataset" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])

    parserdir =  joinpath(tempdir(), "testtabbuild")
    if ! ispath(parserdir)
        mkdir(parserdir)
    end

    lexicon = joinpath(parserdir, "lexicon.fst")
    Tabulae.buildlexicon(tds, lexicon)
    @test isfile(lexicon)

    # Clean up: remove temporary files
    rm(parserdir; recursive = true)
    @test isfile(parserdir) == false
end

# Functions to test:
# buildparser
# compilefst
# buildmakefile
# buildfinalfst
# √ buildlexicon
# buildinflection

