
@testset "Test CITE interfaces on irregular verb stems" begin
    verbstem = "latcommon.irregverbn46529a|ls.n46529|sum|first|singular|present|indicative|active"
    verbio = IrregularVerbIO("irrv io")
    stem = Tabulae.readstemrow(verbio, verbstem)

end