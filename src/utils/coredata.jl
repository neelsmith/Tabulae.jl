
"""Compile a Tabulae dataset with core rule and vocabulary sets.

$(SIGNATURES)
"""
function coredata(repo = pwd(); orthodir = "lat25", medieval = false)
    basicrules = joinpath(repo, "datasets", "core-infl-shared")
    orthovariantrules = joinpath(repo,"datasets", "core-infl-$(orthodir)")

    basicvocab = joinpath(repo, "datasets", "core-vocab-shared")
    orthovariantvocab = joinpath(repo,"datasets", "core-vocab-$(orthodir)")

    medievalrules = joinpath(repo,"datasets","medieval-shared")
    medieval ? dataset([basicrules, orthovariantrules, basicvocab, orthovariantvocab, medievalrules]) : dataset([basicrules, orthovariantrules, basicvocab, orthovariantvocab]) 
end


function min_data(repo = pwd(); orthodir = "lat25")
    basicrules = joinpath(repo, "datasets", "core-infl-shared")
    orthovariantrules = joinpath(repo,"datasets", "core-infl-$(orthodir)")
    [basicrules, orthovariantrules] |> dataset
end


"""Compile a string parser with core rule and vocabulary sets.

$(SIGNATURES)
"""
function coreparser(repo = pwd(); orthodir = "lat25", medieval = false)
    coredata(repo; orthodir = orthodir, medieval = medieval) |> tabulaeStringParser
end

