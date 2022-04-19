
# Morphological forms and their properties

## `LatinMorphologicalForms`  and `FormUrn`s

Implementations of the abstract `LatinMorphologicalForm` model the properties identifying a particular type of token. For example, a `LMFNoun` has properties for gender, case and number.  Each of these properties in turn are subtypes of the `LatinMorphologicalProperty`.  We can construct a form directly from these properties.  For example, a `LMFNoun` can be constructed like this:


```@example formurns
using Tabulae
g = lmpGender("masculine")
c = lmpCase("accusative")
n = lmpNumber("singular")
noun = LMFNoun(g,c,n)
```

Forms are identified by a `Cite2Urn` belonging to the collection `urn:cite2:tabulae:forms.v1`.

```@example formurns
urn(noun)
```


Object identifiers in this collection are ten-character strings with each character representing an integer code for the following morphological properties:

1. "part of speech" (more precisely, the analytical type)
2. person
3. number
4. tense
5. mood
6. voice
7. gender
8. case
9. degree
10. uninflected category

Convenience methods let you work with these identifiers directly, or as a `FormUrn` (from the `CitableParserBuilder` package).

```@example formurns
Tabulae.formurn(noun)
```
```@example formurns
code(noun)
```

### More constructors



For each type, a corresponding function (with a name beginning in lowercase) constructs a form from a variety of different kinds of sources.

From a `Cite2Urn`:

```@example formurns
u = Tabulae.formurn(noun)
lmfNoun(u) == noun
```


From a `Rule` object...








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