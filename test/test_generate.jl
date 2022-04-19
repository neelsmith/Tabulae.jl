@testset "Test generating forms" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    

    stem = TabulaeNounStem(StemUrn("latcommon.nounn14736"), LexemeUrn("ls.n14736"), "don", LMPGender(3), "us_i")
    rule = TabulaeNounRule(RuleUrn("nouninfl.us_i13"), "us_i", "um", LMPGender(3), LMPCase(1), LMPNumber(1))
    
    ruleresults = generate(rule, stem, tds)
    @test ruleresults == ["donum"]
    
    frm = lmForm(rule)
    lex = lexeme(stem)
    formresults  = generate(frm, lex, tds)
    @test formresults == ruleresults
end