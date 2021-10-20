var documenterSearchIndex = {"docs":
[{"location":"apis/apis/#Latin-morphology-API-documentation","page":"Latin Morphology API","title":"Latin morphology API documentation","text":"","category":"section"},{"location":"apis/apis/","page":"Latin Morphology API","title":"Latin Morphology API","text":"Pages = [\"apis.md\"]\nDepth = 3","category":"page"},{"location":"apis/apis/#Public-types","page":"Latin Morphology API","title":"Public types","text":"","category":"section"},{"location":"apis/apis/","page":"Latin Morphology API","title":"Latin Morphology API","text":"LatinMorphologicalForm\nLatinNoun\nLatinFiniteVerb","category":"page"},{"location":"apis/apis/#Tabulae.LatinMorphologicalForm","page":"Latin Morphology API","title":"Tabulae.LatinMorphologicalForm","text":"Abstract type of a morphological form.\n\n\n\n\n\n","category":"type"},{"location":"apis/apis/#Tabulae.LatinNoun","page":"Latin Morphology API","title":"Tabulae.LatinNoun","text":"Nouns have gender, case and number.\n\n\n\n\n\n","category":"type"},{"location":"apis/apis/#Tabulae.LatinFiniteVerb","page":"Latin Morphology API","title":"Tabulae.LatinFiniteVerb","text":"Finite verbs have person, number, tense, mood and voice.\n\n\n\n\n\n","category":"type"},{"location":"apis/apis/#Public-function-APIs","page":"Latin Morphology API","title":"Public function APIs","text":"","category":"section"},{"location":"apis/apis/","page":"Latin Morphology API","title":"Latin Morphology API","text":"fromfst\nformurn","category":"page"},{"location":"apis/apis/#Tabulae.fromfst","page":"Latin Morphology API","title":"Tabulae.fromfst","text":"Parse a line of SFST output into a LatinMorphologicalForm.\n\nfromfst(s)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Tabulae.formurn","page":"Latin Morphology API","title":"Tabulae.formurn","text":"Convert a LatinMorphologicalForm to a Cite2Urn.\n\nformurn(LatinMorphologicalForm)\n\n\nAll subclasses of LatinMorphologicalForm should implement this specifically for their subclass.\n\n\n\n\n\nCompose a FormUrn for a LatinVerbForm.\n\nformurn(verbform)\n\n\n\n\n\n\nCompose a FormUrn for a LatinNoun.\n\nformurn(noun)\n\n\n\n\n\n\nCompose a FormUrn for a LatinUninflectedForm.\n\nformurn(uninflected)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Internal-APIs","page":"Latin Morphology API","title":"Internal APIs","text":"","category":"section"},{"location":"apis/apis/","page":"Latin Morphology API","title":"Latin Morphology API","text":"Tabulae.nounfromfst\nTabulae.verbfromfst","category":"page"},{"location":"apis/apis/#Tabulae.nounfromfst","page":"Latin Morphology API","title":"Tabulae.nounfromfst","text":"Parse a string of SFST output into a LatinNoun form.\n\nnounfromfst(fstdata)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/apis/#Tabulae.verbfromfst","page":"Latin Morphology API","title":"Tabulae.verbfromfst","text":"Parse a string of SFST output into a LatinFiniteVerb.\n\nverbfromfst(fstdata)\n\n\n\n\n\n\n","category":"function"},{"location":"guide/formurns/#LatinMorphologicalForma-and-FormUrns","page":"FormUrns","title":"LatinMorphologicalForma  and FormUrns","text":"","category":"section"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Implementations of the LatinMorphologicalForm are interchangeable with FormUrns in the Tabulae collection.","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"We can directly construct LatinMorphologicalForms with type-specific parameters.  For example, a LatinFiniteVerb can be directly constructed with values for the person, number, tense, mood and voice, and a LatinNoun with values for gender, case, and number.","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"using Tabulae\nverb = LatinFiniteVerb(3,1,1,1,1)\nformurn(verb)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"noun = LatinNoun(1,1,1)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Tabulae.jl can represent LatinMorphologicalForms as FormUrns belonging to a collection of URN values for Latin morphology.  We can convert any LatinMorphologicalForm to a FormUrn with the formurn function.","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"nounUrn = formurn(noun)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Object identifiers in this collection are ten-character strings with each character representing an integer code for the following morphological properties:","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"\"part of speech\" (analytical type)\nperson\nnumber\ntense\nmood\nvoice\ngender\ncase\ndegree\nuninflected category","category":"page"},{"location":"guide/formurns/#Examples","page":"FormUrns","title":"Examples","text":"","category":"section"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Tabulae.jl offers functions for extracting specific integer values from a FormUrn, and for composing labels for the values.","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"using Tabulae # hide\nnoun = LatinNoun(1,1,1) # hide\nurn = formurn(noun)\nTabulae.poslabel(urn)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Tabulae.genderlabel(urn)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Tabulae.caselabel(urn)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Tabulae.numberlabel(urn)","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"Tabulae.personlabel(urn)","category":"page"},{"location":"guide/formurns/#Roundtripping","page":"FormUrns","title":"Roundtripping","text":"","category":"section"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"We can also convert a FormUrn to a Latin form object with a function still to be written...","category":"page"},{"location":"guide/formurns/","page":"FormUrns","title":"FormUrns","text":"#roundtrip = fromurn(nounUrn)","category":"page"},{"location":"#Tabulae.jl","page":"User's guide: introduction","title":"Tabulae.jl","text":"","category":"section"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Tabulae.jl is a from-scratch rewrite in Julia of the Tabulae system implemented in Scala here.  Its initial focus is on reading output of parsers built with the Scala Tabulae system into object form, with the fromfst function.  ","category":"page"},{"location":"#Reading-output-from-a-Tabulae-parser","page":"User's guide: introduction","title":"Reading output from a Tabulae parser","text":"","category":"section"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"The fromfst function returns an Analysis object (from the CitableParserBuilder module).","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"using Tabulae\n# Example of SFST output from a parser built with Scala Tabulae:\nsfst = \"<u>latcommon.nounn6506</u><u>ls.n6506</u>can<noun><masc><is_is><div><is_is><noun>em<masc><acc><sg><u>latcommoninfl.is_is4</u>\"\nanalysis = fromfst(sfst)","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Analysis objects include URNs, in abbreviated form, for the lexeme and the morphological form.","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"analysis.lexeme","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"analysis.form","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"You are free to use any citable collection of lexemes you prefer (although the core vocabulary in Tabulae uses a citable collection based on the citable Lewis-Short lexicon from Furman University).","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Morphological form URNs belong to a citable collection defined by Tabulae (described in more detail on the following page). They can be parsed into objects implementing the LatinMorphologicalForm abstract type.","category":"page"},{"location":"#Implementations-of-the-LatinMorphologicalForm","page":"User's guide: introduction","title":"Implementations of the LatinMorphologicalForm","text":"","category":"section"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Work on Tabulae.jl currently focuses on implementing the LatinMorphologicalForm abstract type, including functions to parsing the SFST output of tabulae into implementations of a LatinMorphologicalForm, and converting intances of LatinMorphologicalForms to FormUrns.","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Currently implemented:","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"LatinNoun\nLatinFiniteVerb","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"In progress:","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"adjectives\nadverbs\ngerunds\ngerundives\ninfinitive forms\nparticiples\npronouns\nuninflected forms","category":"page"},{"location":"apis/forms/#Functions-for-working-with-FormUrns","page":"FormUrns","title":"Functions for working with FormUrns","text":"","category":"section"},{"location":"apis/forms/","page":"FormUrns","title":"FormUrns","text":"\nTabulae.personcode\nTabulae.personlabel\nTabulae.numbercode\nTabulae.numberlabel\nTabulae.tensecode\nTabulae.tenselabel\nTabulae.moodcode\nTabulae.moodlabel\nTabulae.voicecode\nTabulae.voicelabel\nTabulae.gendercode\nTabulae.genderlabel\nTabulae.casecode\nTabulae.caselabel\nTabulae.degreecode\nTabulae.degreelabel\nTabulae.uninflectedcode\nTabulae.uninflectedlabel\n","category":"page"},{"location":"apis/forms/#Tabulae.personcode","page":"FormUrns","title":"Tabulae.personcode","text":"Extract person code from a FormUrn.\n\npersoncode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.personlabel","page":"FormUrns","title":"Tabulae.personlabel","text":"Look up label for person code from a FormUrn.\n\npersonlabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.numbercode","page":"FormUrns","title":"Tabulae.numbercode","text":"Extract number code from a FormUrn.\n\nnumbercode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.numberlabel","page":"FormUrns","title":"Tabulae.numberlabel","text":"Look up label for number code from a FormUrn.\n\nnumberlabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.tensecode","page":"FormUrns","title":"Tabulae.tensecode","text":"Extract tense code from a FormUrn.\n\ntensecode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.tenselabel","page":"FormUrns","title":"Tabulae.tenselabel","text":"Look up label for tense code from a FormUrn.\n\ntenselabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.moodcode","page":"FormUrns","title":"Tabulae.moodcode","text":"Extract mood code from a FormUrn.\n\nmoodcode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.moodlabel","page":"FormUrns","title":"Tabulae.moodlabel","text":"Look up label for mood code from a FormUrn.\n\nmoodlabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.voicecode","page":"FormUrns","title":"Tabulae.voicecode","text":"Extract voice code from a FormUrn.\n\nvoicecode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.voicelabel","page":"FormUrns","title":"Tabulae.voicelabel","text":"Look up label for voice code from a FormUrn.\n\nvoicelabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.gendercode","page":"FormUrns","title":"Tabulae.gendercode","text":"Extract gender code from a FormUrn.\n\ngendercode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.genderlabel","page":"FormUrns","title":"Tabulae.genderlabel","text":"Look up label for gender code from a FormUrn.\n\ngenderlabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.casecode","page":"FormUrns","title":"Tabulae.casecode","text":"Extract case code from a FormUrn.\n\ncasecode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.caselabel","page":"FormUrns","title":"Tabulae.caselabel","text":"Look up label for case code from a FormUrn.\n\ncaselabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.degreecode","page":"FormUrns","title":"Tabulae.degreecode","text":"Extract case code from a FormUrn.\n\ndegreecode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.degreelabel","page":"FormUrns","title":"Tabulae.degreelabel","text":"Look up label for degree code from a FormUrn.\n\ndegreelabel(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.uninflectedcode","page":"FormUrns","title":"Tabulae.uninflectedcode","text":"Extract case code from a FormUrn.\n\nuninflectedcode(f)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#Tabulae.uninflectedlabel","page":"FormUrns","title":"Tabulae.uninflectedlabel","text":"Look up label for uninflected code from a FormUrn.\n\nuninflectedlabel(f)\n\n\n\n\n\n\n","category":"function"}]
}
