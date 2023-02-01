using Tabulae
using Glob

# THIS IS OBSOLETE: SEE CODE IN `obsolete` FOLDER:
url = "https://raw.githubusercontent.com/LinguaLatina/analysis/master/data/hyginus/hyginus-fst.txt"
parses = Tabulae.parseurl(url)

vectorlist = filter(p -> typeof(p) == Vector{Any}, parses)
analyses = filter(v -> ! ismissing(v[1]), vectorlist)