# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'julia -e 'using LiveServer; serve(dir="docs/build")' 
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using CitableObject
using Tabulae


makedocs(
    sitename="Tabulae.jl",
    pages = [
        "Home" => "index.md",
        "Reference: code" => Any[
            "Julia API documentation" =>  "apis/apis.md"
        ],
        
    ],
    )