@testset "Test generating forms" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    

    stem = TabulaeNounStem(StemUrn("latcommon.nounn14736"), LexemeUrn("ls.n14736"), "don", LMPGender(3), "us_i")
    rule = TabulaeNounRule(RuleUrn("nouninfl.us_i13"), "us_i", "um", LMPGender(3), LMPCase(1), LMPNumber(1))
    expected = Analysis("donum", LexemeUrn("ls.n14736"), FormUrn("forms.2010003100"), StemUrn("latcommon.nounn14736"), RuleUrn("nouninfl.us_i13"), "donum")

    ruleresults = generate(stem, rule,  tds)
    @test ruleresults == [expected]
    
    frm = lmForm(rule)
    lex = lexeme(stem)
    formresults  = generate(lex,frm,  tds)
    @test formresults == ruleresults
end