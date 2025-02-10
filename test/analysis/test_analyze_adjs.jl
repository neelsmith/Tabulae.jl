# Some shorthands for tests:
masc = lmpGender("masculine")
fem = lmpGender("feminine")
neut = lmpGender("neuter")

sg = lmpNumber("singular")
pl = lmpNumber("plural")

nom = lmpCase("nominative")
voc = lmpCase("vocative")
gen = lmpCase("genitive")
acc = lmpCase("accusative")
abl = lmpCase("ablative")

pos = lmpDegree("positive")
comp = lmpDegree("comparative")
sup = lmpDegree("superlative")


@testset "Test analysis of parsing results for adjectives of type us_a_um" begin
    repo = dirname(pwd())
    p = Tabulae.min_parser(repo)

    cara = parsetoken("cara", p)
    
    expectedcara = [
        LMFAdjective(fem, nom, sg,pos), LMFAdjective(fem, voc, sg, pos), LMFAdjective(fem, abl, sg, pos),

        LMFAdjective(neut, nom, pl, pos), LMFAdjective(neut, acc, pl, pos),  LMFAdjective(neut, voc, pl, pos)
    ]
    @test length( cara) == 6
    for adj in latinForm.(cara)
        @test adj in expectedcara
    end


    carior = parsetoken("carior", p)
    expectedcarior = [
        LMFAdjective(masc, nom, sg, comp),
        LMFAdjective(fem, nom, sg, comp),
    ]
    @test length(carior) == 2
    for adj in latinForm.(carior)
        @test adj in expectedcarior
    end


    carissimus = parsetoken("carissimus", p)
    expectedsuperlative = [LMFAdjective(masc, nom, sg, sup)]
    @test latinForm.(carissimus) == expectedsuperlative

end

@testset "Test analysis of parsing results for adjectives of type is_e" begin
    repo = dirname(pwd())
    p = Tabulae.min_parser(repo)

    levis = parsetoken("levis", p)
    expectedlevis = [
        LMFAdjective(masc, nom, sg,pos), LMFAdjective(masc, voc, sg, pos), LMFAdjective(fem, nom, sg, pos), LMFAdjective(fem, voc, sg, pos),


        LMFAdjective(masc, gen, sg,pos), 
        LMFAdjective(fem, gen, sg,pos), 
        LMFAdjective(neut, gen, sg,pos), 
    ]
    @test length(levis) == 7
    for adj in latinForm.(levis)
        @test adj in expectedlevis
    end


    levior = parsetoken("levior", p)
    expectedlevior = [
        LMFAdjective(masc, nom, sg, comp),
        LMFAdjective(fem, nom, sg, comp),
    ]
    @test length(levior) == 2
    for adj in latinForm.(levior)
        @test adj in expectedlevior
    end
    

    levissimus = parsetoken("levissimus", p)
    expectedsuperlative = [LMFAdjective(masc, nom, sg, sup)]
    @test latinForm.(levissimus) == expectedsuperlative


end

@testset "Test analysis of parsing results for adjectives with differing stems for different degrees" begin
    repo = dirname(pwd())
    p = Tabulae.min_parser(repo)

    bonus = parsetoken("bonus", p)
    expectedpos = [LMFAdjective(masc,nom,sg,pos)]
    @test latinForm.(bonus) == expectedpos


    melior =  parsetoken("melior", p)
    expectedcomp = [
        LMFAdjective(masc,nom,sg,comp),
        LMFAdjective(fem,nom,sg,comp)
    ]
    for adj in latinForm.(melior)
        @test adj in expectedcomp
    end

    optimus =  parsetoken("optimus", p)
    expectedsup = [ LMFAdjective(masc,nom,sg,sup)]
    @test latinForm.(optimus) == expectedsup
end

# 0_ius 
