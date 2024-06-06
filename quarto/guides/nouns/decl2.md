# Nouns: second declension


Stem entries:

```
StemUrn|LexicalEntity|Stem|Gender|InflClass
latcommon.nounn14736|ls.n14736|don|neuter|us_i
latcommon.nounn2636|ls.n2636|anim|masculine|us_i
```



Paradigms generated from these entries:

```@eval
using Tabulae, CitableParserBuilder, Markdown
repo = pwd() |> dirname |> dirname  |> dirname |> dirname
srcdir = joinpath(repo, "datasets", "core-infl-shared") 
tds = dataset([srcdir])
donum = LexemeUrn("ls.n14736")
animus = LexemeUrn("ls.n2636")
v = Vector{LexemeUrn}()
push!(v, donum)
push!(v, animus)
hdgs = ["`os_u` *neuter*", "`os_u` *masculine*"]
Markdown.parse(md_declension(v, tds, headings = hdgs))
```