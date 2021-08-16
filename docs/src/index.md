# Tabulae.jl

`Tabulae.jl` is a from-scratch rewrite in Julia of the Tabulae system implemented in Scala [here](https://github.com/neelsmith/tabulae).


## Implementations of the `LatinMorphologicalForm`

Work on `Tabulae.jl` currently focuses on implementing the `LatinMorphologicalForm` abstract type, including functions to parsing the SFST output of tabulae into implementations of a `LatinMorphologicalForm`.  

Currently implemented:

- `LatinNoun`
- `LatinFiniteVerb`

### Examples

Implementations of the `LatinMorphologicalForm` can be represented by `FormUrn`s.

```@example intro
using Tabulae
noun = LatinNoun(1,"masculine",1,"nominative",1,"singular")
formurn(noun)
```


```@example intro
verb = LatinFiniteVerb(3,"third",1,"singular",1,"present",1,"indicative",1, "active")
formurn(verb)
```
## Working with `FormUrn`s

`Tabulae.jl` implements the `CitableParserBuilder`'s abstract `FormUrn` type with a collection of URN values for Latin morphology.

Object identifiers in this collection are ten-character strings with each character representing an integer code for the following morphological properties:

1. "part of speech" (analytical type)
2. person
3. number
4. tense
5. mood
6. voice
7. gender
8. case
9. degree
10. uninflected category

### Examples


```@example intro
urn = formurn(noun)
Tabulae.poslabel(urn)
```

```@example intro
Tabulae.genderlabel(urn)
```


```@example intro
Tabulae.caselabel(urn)
```


```@example intro
Tabulae.numberlabel(urn)
```

```@example intro
Tabulae.personlabel(urn)
```