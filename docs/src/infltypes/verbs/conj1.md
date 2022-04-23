# First conjugation verbs

Stem types: `conj1`

`c1pres1` (TBA)
 `c1pres`
 `pftact`


Stem listing:

```
StemUrn|LexicalEntity|StemString|MorphologicalClass|Notes
latcommon.verbn2280|ls.n2280|am|conj1
```


Paradigms generated from these entries:


## Present

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

present = lmpTense("present")
Markdown.parse(md_tenseconjugation(present, amo, tds))
```


**Infinitives**: TBA

**Active participle**: TBA

## Imperfect 

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

impft = lmpTense("imperfect")
Markdown.parse(md_tenseconjugation(impft, amo, tds))
```


## Future

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

present = lmpTense("future")
Markdown.parse(md_tenseconjugation(present, amo, tds))
```


## Perfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

present = lmpTense("perfect")
Markdown.parse(md_tenseconjugation(present, amo, tds))
```

**Passive participle**: TBA



## Pluperfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

present = lmpTense("pluperfect")
Markdown.parse(md_tenseconjugation(present, amo, tds))
```



## Future perfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
amo = LexemeUrn("ls.n2280")

present = lmpTense("future_perfect")
Markdown.parse(md_tenseconjugation(present, amo, tds))
```

**Imperative**: TBA 


**Gerund**: TBA

**Gerundive**: TBA

**Supine**: TBA
