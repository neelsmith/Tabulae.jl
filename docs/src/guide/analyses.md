
```@setup analyses
repo = pwd() |> dirname |> dirname  |> dirname
```

# Analyses


## Building a parser

One example among many possibilities: build a `StringParser` from a data set.


```@example analyses
using Tabulae, CitableParserBuilder
srcdata = joinpath(repo, "datasets", "core-infl-shared")
tabds = Tabulae.Dataset([srcdata])
parser = stringParser(tabds)
```




## How to parse a token

```@example analyses
results = parsetoken("donum", parser)
```


## Key points about analyses

