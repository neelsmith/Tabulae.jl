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


out23 = joinpath(reporoot, "scratch", "lewisshort-lat23-$(datestr).cex")
curr23 = joinpath(reporoot, "scratch", "lewisshort-lat23-current.cex")

out24 = joinpath(reporoot, "scratch", "lewisshort-lat24-$(datestr).cex")
curr24 = joinpath(reporoot, "scratch", "lewisshort-lat24-current.cex")

out25 = joinpath(reporoot, "scratch", "lewisshort-lat25-$(datestr).cex")
curr25 = joinpath(reporoot, "scratch", "lewisshort-lat25-current.cex")



inflcommon = joinpath(reporoot, "datasets", "core-infl-shared")
common = joinpath(dsroot, "common")

l23dirs = [joinpath(dsroot, "lat23"), inflcommon, common] 
l24dirs = [joinpath(dsroot, "lat24"), inflcommon, common] 
l25dirs = [joinpath(dsroot, "lat25"), inflcommon, common] 


@time p23 = dataset(l23dirs) |> tabulaeStringParser
@time p24 = dataset(l24dirs) |> tabulaeStringParser
@time p25 = dataset(l25dirs) |> tabulaeStringParser


tofile(p23, out23)
tofile(p23, curr23)
tofile(p24, out24)
tofile(p24, curr24)
tofile(p25, out25)
tofile(p25, curr25)
