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

end