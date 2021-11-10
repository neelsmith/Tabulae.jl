
@testset "Test parsing a FormUrn into an uninflected Latin form" begin
    frm = FormUrn("morphforms.1000000002")
    @test Tabulae.uninflectedfromurn(frm) == LatinUninflectedForm(2)
end


@testset "Test getting FormUrn for an uninflected Latin form" begin
    uninflected = LatinUninflectedForm(2)
    formU = formurn(uninflected)
    @test formU == FormUrn("morphforms.1000000002")
   
    @test Tabulae.poscode(formU) == 1
    @test Tabulae.poslabel(formU) == "uninflected"

    @test Tabulae.gendercode(formU) == 0
    @test Tabulae.genderlabel(formU) == "none"
    @test Tabulae.casecode(formU) == 0
    @test Tabulae.caselabel(formU) == "none"
    @test Tabulae.numbercode(formU) == 0
    @test Tabulae.numberlabel(formU) == "none"
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


    @test Tabulae.uninflectedcode(formU) == 2
    @test Tabulae.uninflectedlabel(formU) == "preposition"

end