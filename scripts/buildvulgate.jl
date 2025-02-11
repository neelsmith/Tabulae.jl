# Build parser in Latin 25 orthography, including Lewis-Short with custom additions for :atom Vulgate.
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
outfile = joinpath(reporoot, "scratch", "vulgate-$(datestr).cex")
currfile = joinpath(reporoot, "scratch", "vulgate-current.cex")



function vulgatedirlist(tabulaeroot, lexmineroot)
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

    # Corpus-specific additions:

    tailored = joinpath(tabulaeroot, "datasets", "complutensian")
    [inflcommon, vocabcommon, infl25, vocab25, manualcommon, lscommon, ls25 , tailored] 
end
vulgatedirs = vulgatedirlist(reporoot, dsroot)


# Parser:
function reparse(srcdirs, outfile, currfile)
    newparser = dataset(srcdirs) |> tabulaeStringParser
    tofile(newparser, outfile)
    tofile(newparser, currfile)
    newparser
end

@time parser = reparse(vulgatedirs, outfile, currfile)

a1 = parsetoken("prior",parser)
