@testset "Test utilities for building a StringParser" begin


    a = Analysis("donum", LexemeUrn("ls.n14736"), FormUrn("forms.2010003100"), StemUrn("latcommon.nounn14736"), RuleUrn("nouninfl.us_i13"))
    expected = "donum|ls.n14736|forms.2010003100|latcommon.nounn14736|nouninfl.us_i13"
    @test analysis_line(a) == expected


    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    tdlines = analysis_lines(tds)
    donum = filter(l -> startswith(l, "donum|"),  tdlines)
    @test length(donum) == 3 # nom, acc, voc sing


    alist = map(ln -> Tabulae.fromline(ln), donum)
    @test alist isa Vector{Analysis}

    u = "https://raw.githubusercontent.com/neelsmith/Tabulae.jl/dev/test/samplecex/analyses.cex"
    parser1 = stringParser(u, UrlReader)
    @test parser1 isa StringParser

    f = joinpath(pwd(), "samplecex", "analyses.cex")
    parser2 = stringParser(f, FileReader)
    @test parser2 isa StringParser
    @test length(parser1.entries) == length(parser2.entries)
end

@testset "Test StringParser against core data set" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    parser = stringParser(tds) 
end