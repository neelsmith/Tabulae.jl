

@testset "Test getting FormUrn for Noun form" begin
    noun = LatinNoun(1,"masculine",1,"nominative",1,"singular")
    formU = formurn(noun)
    @test formU == FormUrn("morphforms.2010001100")

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