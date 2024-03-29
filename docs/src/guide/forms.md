
# Morphological forms and their properties

## `LatinMorphologicalForms` 

Implementations of the abstract `LatinMorphologicalForm` model the properties identifying a particular type of token. For example, a `LMFNoun` has properties for gender, case and number.  Each of these properties in turn are subtypes of the `LatinMorphologicalProperty`.  We can construct a form directly from these properties.  For example, a `LMFNoun` can be constructed like this:


```@example formurns
using Tabulae
g = lmpGender("masculine")
c = lmpCase("accusative")
n = lmpNumber("singular")
noun = LMFNoun(g,c,n)
```


## Tabulae's collection of form values

Forms are identified by a `Cite2Urn` belonging to the collection `urn:cite2:tabulae:forms.v1`.

As citable objects, they include the `label` function.

```@example formurns
label(noun)
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

In the following line, the initial digit `2` means "noun form"; the number value `1` means singular; the gender value `3` means "neuter" and the case value `1` means "nominative".

```@example formurns
urn(noun)
```

Convenience methods let you work with these identifiers directly, or as a `FormUrn` (from the `CitableParserBuilder` package).

```@example formurns
Tabulae.formurn(noun)
```
```@example formurns
code(noun)
```

### More constructors



For each subtype of `LatinMorphologicalForm`, a corresponding constructor function (with a name beginning in lowercase) accepts a variety of kinds of sources for a form, such as a `Cite2Urn`:

```@example formurns
u = urn(noun)
lmfNoun(u) == noun
```

Other sources you can use to create a `LatinMorphologicalForm` include strings, abbreviated URNs, `Analysis` objects and `TabulaeRule` objects.  See the API documentation for details.





## Properties

Each implementation of the `LatinMorphologicalProperty` has a corresponding lower-case function you can use to extract that property from a form.


```@example formurns
gender = lmpGender(noun)
```

You can use the `code` and `label` functions to find an integer code and readable string for any morphological property.

```@example formurns
code(gender)
```


```@example formurns
label(gender)
```
