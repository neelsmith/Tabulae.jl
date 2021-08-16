# Tabulae.jl

`Tabulae.jl` is a from-scratch rewrite in Julia of the Tabulae system implemented in Scala [here](https://github.com/neelsmith/tabulae).  Its initial focus is on reading output of parsers built with the Scala Tabulae system into object form, with the `fromfst` function.  This function returns an `Analysis` object (from the `CitableParserBuilder` module).


```@example fst
using Tabulae
sfst = "<u>latcommon.nounn6506</u><u>ls.n6506</u>can<noun><masc><is_is><div><is_is><noun>em<masc><acc><sg><u>latcommoninfl.is_is4</u>"
analysis = fromfst(sfst)
```

`Analysis` objects include URNs, in abbreviated form, for the lexeme and the morphological form.

```@example fst
analysis.lexeme
```

```@example fst
analysis.form
```


## Implementations of the `LatinMorphologicalForm`

Work on `Tabulae.jl` currently focuses on implementing the `LatinMorphologicalForm` abstract type, including functions to parsing the SFST output of tabulae into implementations of a `LatinMorphologicalForm`.  

Currently implemented:

- `LatinNoun`
- `LatinFiniteVerb`


Implementations of the `LatinMorphologicalForm` type can be instantiated from SFST output with the `fromfst` function.  This means that your julia code can parse , and can represent

