
# `LatinMorphologicalForm`a  and `FormUrn`s

Implementations of the `LatinMorphologicalForm` are interchangeable with `FormUrn`s in the Tabulae collection.

We can directly construct `LatinMorphologicalForm`s with type-specific parameters.  For example, a `LatinFiniteVerb` can be directly constructed with values for the person, number, tense, mood and voice, and a `LatinNoun` with values for gender, case, and number.

```@example formurns
using Tabulae
verb = LatinFiniteVerb(3,1,1,1,1)
formurn(verb)
```

```@example formurns
noun = LatinNoun(1,1,1)
```


`Tabulae.jl` can represent `LatinMorphologicalForm`s as `FormUrn`s belonging to a collection of URN values for Latin morphology.  We can convert any `LatinMorphologicalForm` to a `FormUrn` with the `formurn` function.

```@example formurns
nounUrn = formurn(noun)
```



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




## Examples

`Tabulae.jl` offers functions for extracting specific integer values from a `FormUrn`, and for composing labels for the values.


```@example intro
using Tabulae # hide
noun = LatinNoun(1,1,1) # hide
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

## Roundtripping


We can also convert a `FormUrn` to a Latin form object with *a function still to be written...*


```@example formurns
#roundtrip = fromurn(nounUrn)
```