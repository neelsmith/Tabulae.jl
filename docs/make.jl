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
        "Home" => Any[
            "User's guide: introduction" => "index.md",
            "Datasets" => "guide/datasets.md",
            "Identification with URNs" => "guide/urns.md",
            "Vocabulary" => "guide/lexemes.md",
            "Morphological forms" => "guide/forms.md",
            "Rules data" => "guide/rules.md",
            "Stems data" => "guide/stems.md"
        ],
        "Reference: code" => Any[
            "Latin Morphology API" =>  "apis/apis.md",
            "FormUrns" => "apis/forms.md"
        ],
        
    ],
    )

deploydocs(
    repo = "github.com/neelsmith/Tabulae.jl.git",
)
