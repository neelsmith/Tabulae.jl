@testset "Test analysis of parsing results for adjectives" begin
    repo = dirname(pwd())
    p = Tabulae.min_parser(repo)

    cara = parsetoken("cara", p)
    @test length( cara) == 6

    masc = lmpGender("masculine")
    fem = lmpGender("feminine")
    neut = lmpGender("neuter")

    sg = lmpNumber("singular")
    pl = lmpNumber("plural")
    
    nom = lmpCase("nominative")
    voc = lmpCase("vocative")
    acc = lmpCase("accusative")
    abl = lmpCase("ablative")

    pos = lmpDegree("positive")
    comp = lmpDegree("comparative")
    sup = lmpDegree("superlative")

    expectedcara = [
        LMFAdjective(fem, nom, sg,pos), LMFAdjective(fem, voc, sg, pos), LMFAdjective(fem, abl, sg, pos),

        LMFAdjective(neut, nom, pl, pos), LMFAdjective(neut, acc, pl, pos),  LMFAdjective(neut, voc, pl, pos)
    ]
    for adj in latinForm.(cara)
        @test adj in expectedcara
    end


    carior = parsetoken("carior", p)
    expectedcarior = [
        LMFAdjective(masc, nom, sg, comp),
        LMFAdjective(fem, nom, sg, comp),
    ]
    for adj in latinForm.(carior)
        @test adj in expectedcarior
    end


    carissimus = parsetoken("carissimus", p)
    expectedsuperlative = [LMFAdjective(masc, nom, sg, sup)]
    @test latinForm.(carissimus) == expectedsuperlative

end