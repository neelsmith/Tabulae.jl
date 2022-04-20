var documenterSearchIndex = {"docs":
[{"location":"guide/urns/#Identification-with-URNs","page":"Identification with URNs","title":"Identification with URNs","text":"","category":"section"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"repo = pwd() |> dirname |> dirname  |> dirname","category":"page"},{"location":"guide/urns/#Key-points","page":"Identification with URNs","title":"Key points","text":"","category":"section"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"all identification is by URN value\nthe CitableParserBuilder package defines four subtypes of the abstract AbbreviatedUrn for the four URNs comprising an analysis in Tabulae:\nthe FormUrn\nthe LexemeUrn\nthe StemUrn\nthe RuleUrn\nthe FormUrn is generated by the parsing system    \nyou use the other three types URNs to identify content in a Tabulae data set    \nyou record each collection in a URN registry that supports round-trip conversion of AbbreviatedUrns and Cite2Urns.","category":"page"},{"location":"guide/urns/#The-URN-registry","page":"Identification with URNs","title":"The URN registry","text":"","category":"section"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"organized in three subdirectories of the dataset's urnregistry directory:\nlexemes\nrules\nstems\nidentical three-column delimited text files: collection ID, collection URN, label\nas many file names as you like ending in .cex; empty lines OK","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"Example:","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"CollectionId|CollectionUrn|Label\nls|urn:cite2:shot:ls.v1:|Latin lexical entities appearing in Lewis-Short's Latin Dictionary.","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"You can get a dictionary of collection IDs to full URNs for your data aset with the registry function.","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"using Tabulae\nsrcdata = joinpath(repo, \"datasets\", \"core-infl-shared\")\ntabds = Tabulae.Dataset([srcdata])\n\nabbrdict = registry(tabds)","category":"page"},{"location":"guide/urns/#Working-with-URNs","page":"Identification with URNs","title":"Working with URNs","text":"","category":"section"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"abbreviate returns an abbreviated string value for a Cite2Urn:","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"using CitableParserBuilder\nusing CitableObject\nlongurn = Cite2Urn(\"urn:cite2:shot:ls.v1:n14736\")\nshortform = abbreviate(longurn)","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"You can use that string to create the appropriate type of abbreviated URN:","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"lex = LexemeUrn(shortform)","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"To convert an AbbreviatedUrn to a Cite2Urn, you need to supply the dataset's URN registry.","category":"page"},{"location":"guide/urns/","page":"Identification with URNs","title":"Identification with URNs","text":"expanded = expand(lex, abbrdict)","category":"page"},{"location":"infltypes/#Stem-types-and-paradigms","page":"Paradigms","title":"Stem types and paradigms","text":"","category":"section"},{"location":"infltypes/#Key-points","page":"Paradigms","title":"Key points","text":"","category":"section"},{"location":"infltypes/","page":"Paradigms","title":"Paradigms","text":"grouped by traditional part of speech and grammatical category\neach stem type is illustrated with an example entry, and a paradigm automatically generated from that entry\nexamples use the data set in the datasets/core-infl-shared directory of the Tabulae github repository","category":"page"},{"location":"guide/stems/#Stems","page":"Stems data","title":"Stems","text":"","category":"section"},{"location":"guide/stems/","page":"Stems data","title":"Stems data","text":"Each stem entry is identified by an abbreviated URN, and identifies a lexeme with a second abbreviated URN.","category":"page"},{"location":"guide/stems/","page":"Stems data","title":"Stems data","text":"All stem types have a string value to use for the stem of the resulting form, and an inflectional class that indicates what category of inflectional endings should be applied to the stem.","category":"page"},{"location":"guide/stems/","page":"Stems data","title":"Stems data","text":"note: Inflectional classes\nSee the reference section on inflectional types for more detailed information about inflectional classes.","category":"page"},{"location":"guide/lexemes/#Vocabulary","page":"Vocabulary","title":"Vocabulary","text":"","category":"section"},{"location":"guide/lexemes/#Key-points","page":"Vocabulary","title":"Key points","text":"","category":"section"},{"location":"guide/lexemes/","page":"Vocabulary","title":"Vocabulary","text":"Vocabulary in the ls collection shares identifiers with the articles in the online Lewis and Short Dictionary from Furman University. E.g., the lexeme ls.n14736 (donum) has a corresponding Lewis-Short article urn:cite2:hmt:ls.markdown:n14736.","category":"page"},{"location":"guide/lexemes/#TBA","page":"Vocabulary","title":"TBA","text":"","category":"section"},{"location":"guide/lexemes/","page":"Vocabulary","title":"Vocabulary","text":"info: TBA: labelling lexemes\nA forthcoming release of Tabulae.jl will include functions for labelling lexeme identifiers with Lewis-Short lemmata.","category":"page"},{"location":"apis/fst/#FST-building","page":"FST building","title":"FST building","text":"","category":"section"},{"location":"apis/fst/","page":"FST building","title":"FST building","text":"Tabulae.buildparser\nTabulae.compilefst\nTabulae.buildmakefile\nTabulae.buildfinalfst\nTabulae.buildlexicon\nTabulae.buildinflection","category":"page"},{"location":"infltypes/nouns/#Nouns","page":"Nouns","title":"Nouns","text":"","category":"section"},{"location":"infltypes/nouns/#Second-declension","page":"Nouns","title":"Second declension","text":"","category":"section"},{"location":"infltypes/nouns/","page":"Nouns","title":"Nouns","text":"Example entry:","category":"page"},{"location":"infltypes/nouns/","page":"Nouns","title":"Nouns","text":"StemUrn|LexicalEntity|Stem|Gender|InflClass\nlatcommon.nounn14736|ls.n14736|don|neuter|us_i","category":"page"},{"location":"infltypes/nouns/","page":"Nouns","title":"Nouns","text":"Automatically generated paradigm:","category":"page"},{"location":"infltypes/nouns/","page":"Nouns","title":"Nouns","text":"using Tabulae, CitableParserBuilder, Markdown\nrepo = pwd() |> dirname |> dirname  |> dirname |> dirname\nsrcdir = joinpath(repo, \"datasets\", \"core-infl-shared\") \ntds = dataset([srcdir])\ndonum = LexemeUrn(\"ls.n14736\")\nMarkdown.parse(mddeclension(donum, tds))","category":"page"},{"location":"guide/datasets/","page":"Datasets","title":"Datasets","text":"repo = pwd() |> dirname |> dirname  |> dirname","category":"page"},{"location":"guide/datasets/#Datasets","page":"Datasets","title":"Datasets","text":"","category":"section"},{"location":"guide/datasets/#Key-points","page":"Datasets","title":"Key points","text":"","category":"section"},{"location":"guide/datasets/","page":"Datasets","title":"Datasets","text":"a set of delimited-text tables in a defined directory structure:\ninflectional patterns in subdirectories of rules-tables\nvocabulary stems in subdirectories of stems-tables\nregistry of URNs for cited collections in urnregistry\ncan simultaneously use multiple sets of tables. E.g., a set with vocabulary and stems for common entries applicable to multiple orthographies, combined with an orthography-specific set.","category":"page"},{"location":"guide/datasets/#Creating-a-Tabulae.Dataset","page":"Datasets","title":"Creating a Tabulae.Dataset","text":"","category":"section"},{"location":"guide/datasets/","page":"Datasets","title":"Datasets","text":"Create a Tabulae.Dataset with a Vector of directories following the prescribed structure:","category":"page"},{"location":"guide/datasets/","page":"Datasets","title":"Datasets","text":"using Tabulae\nsrcdata = joinpath(repo, \"datasets\", \"core-infl-shared\")\ntabds = Tabulae.Dataset([srcdata])\ntabds isa Tabulae.Dataset","category":"page"},{"location":"apis/forms/#Basics-of-Latin-morphology","page":"FormUrns","title":"Basics of Latin morphology","text":"","category":"section"},{"location":"apis/forms/#Morphological-properties","page":"FormUrns","title":"Morphological properties","text":"","category":"section"},{"location":"apis/forms/","page":"FormUrns","title":"FormUrns","text":"LatinMorphologicalProperty\ncode\nlabel","category":"page"},{"location":"apis/forms/#Tabulae.LatinMorphologicalProperty","page":"FormUrns","title":"Tabulae.LatinMorphologicalProperty","text":"Abstract type of a morphological form in Tabulae.\n\n\n\n\n\n","category":"type"},{"location":"apis/forms/#Tabulae.code","page":"FormUrns","title":"Tabulae.code","text":"Integer code for  morphological property value.\n\ncode(lmp)\n\n\n\n\n\n\nInteger code for  tense value.\n\ncode(tense)\n\n\n\n\n\n\nInteger code for a LMPMood value.\n\ncode(mood)\n\n\n\n\n\n\nInteger code for a LMPVoice value.\n\ncode(voice)\n\n\n\n\n\n\nInteger code for a LMPPerson value.\n\ncode(person)\n\n\n\n\n\n\nInteger code for a LMPPerson value.\n\ncode(num)\n\n\n\n\n\n\nInteger code for a LMPGender value.\n\ncode(gender)\n\n\n\n\n\n\nInteger code for a LMPCase value.\n\ncode(cs)\n\n\n\n\n\n\nInteger code for a LMPPerson value.\n\ncode(degree)\n\n\n\n\n\n\nInteger code for a LMPUninflectedType value.\n\ncode(uninfl)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/#CitableBase.label","page":"FormUrns","title":"CitableBase.label","text":"Delegate label to specific functions based on  type's citable trait value.\n\nlabel(x)\n\n\n\n\n\n\nIt is an error to invoke the label function on material that is not citable.\n\nlabel(_, x)\n\n\n\n\n\n\nFind human-readable label for a CatalogedText.\n\nlabel(catentry)\n\n\n\n\n\n\nLabel for psg.\n\nlabel(psg)\n\n\nRequired function for Citable abstraction.\n\n\n\n\n\nLabel for doc.\n\nlabel(doc)\n\n\nRequired function for Citable abstraction.\n\n\n\n\n\nLabel for AnalyzedToken (required for Citable interface).\n\nlabel(at)\n\n\n\n\n\n\nLabel for a form.\n\nlabel(mf)\n\n\nAll subclasses of LatinMorphologicalForm should implement this specifically for their subclass.\n\n\n\n\n\nHuman-readable label for morphological property value.\n\n\n\n\n\nHuman-readable label for tense value.\n\nlabel(tense)\n\n\n\n\n\n\nHuman-readable label for a LMPMood value.\n\nlabel(mood)\n\n\n\n\n\n\nHuman-readable label for a LMPVoice value.\n\nlabel(voice)\n\n\n\n\n\n\nHuman-readable label for a LMPPerson value.\n\nlabel(person)\n\n\n\n\n\n\nHuman-readable label for a LMPPerson value.\n\nlabel(num)\n\n\n\n\n\n\nHuman-readable label for a LMPGender value.\n\nlabel(gender)\n\n\n\n\n\n\nHuman-readable label for a LMPCase value.\n\nlabel(cs)\n\n\n\n\n\n\nHuman-readable label for a LMPPerson value.\n\nlabel(degree)\n\n\n\n\n\n\nHuman-readable label for a LMPUninflectedType value.\n\nlabel(uninfl)\n\n\n\n\n\n\nCompose a label for a LMFNoun\n\nlabel(noun)\n\n\n\n\n\n\nCompose a label for a LMFFiniteVerb\n\nlabel(verb)\n\n\n\n\n\n\nCompose a label for a LMFInfinitive.\n\nlabel(inf)\n\n\n\n\n\n\nHuman-readlable label for a TabulaeNounStem.\n\n@(SIGNATURES) Required for CitableTrait.\n\n\n\n\n\nHuman-readlable label for a TabulaeNounRule.\n\n@(SIGNATURES) Required for CitableTrait.\n\n\n\n\n\n","category":"function"},{"location":"apis/forms/","page":"FormUrns","title":"FormUrns","text":"Specific property types and their consturctor/accessor functions:","category":"page"},{"location":"apis/forms/","page":"FormUrns","title":"FormUrns","text":"LMFTense\nlmfTense\nLMFMood\nlmfMood\nLMFVoice\nlmfVoice\nLMFPerson\nlmfPerson\nLMFNumber\nlmfNumber\nLMFGender\nlmfGender\nLMFCase\nlmfCase\nLMFDegree\nlmfDegree\nLMFUninflectedType\nlmfUninflectedType","category":"page"},{"location":"guide/analyses/","page":"Analyses","title":"Analyses","text":"repo = pwd() |> dirname |> dirname  |> dirname","category":"page"},{"location":"guide/analyses/#Analyses","page":"Analyses","title":"Analyses","text":"","category":"section"},{"location":"guide/analyses/#Building-a-parser","page":"Analyses","title":"Building a parser","text":"","category":"section"},{"location":"guide/analyses/","page":"Analyses","title":"Analyses","text":"One example among many possibilities: build a StringParser from a data set.","category":"page"},{"location":"guide/analyses/","page":"Analyses","title":"Analyses","text":"using Tabulae, CitableParserBuilder\nsrcdata = joinpath(repo, \"datasets\", \"core-infl-shared\")\ntabds = Tabulae.Dataset([srcdata])\nparser = stringParser(tabds)","category":"page"},{"location":"guide/analyses/#How-to-parse-a-token","page":"Analyses","title":"How to parse a token","text":"","category":"section"},{"location":"guide/analyses/","page":"Analyses","title":"Analyses","text":"results = parsetoken(\"donum\", parser)","category":"page"},{"location":"guide/analyses/#Key-points-about-analyses","page":"Analyses","title":"Key points about analyses","text":"","category":"section"},{"location":"guide/forms/#Morphological-forms-and-their-properties","page":"Morphological forms","title":"Morphological forms and their properties","text":"","category":"section"},{"location":"guide/forms/#LatinMorphologicalForms","page":"Morphological forms","title":"LatinMorphologicalForms","text":"","category":"section"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Implementations of the abstract LatinMorphologicalForm model the properties identifying a particular type of token. For example, a LMFNoun has properties for gender, case and number.  Each of these properties in turn are subtypes of the LatinMorphologicalProperty.  We can construct a form directly from these properties.  For example, a LMFNoun can be constructed like this:","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"using Tabulae\ng = lmpGender(\"masculine\")\nc = lmpCase(\"accusative\")\nn = lmpNumber(\"singular\")\nnoun = LMFNoun(g,c,n)","category":"page"},{"location":"guide/forms/#Tabulae's-collection-of-form-values","page":"Morphological forms","title":"Tabulae's collection of form values","text":"","category":"section"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Forms are identified by a Cite2Urn belonging to the collection urn:cite2:tabulae:forms.v1.","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"As citable objects, they include the label function.","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"label(noun)","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Object identifiers in this collection are ten-character strings with each character representing an integer code for the following morphological properties:","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"\"part of speech\" (more precisely, the analytical type)\nperson\nnumber\ntense\nmood\nvoice\ngender\ncase\ndegree\nuninflected category","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"In the following line, the initial digit 2 means \"noun form\"; the number value 1 means singular; the gender value 3 means \"neuter\" and the case value 1 means \"nominative\".","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"urn(noun)","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Convenience methods let you work with these identifiers directly, or as a FormUrn (from the CitableParserBuilder package).","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Tabulae.formurn(noun)","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"code(noun)","category":"page"},{"location":"guide/forms/#More-constructors","page":"Morphological forms","title":"More constructors","text":"","category":"section"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"For each subtype of LatinMorphologicalForm, a corresponding constructor function (with a name beginning in lowercase) accepts a variety of kinds of sources for a form, such as a Cite2Urn:","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"u = urn(noun)\nlmfNoun(u) == noun","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Other sources you can use to create a LatinMorphologicalForm include strings, abbreviated URNs, Analysis objects and TabulaeRule objects.  See the API documentation for details.","category":"page"},{"location":"guide/forms/#Properties","page":"Morphological forms","title":"Properties","text":"","category":"section"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"Each implementation of the LatinMorphologicalProperty has a corresponding lower-case function you can use to extract that property from a form.","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"gender = lmpGender(noun)","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"You can use the code and label functions to find an integer code and readable string for any morphological property.","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"code(gender)","category":"page"},{"location":"guide/forms/","page":"Morphological forms","title":"Morphological forms","text":"label(gender)","category":"page"},{"location":"apis/apis/#Latin-morphology-API-documentation","page":"Latin Morphology API","title":"Latin morphology API documentation","text":"","category":"section"},{"location":"apis/apis/","page":"Latin Morphology API","title":"Latin Morphology API","text":"Pages = [\"apis.md\"]\nDepth = 3","category":"page"},{"location":"apis/apis/#Public-types","page":"Latin Morphology API","title":"Public types","text":"","category":"section"},{"location":"apis/apis/","page":"Latin Morphology API","title":"Latin Morphology API","text":"LatinMorphologicalForm\nLMFNoun\nLMFFiniteVerb","category":"page"},{"location":"apis/apis/#Tabulae.LatinMorphologicalForm","page":"Latin Morphology API","title":"Tabulae.LatinMorphologicalForm","text":"Abstract type of a morphological form.\n\n\n\n\n\n","category":"type"},{"location":"apis/apis/#Tabulae.LMFNoun","page":"Latin Morphology API","title":"Tabulae.LMFNoun","text":"Nouns have gender, case and number.\n\n\n\n\n\n","category":"type"},{"location":"apis/apis/#Tabulae.LMFFiniteVerb","page":"Latin Morphology API","title":"Tabulae.LMFFiniteVerb","text":"Finite verbs have person, number, tense, mood and voice.\n\n\n\n\n\n","category":"type"},{"location":"guide/rules/#Rules","page":"Rules data","title":"Rules","text":"","category":"section"},{"location":"guide/rules/","page":"Rules data","title":"Rules data","text":"Rules associate an inflectional ending with a morphological form.","category":"page"},{"location":"guide/rules/","page":"Rules data","title":"Rules data","text":"Rules tables include an abbreviated URN to identify the rule, an inflectional class, a string value for ending, and a series of columns with morphological information that depends on the type of the rule.  Nouns, for example, have columns for gender, case and number.","category":"page"},{"location":"guide/rules/","page":"Rules data","title":"Rules data","text":"note: Inflectional classes\nSee the reference section on inflectional types for more detailed information about inflectional classes.","category":"page"},{"location":"#Tabulae.jl","page":"User's guide: introduction","title":"Tabulae.jl","text":"","category":"section"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Tabulae.jl is an implementation in Julia of the Tabulae system implemented in Scala here.","category":"page"},{"location":"#Key-points","page":"User's guide: introduction","title":"Key points","text":"","category":"section"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"Tabulae datasets are composed of tables of inflectional rules, and tables of vocabulary stems.\nEach dataset follows a specified orthography.\nForms and lexemes are identified by URNs that are independent of orthography.\nDatasets are compatible between the Scala and Julia systems.\nData tables use abbreviated URNs; adding a URN registry to the dataset allows expanding abbreviated URNs to full Cite2Urns.\nTabulae.jl is a pure Julia system: it has no external dependencies.","category":"page"},{"location":"","page":"User's guide: introduction","title":"User's guide: introduction","text":"note: Note\nAll code examples in this site use the Tabulae data set in the datasets/core-infl-shared directory of the Tabulae github repository.","category":"page"}]
}
