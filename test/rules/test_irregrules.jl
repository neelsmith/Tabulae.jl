@testset "Test rules for irregular forms" begin
    rulessrc = ["irreginfl.irregular1|irregularnoun",
    "irreginfl.irregular2|irregularfiniteverb",
    "irreginfl.irregular3|irregularinfinitive",
    "irreginfl.irregular4|irregularadjective",
    "irreginfl.irregular5|irregularparticiple"
    ]
    irrio = IrregularReaderIO("irr io")
    rules = map(rulessrc) do r
        Tabulae.readrulerow(irrio, r)
    end

    verbstem = "latcommon.irregverbn46529a|ls.n46529|sum|first|singular|present|indicative|active"
    verbio = IrregularVerbIO("irrv io")
    stem = Tabulae.readstemrow(verbio, verbstem)

    rule = rules[2]


end