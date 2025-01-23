
"""Compile a minimal Tabulae dataset with a single vocabulary item for each inflectional class.

$(SIGNATURES)
"""
function min_data(repo = pwd(); orthodir = "lat25")
    basicrules = joinpath(repo, "datasets", "core-infl-shared")
    orthovariantrules = joinpath(repo,"datasets", "core-infl-$(orthodir)")
    [basicrules, orthovariantrules] |> dataset
end


"""Compile a minimal Tabulae parse with a single vocabulary item for each inflectional class.

$(SIGNATURES)
"""
function min_parser(repo = pwd(); orthodir = "lat25")
    min_data(repo; orthodir = orthodir) |> tabulaeStringParser
end

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




"""Compile a string parser with core rule and vocabulary sets.

$(SIGNATURES)
"""
function coreparser(repo = pwd(); orthodir = "lat25", medieval = false)
    coredata(repo; orthodir = orthodir, medieval = medieval) |> tabulaeStringParser
end

