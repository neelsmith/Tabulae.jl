

# Tabulae.jl

Build Latin morphological parsers from simple delimited-text tables.


## Progress on ground-up rewrite: regular forms


Version 0.10.0 is a complete rewrite of the package built on a new type hierarchy in the `CitableParserBuilder` package. Documentation of current work on version 0.10.0 is available on [quarto.pub](https://neelsmith.quarto.pub/tabulae/); you can follow progress on [this milestone](https://github.com/neelsmith/Tabulae.jl/issues?q=is%3Aopen+is%3Aissue+milestone%3A%220.10+release%22) in the project's github issue tracker.


| Analytical type	| morphology | analyze | generate |
| --- | --- | --- | --- |
| uninflected token | |||
| noun | ✅ |  ✅ |  ✅ |
| pronoun | |||
| adjective | |||
| finite verb | ✅ |✅ | ✅ |
| infinitive | ✅|✅|✅|
| participle | ✅ | ✅| ✅ |
| gerund | |||
| gerundive | |||
| supine | |||
| adverb | |||




## Unit tests

Tabulae includes a large suite of unit tests.  To run all of all them, just use the standard `test` command from package mode (and be prepared to wait).

If you want to run a selection of tests, you can do that from the `tests` directory by running `julia select_tests.jl [FILENAMES]`.   `select_tests.jl` uses the `TestSetExtensions.jl` package; if you prefer its reporting format, you can run all the tests with  `julia select_tests.jl test* */test*jl`.


