# Some shorthands for tests:

masc = lmpGender("masculine")
fem = lmpGender("feminine")
neut = lmpGender("neuter")
gen = lmpCase("genitive")
pl = lmpNumber("plural")
pres = lmpTense("present")
active = lmpVoice("active")


@testset "Test analysis of parsing results for adjectives of type us_a_um" begin
    repo = dirname(pwd())
    p = Tabulae.min_parser(repo)
    eo = LexemeUrn("ls.n15868")
    eoforms = [
        LMFParticiple(masc, gen, pl, pres, active),
        LMFParticiple(fem, gen, pl, pres, active),
        LMFParticiple(neut, gen, pl, pres, active)
    ]

    going = parsetoken("ientium", p)
    @test length(going) == 3
    for ptcpl in going
        @test lexemeurn(ptcpl) == eo
        
        @test  latinForm(ptcpl) in eoforms
    end

end
