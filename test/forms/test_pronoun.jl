
@testset "Test pronoun forms constructor and accessors" begin
    pronoun = LMFPronoun(lmpGender("masculine"), lmpCase("accusative"), lmpNumber("singular"))
    @test pronoun == LMFPronoun(LMPGender(1), LMPCase(4), LMPNumber(1))

    @test label(pronoun) == "masculine accusative singular" 
    @test urn(pronoun) == Cite2Urn("urn:cite2:tabulae:latinforms.v1:8010001400")
    @test cex(pronoun) == "urn:cite2:tabulae:latinforms.v1:8010001400|masculine accusative singular"
    @test lmfPronoun(urn(pronoun)) == pronoun

    #=
    @test pronoun == lmfPronoun("8010001400")
    

    frm = FormUrn("forms.8010001400")
    @test pronoun == lmfNoun(frm)
    @test Tabulae.formurn(pronoun) == frm

    @test lmpGender(pronoun) == lmpGender("masculine")
    @test lmpCase(pronoun) == lmpCase("accusative")
    @test lmpNumber(pronoun) == lmpNumber("singular")
    =#

end

@testset "Test CITE interface on pronouns" begin
    pronoun = LMFPronoun(lmpGender("masculine"), lmpCase("accusative"), lmpNumber("singular")) 
    @test citable(pronoun)
    @test label(pronoun) == "masculine accusative singular"
    @test urn(pronoun) == Cite2Urn("urn:cite2:tabulae:latinforms.v1:8010001400")
end
