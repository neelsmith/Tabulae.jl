# Nouns: first declension


Stem entries:

```
StemUrn|LexicalEntity|Stem|Gender|InflClass
latcommon.noun1626|ls.n1626|agricol|masculine|a_ae
latcommon.nounn2612|ls.n2612|anim|feminine|a_ae
```


Paradigms generated from these entries:

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
soul = LexemeUrn("ls.n2612")
farmer = LexemeUrn("ls.n1626")
v = Vector{LexemeUrn}()
push!(v, soul)
push!(v, farmer)
hdgs = ["`a_ae` *feminine*", "`a_ae` *masculine*"]
Markdown.parse(mddeclension(v, tds, headings = hdgs))
```