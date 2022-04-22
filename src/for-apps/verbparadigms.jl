
function md_tenseconjugation(t::LMPTense, lex::LexemeUrn, td::Tabulae.Dataset)
    tenseforms = filter(f -> f.vtense == t, finiteverbforms())
    
    mdlines = ["| | Indicative | Subjunctive |",
    "| --- | --- | --- |"
    ]
    for i in 1:3
        s = tenseforms[i]
        sing = CitableParserBuilder.tokens( generate(s,lex,td))

        pl = tenseforms[i + 6]
        plural = CitableParserBuilder.tokens( generate(pl,lex,td))
        rowheader = join([label(lmpPerson(s)), label(lmpNumber(s)) ], " ")
        push!(mdlines, "| **$(rowheader)** | $(sing) | $(plural) | ")
    end

    for i in 4:6
        s = tenseforms[i]
        sing = CitableParserBuilder.tokens( generate(s,lex,td))

        pl = tenseforms[i + 6]
        plural = CitableParserBuilder.tokens( generate(pl,lex,td))
        rowheader = join([label(lmpPerson(s)), label(lmpNumber(s)) ], " ")
        push!(mdlines, "| **$(rowheader)** | $(sing) | $(plural) | ")
    end
    join(mdlines, "\n")
end