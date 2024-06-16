# Execute this from root of Tabulae repo,
# either as a script, or from within VS Code
repo = pwd()

using Dates
datesrc = now() 
yr = datesrc |> year
mo = datesrc |> month
monthday = datesrc |> day
datestr = join([yr,mo,monthday], "-")

out23 = joinpath(repo, "scratch", "core-lat23-$(datestr).cex")
out24 = joinpath(repo, "scratch", "core-lat24-$(datestr).cex")
out25 = joinpath(repo, "scratch", "core-lat25-$(datestr).cex")

shareddir = joinpath(repo, "datasets", "core-infl-shared") 
sharedvocab = joinpath(repo, "datasets", "core-vocab-shared") 

lat23dir = joinpath(repo, "datasets", "core-infl-lat23")
lat24dir = joinpath(repo, "datasets", "core-infl-lat24") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 


lat23vocab = joinpath(repo, "datasets", "core-vocab-lat23")
lat24vocab = joinpath(repo, "datasets", "core-vocab-lat24") 
lat25vocab = joinpath(repo, "datasets", "core-vocab-lat25")

using Tabulae, CitableParserBuilder
ds23 = dataset([shareddir, sharedvocab, lat23dir, lat23vocab])
ds24 = dataset([shareddir, sharedvocab, lat24dir, lat24vocab])
ds25 = dataset([shareddir, sharedvocab, lat25dir, lat25vocab])

p23 = tabulaeStringParser(ds23)
p24 = tabulaeStringParser(ds24)
p25 = tabulaeStringParser(ds25)

tofile(p23, out23)
tofile(p24, out24)
tofile(p25, out25)



rules23 = rulesarray(ds23)
rules24 = rulesarray(ds24)
rules25 = rulesarray(ds25)


rulesout23 = joinpath(repo, "scratch", "rules-lat23-$(datestr).cex")
rulesout24 = joinpath(repo, "scratch", "rules-lat24-$(datestr).cex")
rulesout25 = joinpath(repo, "scratch", "rules-lat25-$(datestr).cex")

# Borken: can't get id() on irregular rule
#tofile(rules23, rulesout23)
#tofile(rules24, rulesout24)
#tofile(rules25, rulesout25)