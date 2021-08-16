
# Working with `FormUrn`s



`Tabulae.jl` can represent implementations of `LatinMorphologicalForm` as `FormUrn`s belonging to a collection of URN values for Latin morphology.  Object identifiers in this collection are ten-character strings with each character representing an integer code for the following morphological properties:

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


A `LatinNoun` can be directly constructed with values for the gender, case and number.

```@example intro
using Tabulae
noun = LatinNoun(1,1,1)
formurn(noun)
```

A `LatinFiniteVerb` can be directly constructed with values for the person, number, tense, mood and voice.

```@example intro
verb = LatinFiniteVerb(3,1,1,1,1)
formurn(verb)
```


## Examples

`Tabulae.jl` offers functions for extracting specific integer values from a `FormUrn`, and for composing labels for the values.


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