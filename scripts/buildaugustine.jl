# Build parser in Latin 24 orthography, including Lewis-Short with custom additions for Augustine, Confessions.
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
outfile = joinpath(reporoot, "scratch", "confessions-$(datestr).cex")
currfile = joinpath(reporoot, "scratch", "confessions-current.cex")



function confessionsdirlist(tabulaeroot, lexmineroot)
    # Tabulae core datasets:
    inflcommon = joinpath(tabulaeroot, "datasets", "core-infl-shared")
    vocabcommon = joinpath(tabulaeroot, "datasets", "core-vocab-shared")
    infl24 = joinpath(tabulaeroot, "datasets", "core-infl-lat24")
    vocab24 = joinpath(tabulaeroot, "datasets", "core-vocab-lat24")

    tailored = joinpath(tabulaeroot, "datasets", "confessions")

    # Tabulae manually vetted vocabulary:
    manualcommon = joinpath(tabulaeroot, "datasets", "manual", "common")

    # Lewis-Short auto-generated datasets:
    lscommon = joinpath(lexmineroot, "common")
    ls24 = joinpath(lexmineroot, "lat24")
    [inflcommon, vocabcommon, infl24, vocab24, manualcommon, lscommon, ls24 , tailored] 
end
confessionsdirs = confessionsdirlist(reporoot, dsroot)


# Parser:
function reparse()
    newparser = dataset(confessionsdirs) |> tabulaeStringParser
    tofile(newparser, outfile)
    tofile(newparser, currfile)
    newparser
end
@time parser = reparse()
a1 = parsetoken("ponticianus",parser)
