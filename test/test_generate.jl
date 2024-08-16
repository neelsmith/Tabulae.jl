@testset "Test generating regular verb forms" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])

    vstem = fromcex("latcommon.verbn12387|ls.n12387|deb|conj2", TabulaeVerbStem)
    vrule = fromcex("latcommon.ere_conj2fut3|conj2|ebit|third|singular|future|indicative|active", TabulaeFiniteVerbRule)

    regularforms = generate(vstem, vrule, tds)
    expected = Analysis("debebit", LexemeUrn("ls.n12387"), FormUrn("forms.3313110000"), 
    StemUrn("latcommon.verbn12387"), RuleUrn("latcommon.ere_conj2fut3"), "debebit", "A")
    @test regularforms == [expected]
end

@testset "Test generating regular noun forms" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])
    

    stem = TabulaeNounStem(StemUrn("latcommon.nounn14736"), LexemeUrn("ls.n14736"), "don", LMPGender(3), "us_i")
    rule = TabulaeNounRule(RuleUrn("nouninfl.us_i13"), "us_i", "um", LMPGender(3), LMPCase(1), LMPNumber(1))
    expected = Analysis("donum", LexemeUrn("ls.n14736"), FormUrn("forms.2010003100"), StemUrn("latcommon.nounn14736"), RuleUrn("nouninfl.us_i13"), "donum", "A")

    ruleresults = generate(stem, rule,  tds)
    @test ruleresults == [expected]
    
    frm = latinForm(rule)
    lex = lexeme(stem)
    formresults  = generate(lex,frm,  tds)
    @test formresults == ruleresults
end

@testset "Test generating pronoun forms" begin
    repo = dirname(pwd())
    srcdir = joinpath(repo, "datasets", "core-infl-shared") 
    tds = dataset([srcdir])

    rulecex = "proninfl.pronouns4|personal"
    rule = fromcex(rulecex, TabulaePronounRule)

    stemcex = "latcommon.pron49339a|ls.n49339|tu|masculine|nominative|singular|personal"
    stem = fromcex(stemcex, TabulaePronounStem)

    results = generate(stem, rule, tds)
    expected = Analysis("tu", LexemeUrn("ls.n49339"), FormUrn("forms.8010001100"), 
    StemUrn("latcommon.pron49339a"), RuleUrn("proninfl.pronouns4"), "tu", "A")
    @test results == [expected]

end