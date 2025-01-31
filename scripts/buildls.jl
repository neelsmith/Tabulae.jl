# Build giant LS parser.
using Tabulae
using CitableParserBuilder

# Root directory of Tabulae repo:
reporoot = pwd()
# Root directory of LexiconMining repo:
lmroot = joinpath(dirname(pwd()), "LexiconMining.jl")
dsroot = joinpath(lmroot, "tabulae-datasets", "lewis-short")
isdir(dsroot)


using Dates
function getdatestr()
    datesrc = now() 
    yr = datesrc |> year
    mo = datesrc |> month
    monthday = datesrc |> day
    join([yr,mo,monthday], "-")
end
datestr = getdatestr()




# Names of output files:
out23 = joinpath(reporoot, "scratch", "lewisshort-lat23-$(datestr).cex")
curr23 = joinpath(reporoot, "scratch", "lewisshort-lat23-current.cex")

out24 = joinpath(reporoot, "scratch", "lewisshort-lat24-$(datestr).cex")
curr24 = joinpath(reporoot, "scratch", "lewisshort-lat24-current.cex")

out25 = joinpath(reporoot, "scratch", "lewisshort-lat25-$(datestr).cex")
curr25 = joinpath(reporoot, "scratch", "lewisshort-lat25-current.cex")



function ds23dirlist(tabulaeroot, lexmineroot)
    # Tabulae core datasets:
    inflcommon = joinpath(tabulaeroot, "datasets", "core-infl-shared")
    vocabcommon = joinpath(tabulaeroot, "datasets", "core-vocab-shared")
    infl23 = joinpath(tabulaeroot, "datasets", "core-infl-lat23")
    vocab23 = joinpath(tabulaeroot, "datasets", "core-vocab-lat23")

    # Tabulae manually vetted vocabulary:
    manualcommon = joinpath(tabulaeroot, "datasets", "manual", "common")

    # Lewis-Short auto-generated datasets:
    lscommon = joinpath(lexmineroot, "common")
    ls23 = joinpath(lexmineroot, "lat23")
    [inflcommon, vocabcommon, infl23, vocab23, manualcommon, lscommon, ls23 ] 
end
l23dirs = ds23dirlist(reporoot, dsroot)


function ds24dirlist(tabulaeroot, lexmineroot)
    # Tabulae core datasets:
    inflcommon = joinpath(tabulaeroot, "datasets", "core-infl-shared")
    vocabcommon = joinpath(tabulaeroot, "datasets", "core-vocab-shared")
    infl24 = joinpath(tabulaeroot, "datasets", "core-infl-lat24")
    vocab24 = joinpath(tabulaeroot, "datasets", "core-vocab-lat24")

    # Tabulae manually vetted vocabulary:
    manualcommon = joinpath(tabulaeroot, "datasets", "manual", "common")

    # Lewis-Short auto-generated datasets:
    lscommon = joinpath(lexmineroot, "common")
    ls24 = joinpath(lexmineroot, "lat24")
    [inflcommon, vocabcommon, infl24, vocab24, manualcommon, lscommon, ls24 ] 
end
l24dirs = ds24dirlist(reporoot, dsroot)


function ds25dirlist(tabulaeroot, lexmineroot)
    # Tabulae core datasets:
    inflcommon = joinpath(tabulaeroot, "datasets", "core-infl-shared")
    vocabcommon = joinpath(tabulaeroot, "datasets", "core-vocab-shared")
    infl25 = joinpath(tabulaeroot, "datasets", "core-infl-lat25")
    vocab25 = joinpath(tabulaeroot, "datasets", "core-vocab-lat25")

    # Tabulae manually vetted vocabulary:
    manualcommon = joinpath(tabulaeroot, "datasets", "manual", "common")

    # Lewis-Short auto-generated datasets:
    lscommon = joinpath(lexmineroot, "common")
    ls25 = joinpath(lexmineroot, "lat25")
    [inflcommon, vocabcommon, infl25, vocab25, manualcommon, lscommon, ls25 ] 
end
l25dirs = ds25dirlist(reporoot, dsroot)

# Parsers:
@time p23 = dataset(l23dirs) |> tabulaeStringParser
@time p24 = dataset(l24dirs) |> tabulaeStringParser
@time p25 = dataset(l25dirs) |> tabulaeStringParser

parsetoken("uterque",p24)

tofile(p23, out23)
tofile(p23, curr23)
tofile(p24, out24)
tofile(p24, curr24)
tofile(p25, out25)
tofile(p25, curr25)
