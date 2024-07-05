@testset "Test finite verb forms constructor and accessors" begin
     
    verb = LMFFiniteVerb(LMPPerson(3), LMPNumber(1), LMPTense(4), LMPMood(1), LMPVoice(1))

    @test lmpTense(verb) == lmpTense("perfect")
    @test lmpMood(verb) == lmpMood("indicative")
    @test lmpVoice(verb) == lmpVoice("active")
    @test lmpPerson(verb) == lmpPerson("third")
    @test lmpNumber(verb) == lmpNumber("singular")
    @test (lmpTense(verb)  |> perfectsystem)
    @test perfectsystem(verb)

    fromcode = lmfFiniteVerb("3314110000")
    frm = FormUrn("forms.3314110000")
    @test Tabulae.formurn(fromcode) == frm
end

@testset "Test CITE interfaces on finite verb forms" begin
    verb = LMFFiniteVerb(LMPPerson(3), LMPNumber(1), LMPTense(4), LMPMood(1), LMPVoice(1))

    @test citable(verb)
    @test urn(verb) == Cite2Urn("urn:cite2:tabulae:forms.v1:3314110000")
    @test label(verb)  == "perfect indicative active third singular"
    
end