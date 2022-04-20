# Nouns



## Second declension


Example entry:

```
StemUrn|LexicalEntity|Stem|Gender|InflClass
latcommon.nounn14736|ls.n14736|don|neuter|us_i
```


Automatically generated paradigm:

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
donum = LexemeUrn("ls.n14736")
Markdown.parse(mddeclension(donum, tds))
```
