@testset "Test noun forms constructor and accessors" begin
    noun = LMFNoun(lmpGender("masculine"), lmpCase("accusative"), lmpNumber("singular"))
    @test noun == LMFNoun(LMPGender(1), LMPCase(4), LMPNumber(1))

    @test label(noun) == "masculine accusative singular" 
    @test urn(noun) == Cite2Urn("urn:cite2:tabulae:forms.v1:2010001400")
    @test cex(noun) == "urn:cite2:tabulae:forms.v1:2010001400|masculine accusative singular"
    @test lmfNoun(urn(noun)) == noun

    
    @test noun == lmfNoun("2010001400")
    

    frm = FormUrn("forms.2010001400")
    @test noun == lmfNoun(frm)
    @test Tabulae.formurn(noun) == frm

    @test lmpGender(noun) == lmpGender("masculine")
    @test lmpCase(noun) == lmpCase("accusative")
    @test lmpNumber(noun) == lmpNumber("singular")

    #fst = "<masculine><accusative><singular>"
    #@test noun == Tabulae.nounfromfst(fst)
end

