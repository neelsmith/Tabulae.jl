
"""Compile a Tabulae dataset with core rule and vocabulary sets.

$(SIGNATURES)
"""
function coredata(repo = pwd(); orthodir = "lat25")
    basicrules = joinpath(repo, "datasets", "core-infl-shared")
    orthovariantrules = joinpath(repo,"datasets", "core-infl-$(orthodir)")

    basicvocab = joinpath(repo, "datasets", "core-vocab-shared")
    orthovariantvocab = joinpath(repo,"datasets", "core-vocab-$(orthodir)")

    ds = dataset([basicrules, orthovariantrules, basicvocab, orthovariantvocab])
end




"""Compile a string parser with core rule and vocabulary sets.

$(SIGNATURES)
"""
function coreparser(repo = pwd(); orthodir = "lat25")
    coredata(repo; orthodir = orthodir) |> tabulaeStringParser
end