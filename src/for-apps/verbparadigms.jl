
function md_tenseconjugation(t::LMPTense, lex::LexemeUrn, td::Tabulae.Dataset)
    tenseforms = filter(f -> f.vtense == t, finiteverbforms())
    
    
    mdlines = ["Active voice", 
    "",
    "| | Indicative | Subjunctive |",
    "| --- | --- | --- |"
    ]
    for i in 1:3
        indic = tenseforms[i]
        indicative = CitableParserBuilder.tokens( generate(indic,lex,td))

        subj = tenseforms[i + 6]
        subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))
        rowheader = join([label(lmpPerson(indic)), label(lmpNumber(indic)) ], " ")
        push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
    end

    for i in 4:6
        indic = tenseforms[i]
        indicative = CitableParserBuilder.tokens( generate(indic,lex,td))

        subj = tenseforms[i + 6]
        subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))
        rowheader = join([label(lmpPerson(indic)), label(lmpNumber(indic)) ], " ")
        push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
    end

    if perfectsystem(t)
        push!(mdlines, "Passive voice of $(label(t)): TBA")
    else
        push!(mdlines,"Passive voice")
        push!(mdlines, "")
        push!(mdlines, "| | Indicative | Subjunctive |")
        push!(mdlines, "| --- | --- | --- |")
        for i in 7:9
            subj = tenseforms[i]
            subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))

            ind = tenseforms[i + 6]
            indicative = CitableParserBuilder.tokens( generate(ind,lex,td))
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")
            push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
        end
        for i in 10:12
            subj = tenseforms[i]
            subjunctive = CitableParserBuilder.tokens( generate(subj,lex,td))

            ind = tenseforms[i + 6]
            indicative = CitableParserBuilder.tokens( generate(ind,lex,td))
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")
            push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
        end
    end
    join(mdlines, "\n")
end