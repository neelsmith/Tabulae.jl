---
engine: julia
---

# Fourth conjugation verbs

`conj4`


Example stem listing:

```
StemUrn|LexicalEntity|StemString|MorphologicalClass|Notes
latcommon.verbn4453|ls.n4453|aud|conj4
```

 







Paradigms generated from this entry:



## Present

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
audio = LexemeUrn("ls.n4453")

present = lmpTense("present")
Markdown.parse(md_tenseconjugation(present, audio, tds))
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
audio = LexemeUrn("ls.n4453")

impft = lmpTense("imperfect")
Markdown.parse(md_tenseconjugation(impft, audio, tds))
```


## Future

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
audio = LexemeUrn("ls.n4453")

present = lmpTense("future")
Markdown.parse(md_tenseconjugation(present, audio, tds))
```


## Perfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
audio = LexemeUrn("ls.n4453")

present = lmpTense("perfect")
Markdown.parse(md_tenseconjugation(present, audio, tds))
```

**Passive participle**: TBA



## Pluperfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
audio = LexemeUrn("ls.n4453")

present = lmpTense("pluperfect")
Markdown.parse(md_tenseconjugation(present, audio, tds))
```



## Future perfect

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
commondir = joinpath(repo, "datasets", "core-infl-shared") 
lat25dir = joinpath(repo, "datasets", "core-infl-lat25") 
tds = dataset([commondir, lat25dir])
audio = LexemeUrn("ls.n4453")

present = lmpTense("future_perfect")
Markdown.parse(md_tenseconjugation(present, audio, tds))
```

**Imperative**: TBA 


**Gerund**: TBA

**Gerundive**: TBA

**Supine**: TBA

