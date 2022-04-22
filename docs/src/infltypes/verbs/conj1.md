# First conjugation verbs

Stem listing:

```
StemUrn|LexicalEntity|StemString|MorphologicalClass|Notes
latcommon.verbn2280|ls.n2280|am|conj1
```


Paradigms generated from these entries:


## Imperfect 

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

impft = LMPTense(2)
Markdown.parse(md_tenseconjugation(impft, amo, tds))
```