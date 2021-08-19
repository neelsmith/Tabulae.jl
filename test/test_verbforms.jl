
@testset "Test parsing a FormUrn into a verb form" begin
    frm = FormUrn("morphforms.3311110000")
    @test Tabulae.verbfromurn(frm) ==  LatinFiniteVerb(3,1,1,1,1)
end


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

@testset "Test parsing a LatinFiniteVerb form from SFST output" begin
    sfst = "<u>latcommon.compoundn65_1</u><u>ls.n65</u><#>abiret<3rd><sg><impft><subj><act><irregcverb><div><irregcverb><u>irreginfl.3</u>"
    infl = split(sfst,"<div>")[2]
    noun = Tabulae.verbfromfst(infl)
    expected = LatinFiniteVerb(3,1,3,2,1)
    @test noun == expected
    
end