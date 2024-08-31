# Execute this from root of Tabulae repo,
# either as a script, or from within VS Code
repo = pwd()
using Dates
datesrc = now() 
yr = datesrc |> year
mo = datesrc |> month
monthday = datesrc |> day
datestr = join([yr,mo,monthday], "-")


out23 = joinpath(repo, "scratch", "complut-lat23-$(datestr).cex")
out25 = joinpath(repo, "scratch", "complut-lat25-$(datestr).cex")

curr23 = joinpath(repo, "scratch", "complut-lat23-current.cex")
curr25 = joinpath(repo, "scratch", "complut-lat25-current.cex")



medieval = joinpath(repo, "datasets", "medieval-shared") 

shareddir = joinpath(repo, "datasets", "core-infl-shared") 
sharedvocab = joinpath(repo, "datasets", "core-vocab-shared") 

lat23dir = joinpath(repo, "datasets", "core-infl-lat23")
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 


lat23vocab = joinpath(repo, "datasets", "core-vocab-lat23")
lat25vocab = joinpath(repo, "datasets", "core-vocab-lat25")

compshared = joinpath(repo, "datasets", "complutensian", "complutensian-shared")
comp23 = joinpath(repo, "datasets", "complutensian", "complutensian-lat23")
comp25 = joinpath(repo, "datasets", "complutensian", "complutensian-lat25")


using Tabulae, CitableParserBuilder
ds23 = dataset([shareddir, sharedvocab, lat23dir, lat23vocab, compshared, comp23, medieval])
ds25 = dataset([shareddir, sharedvocab, lat25dir, lat25vocab,compshared, comp25, medieval])

p23 = tabulaeStringParser(ds23)
p25 = tabulaeStringParser(ds25)


tofile(p23, out23)
tofile(p23, curr23)

tofile(p25, out25)
tofile(p25, curr25)

