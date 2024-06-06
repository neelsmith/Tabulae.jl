
```@setup datasets
repo = pwd() |> dirname |> dirname  |> dirname
```

# Datasets

## Key points

- a set of delimited-text tables in a defined directory structure:
    - inflectional patterns in subdirectories of `rules-tables`
    - vocabulary stems in subdirectories of `stems-tables`
    - registry of URNs for cited collections in `urnregistry`
- can simultaneously use multiple sets of tables. E.g., a set with vocabulary and stems for common entries applicable to multiple orthographies, combined with an orthography-specific set.

## Creating a `Tabulae.Dataset`


Create a `Tabulae.Dataset` with a Vector of directories following the prescribed structure:

```@example datasets
using Tabulae
srcdata = joinpath(repo, "datasets", "core-infl-shared")
tabds = Tabulae.Dataset([srcdata])
tabds isa Tabulae.Dataset
```