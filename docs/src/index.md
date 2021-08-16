# Tabulae.jl

`Tabulae.jl` is a from-scratch rewrite in Julia of the Tabulae system implemented in Scala [here](https://github.com/neelsmith/tabulae).  Its initial focus is on reading output of parsers built with the Scala Tabulae system into object form, with the `fromfst` function.  

## Reading output from a Tabulae parser

The `fromfst` function returns an `Analysis` object (from the `CitableParserBuilder` module).


```@example fst
using Tabulae
# Example of SFST output from a parser built with Scala Tabulae:
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

You are free to use any citable collection of lexemes you prefer (although the core vocabulary in Tabulae uses a citable collection based on the [citable Lewis-Short lexicon from Furman University](http://folio2.furman.edu/lewis-short/index.html)).

Morphological form URNs belong to a citable collection defined by Tabulae (described in more detail on the following page). They can be parsed into objects implementing the `LatinMorphologicalForm` abstract type.





## Implementations of the `LatinMorphologicalForm`

Work on `Tabulae.jl` currently focuses on implementing the `LatinMorphologicalForm` abstract type, including functions to parsing the SFST output of tabulae into implementations of a `LatinMorphologicalForm`, and converting intances of `LatinMorphologicalForm`s to `FormUrn`s.

Currently implemented:

- `LatinNoun`
- `LatinFiniteVerb`

In progress:

- adjectives
- adverbs
- gerunds
- gerundives
- infinitive forms
- participles
- pronouns
- uninflected forms