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
datesrc = now() 
yr = datesrc |> year
mo = datesrc |> month
monthday = datesrc |> day
datestr = join([yr,mo,monthday], "-")


# Names of output files:
out23 = joinpath(reporoot, "scratch", "lewisshort-lat23-$(datestr).cex")
curr23 = joinpath(reporoot, "scratch", "lewisshort-lat23-current.cex")

out24 = joinpath(reporoot, "scratch", "lewisshort-lat24-$(datestr).cex")
curr24 = joinpath(reporoot, "scratch", "lewisshort-lat24-current.cex")

out25 = joinpath(reporoot, "scratch", "lewisshort-lat25-$(datestr).cex")
curr25 = joinpath(reporoot, "scratch", "lewisshort-lat25-current.cex")


# Tabulae datasets:
inflcommon = joinpath(reporoot, "datasets", "core-infl-shared")
infl23 = joinpath(reporoot, "datasets", "core-infl-lat23")
infl24 = joinpath(reporoot, "datasets", "core-infl-lat24")
infl25 = joinpath(reporoot, "datasets", "core-infl-lat25")



vocabcommon = joinpath(reporoot, "datasets", "core-vocab-shared")
vocab23 = joinpath(reporoot, "datasets", "core-vocab-lat23")
vocab24 = joinpath(reporoot, "datasets", "core-vocab-lat24")
vocab25 = joinpath(reporoot, "datasets", "core-vocab-lat25")

# Lewis-Short datasets:
lscommon = joinpath(dsroot, "common")
ls23 = joinpath(dsroot, "lat23")
ls24 = joinpath(dsroot, "lat24")
ls25 = joinpath(dsroot, "lat25")

l23dirs = [inflcommon, vocabcommon, vocab23, infl23, lscommon, ls23] 
l24dirs = [inflcommon, vocabcommon, vocab24, infl24, lscommon, ls24]
l25dirs = [inflcommon, vocabcommon, vocab25, infl25, lscommon, ls25] 

# Parsers:
@time p23 = dataset(l23dirs) |> tabulaeStringParser
@time p24 = dataset(l24dirs) |> tabulaeStringParser
@time p25 = dataset(l25dirs) |> tabulaeStringParser


tofile(p23, out23)
tofile(p23, curr23)
tofile(p24, out24)
tofile(p24, curr24)
tofile(p25, out25)
tofile(p25, curr25)
