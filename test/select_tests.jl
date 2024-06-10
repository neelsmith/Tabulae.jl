using Pkg
Pkg.activate("..")

using Downloads
using Tabulae
using CitableBase
using CitableObject, CitableParserBuilder
using CitableCorpus, CitableText
using Orthography, LatinOrthography
using Test
using TestSetExtensions

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end
