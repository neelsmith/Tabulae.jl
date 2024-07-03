@testset "Test constructors and accessors on participle" begin
    ptcpl = LMFParticiple(LMPGender(3), LMPCase(1), LMPNumber(1), LMPTense(4),  LMPVoice(1))
    # Add tests here!
    
end

@testset "Test CITE interface on participle" begin
    ptcpl = LMFParticiple(LMPGender(3), LMPCase(1), LMPNumber(1), LMPTense(4),  LMPVoice(1))
    @test citable(ptcpl)
    @test urn(ptcpl) == Cite2Urn("urn:cite2:tabulae:forms.v1:5014013100")
    @test label(ptcpl)== "perfect active participle, neuter nominative singular"
end