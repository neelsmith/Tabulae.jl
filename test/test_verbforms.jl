

@testset "Test getting FormUrn for finite verb form" begin
    verb = LatinFiniteVerb(3,1,1,1,1)
    verbU = formurn(verb)
    @test verbU == FormUrn("morphforms.3311110000")
    @test Tabulae.poscode(verbU) == 3
    @test Tabulae.poslabel(verbU) == "verb-finite"
    @test Tabulae.personcode(verbU) == 3
    @test Tabulae.personlabel(verbU) == "3rd"
    @test Tabulae.numbercode(verbU) == 1
    @test Tabulae.numberlabel(verbU) == "sg"
    @test Tabulae.tensecode(verbU) == 1
    @test Tabulae.tenselabel(verbU) == "pres"
    @test Tabulae.moodcode(verbU) == 1
    @test Tabulae.moodlabel(verbU) == "indic"
    @test Tabulae.voicecode(verbU) == 1
    @test Tabulae.voicelabel(verbU) == "act"


    @test Tabulae.gendercode(verbU) == 0
    @test Tabulae.genderlabel(verbU) == "none"
    @test Tabulae.casecode(verbU) == 0
    @test Tabulae.caselabel(verbU) == "none"
    @test Tabulae.degreecode(verbU) == 0
    @test Tabulae.degreelabel(verbU) == "none"
    @test Tabulae.uninflectedcode(verbU) == 0
    @test Tabulae.uninflectedlabel(verbU) == "none"
end