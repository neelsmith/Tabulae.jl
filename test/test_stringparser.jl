@testset "Test utilities for building a TabulaeStringParser" begin

    a = Analysis("donum", LexemeUrn("ls.n14736"), FormUrn("forms.2010003100"), StemUrn("latcommon.nounn14736"), RuleUrn("nouninfl.us_i13"), "donum")
    expected = "donum|ls.n14736|forms.2010003100|latcommon.nounn14736|nouninfl.us_i13|donum"
    @test cex(a) == expected


    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    tdlines = analyses(tds) .|> cex
    donum = filter(l -> startswith(l, "donum|"),  tdlines)
    @test length(donum) == 3 # nom, acc, voc sing


    # THIS IS NOT A THING:
    alist = map(ln -> fromcex(ln, Analysis), donum)
    @test alist isa Vector{Analysis}

    u = "https://raw.githubusercontent.com/neelsmith/Tabulae.jl/dev/test/samplecex/analyses.cex"
    parser1 = tabulaeStringParser(u, UrlReader)
    @test parser1 isa TabulaeStringParser

    f = joinpath(pwd(), "samplecex", "analyses.cex")
    parser2 = tabulaeStringParser(f, FileReader)
    @test parser2 isa TabulaeStringParser
    @test length(parser1.entries) == length(parser2.entries)
end

@testset "Test TabulaeStringParser against core data set" begin
    repo = dirname(pwd())
    common = joinpath(repo, "datasets", "core-infl-shared") 
    lat25 = joinpath(repo, "datasets", "core-infl-lat25") 
    tds = dataset([common, lat25])
    parser = tabulaeStringParser(tds) 

    #   @test parsetoken("amo",p) # |> CitableParserBuilder.tokens    
end