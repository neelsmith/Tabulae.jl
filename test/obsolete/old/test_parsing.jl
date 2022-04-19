
@testset "Test top-level parsing of a LatinNoun form from SFST output" begin
    
    nounfst = "<u>latcommon.nounn6506</u><u>ls.n6506</u>can<noun><masc><is_is><div><is_is><noun>em<masc><acc><sg><u>latcommoninfl.is_is4</u>"
    analysis = Tabulae.analysisforline(nounfst)
    @test isa(analysis, CitableParserBuilder.Analysis)
    @test analysis.token == "canem"
    @test analysis.lexeme == LexemeUrn("ls.n6506")
    @test analysis.form == FormUrn("tabulaeforms.2010001400") 
    @test fromanalysis(analysis) == LatinNoun(1,4,1)
end




@testset "Test top-level parsing of a LMFFiniteVerb form from SFST output" begin
    
    verbfst = "<u>latcommon.verbn5128</u><u>ls.n5128</u><#>belliger<verb><conj1><div><conj1><verb>auit<3rd><sg><pft><indic><act><u>lat23morph.are_pft3</u>"
    analysis = Tabulae.analysisforline(verbfst)
    @test isa(analysis, CitableParserBuilder.Analysis)
    @test analysis.token == "#belligerauit"
    @test analysis.lexeme == LexemeUrn("ls.n5128")
    @test analysis.form == FormUrn("tabulaeforms.3314110000") 

    @test fromanalysis(analysis) == LMFFiniteVerb(3,1,4,1,1)
end


