# Execute this from root of Tabulae repo,
# either as a script, or from within VS Code
repo = pwd()

using Dates
datesrc = now() 
yr = datesrc |> year
mo = datesrc |> month
monthday = datesrc |> day
datestr = join([yr,mo,monthday], "-")

out23 = joinpath(repo, "scratch", "medieval-lat23-$(datestr).cex")
out24 = joinpath(repo, "scratch", "medieval-lat24-$(datestr).cex")
out25 = joinpath(repo, "scratch", "medieval-lat25-$(datestr).cex")


curr23 = joinpath(repo, "scratch", "medieval-lat23-current.cex")
curr24 = joinpath(repo, "scratch", "medieval-lat24-current.cex")
curr25 = joinpath(repo, "scratch", "medieval-lat25-current.cex")


medieval = joinpath(repo, "datasets", "medieval-shared") 

shareddir = joinpath(repo, "datasets", "core-infl-shared") 
sharedvocab = joinpath(repo, "datasets", "core-vocab-shared") 

lat23dir = joinpath(repo, "datasets", "core-infl-lat23")
lat24dir = joinpath(repo, "datasets", "core-infl-lat24") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 


lat23vocab = joinpath(repo, "datasets", "core-vocab-lat23")
lat24vocab = joinpath(repo, "datasets", "core-vocab-lat24") 
lat25vocab = joinpath(repo, "datasets", "core-vocab-lat25")

using Tabulae, CitableParserBuilder
ds23 = dataset([shareddir, sharedvocab, lat23dir, lat23vocab, medieval])
ds24 = dataset([shareddir, sharedvocab, lat24dir, lat24vocab, medieval])
ds25 = dataset([shareddir, sharedvocab, lat25dir, lat25vocab, medieval])

p23 = tabulaeStringParser(ds23)
p24 = tabulaeStringParser(ds24)
p25 = tabulaeStringParser(ds25)


tofile(p23, out23)
tofile(p23, curr23)

tofile(p24, out24)
tofile(p24, curr24)

tofile(p25, out25)
tofile(p25, curr25)