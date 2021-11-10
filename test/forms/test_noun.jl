@testset "Test noun forms constructor and accessors" begin
    noun = LMFNoun(lmpGender("masculine"), lmpCase("accusative"), lmpNumber("singular"))
    @test noun == LMFNoun(LMPGender(1), LMPCase(4), LMPNumber(1))

    @test label(noun) == "masculine accusative singular" 
    @test urn(noun) == Cite2Urn("urn:cite2:tabulae:forms.v1:2010001400")
    @test cex(noun) == "urn:cite2:tabulae:forms.v1:2010001400|masculine accusative singular"
    @test lmfNoun(urn(noun)) == noun

    nouncode = "2010001400"
    noun2 = lmfNoun(nouncode)
    @test noun2 == LMFNoun(LMPGender(1), LMPCase(4), LMPNumber(1))

    frm = FormUrn("forms.2010001400")
    @test noun == lmfNoun(frm)
    @test Tabulae.formurn(noun) == frm

    @test lmpGender(noun) == lmpGender("masculine")
    @test lmpCase(noun) == lmpCase("accusative")
    @test lmpNumber(noun) == lmpNumber("singular")
end

