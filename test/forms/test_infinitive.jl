@testset "Test infinitive verb forms constructor and accessors"  begin
    infinitive = LMFInfinitive(lmpTense("present"), lmpVoice("active"))
    @test infinitive == LMFInfinitive(LMPTense(1), LMPVoice(1))
    @test label(infinitive) == "present active infinitive"
    @test urn(infinitive) == Cite2Urn("urn:cite2:tabulae:forms.v1:4001010000")
    @test cex(infinitive) == "urn:cite2:tabulae:forms.v1:4001010000|present active infinitive"

    @test lmfInfinitive("4001010000") == infinitive
    @test lmfInfinitive(urn(infinitive)) == infinitive

    frm = FormUrn("forms.4001010000")
    @test lmfInfinitive(frm) == infinitive
    @test Tabulae.formurn(infinitive) == frm

end

@testset "Test citable interface on infinitives" begin
    infinitive = LMFInfinitive(lmpTense("present"), lmpVoice("active"))
    @test citable(infinitive)    
    @test label(infinitive) == "present active infinitive"
    @test urn(infinitive) == Cite2Urn("urn:cite2:tabulae:forms.v1:4001010000")
end
