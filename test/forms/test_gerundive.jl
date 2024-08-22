@testset "Test gerundive forms constructor and accessors" begin
    gdv = lmfGerundive("masculine", "accusative", "singular")
    @test gdv == LMFGerundive(LMPGender(1), LMPCase(4), LMPNumber(1))

    @test label(gdv) == "masculine accusative singular" 
    @test urn(gdv) == Cite2Urn("urn:cite2:tabulae:latinforms.v1:a010001400")
    @test cex(gdv) == "urn:cite2:tabulae:latinforms.v1:a010001400|masculine accusative singular"
    @test lmfGerundive(urn(gdv)) == gdv

    
    @test gdv == lmfGerundive("a010001400")
    

    frm = FormUrn("forms.a010001400")
    @test gdv == lmfGerundive(frm)
    @test Tabulae.formurn(gdv) == frm

    @test lmpGender(gdv) == lmpGender("masculine")
    @test lmpCase(gdv) == lmpCase("accusative")
    @test lmpNumber(gdv) == lmpNumber("singular")

end

