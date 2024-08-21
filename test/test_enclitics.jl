
@testset "Test parsing enclitic writing of multiple morphemes" begin
    #Gen. 6.18
    #s = "Et statuam fedus meum tecum."
    otkn = "tecum"

    repo = dirname(pwd())
    common = joinpath(repo, "datasets", "core-infl-shared")
    tds = Tabulae.Dataset([common])
    p = tabulaeStringParser(tds)
    
    parses = parsetoken(otkn, p)
    @test length(parses) == 3
    mtkns = mtoken.(parses) |> unique
    @test mtkns == ["te", "cum"]
    mtknids = mtokenid.(parses) |> unique
    @test mtknids == ["A", "B"]
    pronforms = filter(p -> mtoken(p) == "te", parses)  .|> latinForm

    @test pronforms[1] isa LMFPronoun
    @test pronforms[2] isa LMFPronoun

end