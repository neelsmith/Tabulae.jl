# Quick start


```@setup quick
using Tabulae, CitableParserBuilder
repo = pwd() |> dirname |> dirname  |> dirname
```

```@example quick
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
parser = StringParser(tds)

```