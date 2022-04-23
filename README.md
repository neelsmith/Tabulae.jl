![build](https://github.com/neelsmith/Tabulae.jl/actions/workflows/Documentation.yml/badge.svg)


# Tabulae.jl

Build Latin morphological parsers from simple delimited-text tables.



## Progress


| Analytical type	| morphology | analyze | generate |
| --- | --- | --- | --- |
| uninflected token | |||
| noun | ✅ |  ✅ |  ✅ |
| pronoun | |||
| adjective | |||
| finite verb | ✅ |✅ | ✅ |
| infinitive | |||
| participle | |||
| gerund | |||
| gerundive | |||
| supine | |||
| adverb | |||




## Unit tests

Tabulae includes a large suite of unit tests.  To run all of all them, just use the standard `test` command from package mode (and be prepared to wait).

If you want to run a selection of tests, you can do that from the `tests` directory by running `julia select_tests.jl [FILENAMES]`.   `select_tests.jl` uses the `TestSetExtensions.jl` package; if you prefer its reporting format, you can run all the tests with  `julia select_tests.jl test* */test*jl`.


