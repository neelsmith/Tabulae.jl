

"""Compose markdown table with declension of a single lexeme.
$(SIGNATURES)
"""
function md_declension(lex::LexemeUrn, td::Tabulae.Dataset)
    mdlines = ["| | Singular | Plural |", "| --- | --- | --- |"]
    stemmatches = stemsforlexemeurn(td, lex)
    if isempty(stemmatches)
        @warn("No matches in data set for lexeme $(lex).")
        nothing
    else
        gndr = lmpGender(stemmatches[1])
        genderforms = filter(f -> lmpGender(f) ==  gndr, nounforms())
        sing = filter(f -> lmpNumber(f) ==  LMPNumber(1), genderforms)
        sing_analyses = map(f -> generate(lex,f,  td), sing)

        pl = filter(f -> lmpNumber(f) ==  LMPNumber(2), genderforms)
        pl_analyses  = map(f -> generate(lex, f,  td), pl)

        for (i,f) in enumerate(sing)
            caselabel = lmpCase(f) |> label
            singtokenlist =  join(CitableParserBuilder.tokens(sing_analyses[i]), ", ")
            pltokenlist = join(CitableParserBuilder.tokens(pl_analyses[i]), ", ")
            push!(mdlines, string("| **", caselabel, "** | ", singtokenlist, " | ", pltokenlist, " |"))
        end

    end
    join(mdlines,"\n") * "\n\n"
end



"""Compose markdown table with parallel declensions of a list of lexemes.
$(SIGNATURES)
"""
function md_declension(lexemelist::Vector{LexemeUrn}, td::Tabulae.Dataset; headings = [])
    mdlines = []
    if length(headings) == length(lexemelist)
        push!(mdlines, "| | " * join(headings, " | ") * " |")   
    else
        push!(mdlines, "| |" * join(map(l -> l.objectid, lexemelist), " | ") * " |")
    end
    colcount = length(lexemelist) + 1
    separator = "|" * repeat(" --- |", colcount)
    push!(mdlines, separator)
    sglabel = "| *singular* " * repeat(" | ", colcount - 1)
    push!(mdlines, sglabel)




    genderlist = map(l -> Tabulae.stemsforlexemeurn(td, l)[1] |> lmpGender, lexemelist)
    # Singular forms:
    for (i, label) in enumerate(caselabels())
        row = []
        for (j,lex) in enumerate(lexemelist)
            gndr = genderlist[j]
            frm = LMFNoun(gndr, lmpCase(i), lmpNumber(1))
            token = join(CitableParserBuilder.tokens(generate(lex, frm, td)), ", ")
            push!(row, token)
        end

        push!(mdlines, "| **" * label * "** | " * join(row, " | ") * " |")
    end
    
    push!(mdlines, "| *plural* " * repeat(" | ", colcount - 1))
    # Plural forms:
    # loop cases and add column for each lexeme
    for (i, label) in enumerate(caselabels())
        row = []
        for (j,lex) in enumerate(lexemelist)
            gndr = genderlist[j]
            frm = LMFNoun(gndr, lmpCase(i), lmpNumber(2))
            token = join(CitableParserBuilder.tokens(generate(lex, frm, td)), ", ")
            push!(row, token)
        end

        push!(mdlines, "| **" * label * "** | " * join(row, " | ") * " |")
    end

    join(mdlines,"\n")
end
