@testset "Test finite verb forms constructor and accessors" begin
    sfst = "<third><singular><perfect><indicative><active>"
    verb = Tabulae.verbfromfst(sfst)
    expected = LMFFiniteVerb(LMPPerson(3), LMPNumber(1), LMPTense(4), LMPMood(1), LMPVoice(1))
    @test verb == expected
    @test lmpTense(verb) == lmpTense("perfect")
    @test lmpMood(verb) == lmpMood("indicative")
    @test lmpVoice(verb) == lmpVoice("active")
    @test lmpPerson(verb) == lmpPerson("third")
    @test lmpNumber(verb) == lmpNumber("singular")

 
    @test verb == lmfFiniteVerb("3314110000")
    frm = FormUrn("forms.3314110000")
    @test Tabulae.formurn(verb) == frm
end