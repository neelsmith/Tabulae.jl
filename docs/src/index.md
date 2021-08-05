# Tabulae.jl

`Tabulae.jl` is a from-scratch rewrite in Julia of the Tabulae system implemented in Scala [here](https://github.com/neelsmith/tabulae).

The first part of `Tabulae.jl` to be implemented is definitions of the `LatinMorphologicalForm` abstract type, and the functions for parsing the SFST output of tabulae into implementations of `LatinMorphologicalForm`.  That currently includes:

- `LatinNoun`
- `LatinFiniteVerb`
