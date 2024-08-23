
@testset "Test uninflected forms constructor and accessors" begin
    uninfl = LMFUninflected(lmpUninflectedType("preposition"))
    
    @test uninfl == LMFUninflected(lmpUninflectedType(2))

    @test label(uninfl) == "uninflected preposition" 
    @test urn(uninfl) == Cite2Urn("urn:cite2:tabulae:latinforms.v1:1000000002")
    

end

@testset "Test form manipulation of uninflected forms" begin
    codestring = "forms.1000000001"
    lform = latinForm(codestring)
    @info("lform is $(lform)")
end
