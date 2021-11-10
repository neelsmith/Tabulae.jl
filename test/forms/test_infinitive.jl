@testset "Test infinitive verb forms constructor and accessors"  begin
    infinitive = LMFInfinitive(lmpTense("present"), lmpVoice("active"))
    @test infinitive == LMFInfinitive(LMPTense(1), LMPVoice(1))




    fst = ""
    @test_broken infinitive == Tabulae.infinitivefromfst(fst)
end