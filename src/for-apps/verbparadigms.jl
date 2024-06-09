function cyclethem(t::LMPTense, lex::LexemeUrn, td::Tabulae.Dataset)
    tenseforms = filter(f -> f.vtense == t, finiteverbforms())
    println("IND ACT")
    for i in 1:3
        println(label(tenseforms[i]))
    end
    println("SUBJ ACT")
    for i in 7:9
        println(label(tenseforms[i]))
    end

    println("IND PASS")
    for i in 13:15
        println(label(tenseforms[i]))
    end
    println("SUBJ PASS")
    for i in 19:21
        println(label(tenseforms[i]))
    end

end

"""Format markdown to display conjugational paradigm of a single tense system of `lex`.
$(SIGNATURES)
"""
function md_tenseconjugation(t::LMPTense, lex::LexemeUrn, td::Tabulae.Dataset)
    tenseforms = filter(f -> f.vtense == t, finiteverbforms())
   

    mdlines = ["Active voice", "",
    "| | Indicative | Subjunctive |",   
    "| --- | --- | --- |"]
    

    # Indicative singular:
    for i in 1:3
        indic = tenseforms[i]
        indicative = join(CitableParserBuilder.tokens(generate(lex,indic,td)), ", ")
        rowheader = join([label(lmpPerson(indic)), label(lmpNumber(indic)) ], " ")

        if hassubjunctive(t)
            subj = tenseforms[i + 6]
            subjunctive = join(CitableParserBuilder.tokens( generate(lex,subj,td)), ", ")
            push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
        else
            push!(mdlines, "| **$(rowheader)** | $(indicative) | - | ")
        end
    end


    
    for i in 4:6
        indic = tenseforms[i]
        indicative = join(CitableParserBuilder.tokens( generate(lex,indic,td)), ", ")
        rowheader = join([label(lmpPerson(indic)), label(lmpNumber(indic)) ], " ")

        if hassubjunctive(t)
            subj = tenseforms[i + 6]
            subjunctive = join(CitableParserBuilder.tokens( generate(lex,subj,td)), ", ")
            push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
        else
            push!(mdlines, "| **$(rowheader)** | $(indicative) | - | ")
        end
    end

    passive_origin = hassubjunctive(t) ?  13 : 7

    
    offset = perfectsystem(t) ? 3 : 6
    if perfectsystem(t)
        push!(mdlines, "Passive voice of $(label(t)): TBA")
    else
        push!(mdlines,"Passive voice")
        push!(mdlines, "")
        push!(mdlines, "| | Indicative | Subjunctive |")
        push!(mdlines, "| --- | --- | --- |")
        for i in passive_origin:passive_origin+2
            ind = tenseforms[i]
            indicative = join(CitableParserBuilder.tokens( generate(lex,ind,td)), ", ")
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")

            if hassubjunctive(t)
                subj = tenseforms[i + offset]
                subjunctive = join(CitableParserBuilder.tokens( generate(lex,subj,td)), ", ")
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  $(subjunctive) | ")
            else
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  - | ")
            end
        end
        for i in passive_origin+3:passive_origin+5
            ind = tenseforms[i]
            indicative = join(CitableParserBuilder.tokens( generate(lex,ind,td)), ", ")
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")

            if hassubjunctive(t)
                subj = tenseforms[i + offset]
                subjunctive = join(CitableParserBuilder.tokens( generate(lex,subj,td)), ", ")
                push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
            else
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  - | ")
            end
        end
    end
    join(mdlines, "\n")
end