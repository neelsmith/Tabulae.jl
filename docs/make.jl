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
            "Stems data" => "guide/stems.md",
            "Analyses" => "guide/analyses.md",

        ],
        "Reference: inflectional types and paradigms" => Any[
            "Paradigms" =>  "infltypes/index.md",
            "Nouns" => "infltypes/nouns/index.md",
            "Nouns: first declension" => "infltypes/nouns/decl1.md",
            "Nouns: second declension" => "infltypes/nouns/decl2.md",
            "Nouns: third declension" => "infltypes/nouns/decl3.md",
            "Nouns: fourth declension" => "infltypes/nouns/decl4.md",
            "Nouns: fifth declension" => "infltypes/nouns/decl5.md",

            "Verbs" => "infltypes/verbs/index.md",
            "Verbs: first conjugation" => "infltypes/verbs/conj1.md",
    
            "Verbs: second conjugation" => "infltypes/verbs/conj2.md",
            "Verbs: third conjugation" => "infltypes/verbs/conj3.md",
            "Verbs: third-io conjugation" => "infltypes/verbs/conj3io.md",
            "Verbs: fourth conjugation" => "infltypes/verbs/conj4.md",
            "Verbs with irreglar principal parts" => "infltypes/verbs/princparts.md"

        ],

        "Reference: code" => Any[
            "Latin Morphology API" =>  "apis/apis.md"
           
        ],
        
    ],
    )

deploydocs(
    repo = "github.com/neelsmith/Tabulae.jl.git",
)
