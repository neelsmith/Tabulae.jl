using Pkg
Pkg.activate("..")


using Tabulae
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using Orthography, LatinOrthography
using Compat.Test
using TestSetExtensions

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end
