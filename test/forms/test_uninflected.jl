
@testset "Test uninflected forms constructor and accessors" begin
    uninfl = LMFUninflected(lmpUninflectedType("preposition"))
    

    
    @test uninfl == LMFUninflected(lmpUninflectedType(2))

    @test label(pronoun) == "masculine accusative singular" 
    @test urn(uninfl) == Cite2Urn("urn:cite2:tabulae:latinforms.v1:8010001400")
    @test cex(uninfl) == "urn:cite2:tabulae:latinforms.v1:8010001400|masculine accusative singular"
    @test lmfUninflected(urn(uninfl)) == uninfl

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

#=
@testset "Test CITE interface on uninflected forms" begin
    pronoun = LMFPronoun(lmpGender("masculine"), lmpCase("accusative"), lmpNumber("singular")) 
    @test citable(pronoun)
    @test label(pronoun) == "masculine accusative singular"
    @test urn(pronoun) == Cite2Urn("urn:cite2:tabulae:latinforms.v1:8010001400")
end
=#