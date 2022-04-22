
Automatically generated paradigm:

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
donum = LexemeUrn("ls.n14736")
Markdown.parse(md_declension(donum, tds))
```