
@testset "Test parsing a LatinNoun form from SFST output" begin
    sfst = "<u>latcommon.nounn6506</u><u>ls.n6506</u>can<noun><masc><is_is><div><is_is><noun>em<masc><acc><sg><u>latcommoninfl.is_is4</u>"
    infl = split(sfst,"<div>")[2]
    noun = Tabulae.nounfromfst(infl)
    expected = LatinNoun(1, 4, 1)
    @test noun == expected
    
end

@testset "Test parsing a FormUrn into a Noun form" begin
    frm = FormUrn("tabulaeforms.2010001100")
    @test Tabulae.nounfromurn(frm) == LatinNoun(1,1,1)
end

@testset "Test getting FormUrn for Noun form" begin
    noun = LatinNoun(1,1,1)
    formU = formurn(noun)
    @test formU == FormUrn("tabulaeforms.2010001100")

    @test Tabulae.poscode(formU) == 2
    @test Tabulae.poslabel(formU) == "noun"

    @test Tabulae.gendercode(formU) == 1
    @test Tabulae.genderlabel(formU) == "masc"


    @test Tabulae.casecode(formU) == 1
    @test Tabulae.caselabel(formU) == "nom"
    @test Tabulae.numbercode(formU) == 1
    @test Tabulae.numberlabel(formU) == "sg"


    @test Tabulae.personcode(formU) == 0
    @test Tabulae.personlabel(formU) == "none"
    
    @test Tabulae.tensecode(formU) == 0
    @test Tabulae.tenselabel(formU) == "none"
    @test Tabulae.moodcode(formU) == 0
    @test Tabulae.moodlabel(formU) == "none"
    @test Tabulae.voicecode(formU) == 0
    @test Tabulae.voicelabel(formU) == "none"

    @test Tabulae.degreecode(formU) == 0
    @test Tabulae.degreelabel(formU) == "none"
    @test Tabulae.uninflectedcode(formU) == 0

end