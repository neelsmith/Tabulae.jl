@testset "Test composing FST files for contents of Tabulae.Dataset" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])

    parserdir =  joinpath(repo, "quicktest", "testtabbuild")
    #parserdir =  joinpath(tempdir(), "testtabbuild")
    if ispath(parserdir)
        rm(parserdir; recursive = true)
    end
    mkdir(parserdir)

    Tabulae.installalphabet(tds, parserdir)     
    alphabet =  joinpath(parserdir, "symbols", "alphabet.fst")
    @test isfile(alphabet)

    fstsrc = joinpath(repo, "fst")
    Tabulae.installsymbols(fstsrc, parserdir)
    symbolsdir = joinpath(parserdir, "symbols")
    @test isfile(joinpath(symbolsdir, "alphabet.fst"))
    @test isfile(joinpath(symbolsdir, "markup.fst"))
    @test isfile(joinpath(symbolsdir, "morphsymbols.fst"))
    @test isfile(joinpath(symbolsdir, "stemtypes.fst"))


    lexicon = joinpath(parserdir, "lexicon.fst")
    Tabulae.buildlexicon(tds, lexicon)
    @test isfile(lexicon)

    inflection = joinpath(parserdir, "inflection.fst")
    Tabulae.buildinflection(tds, inflection)
    @test isfile(inflection)

    makefile = joinpath(parserdir, "makefile")
    Tabulae.buildmakefile(makefile)
    @test isfile(makefile)

    finalfst = joinpath(parserdir, "latin.fst")
    Tabulae.buildfinalfst(finalfst)
    @test isfile(finalfst)

    Tabulae.installalphabet(tds, parserdir)      
    fstsrc = joinpath(repo, "fst")
    Tabulae.installsymbols(fstsrc, parserdir)

    acceptor = joinpath(parserdir, "acceptor.fst")
    Tabulae.buildacceptor(acceptor)
    @test isfile(acceptor)

    Tabulae.compilefst(parserdir)
    compiled = joinpath(parserdir, "latin.a")
    @test isfile(compiled)

    # Clean up: remove temporary files
    #rm(parserdir; recursive = true)
    #@test isfile(parserdir) == false
end

# Functions to test:
# buildparser
# compilefst
# √ buildmakefile
# √ buildfinalfst
# √ buildlexicon
# √ buildinflection

