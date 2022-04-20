# Tabulae.jl

`Tabulae.jl` is an implementation in Julia of the Tabulae system implemented in Scala [here](https://github.com/neelsmith/tabulae).

## Key points

- Tabulae *datasets* are composed of tables of inflectional rules, and tables of vocabulary stems.
- Each dataset follows a specified *orthography*.
- Forms and lexemes are identified by URNs that are independent of orthography.
- Datasets are compatible between the Scala and Julia systems.
- Data tables use *abbreviated URNs*; adding a URN registry to the dataset allows expanding abbreviated URNs to full `Cite2Urns`.
- `Tabulae.jl` is a pure Julia system: it has no external dependencies.



!!! note

    All code examples in this site use the Tabulae data set in the [`datasets/core-infl-shared` directory](https://github.com/neelsmith/Tabulae.jl/tree/main/datasets/core-infl-shared) of the Tabulae github repository.
