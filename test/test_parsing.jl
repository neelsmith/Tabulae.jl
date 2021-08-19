
@testset "Test top-level parsing of a LatinNoun form from SFST output" begin
    sfst = "<u>latcommon.nounn6506</u><u>ls.n6506</u>can<noun><masc><is_is><div><is_is><noun>em<masc><acc><sg><u>latcommoninfl.is_is4</u>"
    analysis = Tabulae.analysisforline(sfst)
    @test isa(analysis, CitableParserBuilder.Analysis)
    @test analysis.token == "canem"
    @test analysis.lexeme == LexemeUrn("ls.n6506")
    @test analysis.form == FormUrn("morphforms.2010001400") 
    @test Tabulae.from(analysis.form) == LatinNoun(1, 4, 1)
end