# Second conjugation verbs


 `conj2`



Example stem listing:

```
StemUrn|LexicalEntity|StemString|MorphologicalClass
latcommon.verbn12387|ls.n12387|deb|conj2
```


Paradigms generated from this entry:



## Present

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
debeo = LexemeUrn("ls.n12387")

present = lmpTense("present")
Markdown.parse(md_tenseconjugation(present, debeo, tds))
```


**Infinitives**: TBA

**Active participle**: TBA

## Imperfect 

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
debeo = LexemeUrn("ls.n12387")

impft = lmpTense("imperfect")
Markdown.parse(md_tenseconjugation(impft, debeo, tds))
```


## Future

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
debeo = LexemeUrn("ls.n12387")

present = lmpTense("future")
Markdown.parse(md_tenseconjugation(present, debeo, tds))
```


## Perfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
debeo = LexemeUrn("ls.n12387")

present = lmpTense("perfect")
Markdown.parse(md_tenseconjugation(present, debeo, tds))
```

**Passive participle**: TBA



## Pluperfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
debeo = LexemeUrn("ls.n12387")

present = lmpTense("pluperfect")
Markdown.parse(md_tenseconjugation(present, debeo, tds))
```



## Future perfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
debeo = LexemeUrn("ls.n12387")

present = lmpTense("future_perfect")
Markdown.parse(md_tenseconjugation(present, debeo, tds))
```

**Imperative**: TBA 


**Gerund**: TBA

**Gerundive**: TBA

**Supine**: TBA
