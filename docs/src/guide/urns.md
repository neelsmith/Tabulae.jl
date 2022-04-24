
# Identification with URNs


```@setup urns
repo = pwd() |> dirname |> dirname  |> dirname
```

## Key points

- all identification is by URN value
- the `CitableParserBuilder` package defines four subtypes of the abstract `AbbreviatedUrn` for the four URNs comprising an analysis in Tabulae:
    - the `FormUrn`
    - the `LexemeUrn`
    - the `StemUrn`
    - the `RuleUrn`
- the `FormUrn` is generated by the parsing system    
- you use the other three types URNs to identify content in a `Tabulae` data set    
- you record each collection in a URN registry that supports round-trip conversion of `AbbreviatedUrn`s and `Cite2Urn`s.

## The URN registry

- organized in three subdirectories of the dataset's `urnregistry` directory:
     - `lexemes`
     - `rules`
     - `stems`
- identical three-column delimited text files: collection ID, collection URN, label
- as many file names as you like ending in `.cex`; empty lines OK


Example:


```
CollectionId|CollectionUrn|Label
ls|urn:cite2:shot:ls.v1:|Latin lexical entities appearing in Lewis-Short's Latin Dictionary.
```

You can get a dictionary of collection IDs to full URNs for your data aset with the `registry` function.


```@example urns
using Tabulae
srcdata = joinpath(repo, "datasets", "core-infl-shared")
tabds = Tabulae.Dataset([srcdata])

abbrdict = registry(tabds)
```
## Working with URNs

`abbreviate` returns an abbreviated string value for a `Cite2Urn`:

```@example urns
using CitableParserBuilder
using CitableObject
longurn = Cite2Urn("urn:cite2:shot:ls.v1:n14736")
shortform = abbreviate(longurn)
```

You can use that string to create the appropriate type of abbreviated URN:

```@example urns
lex = LexemeUrn(shortform)
```

To convert an `AbbreviatedUrn` to a `Cite2Urn`, you need to supply the dataset's URN registry.


```@example urns
expanded = expand(lex, abbrdict)
```