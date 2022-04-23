

"""Compose markdown table with declension of a single lexeme.
$(SIGNATURES)
"""
function md_declension(lex::LexemeUrn, td::Tabulae.Dataset; vocative = false)
    mdlines = ["| | Singular | Plural |", "| --- | --- | --- |"]
    stemmatches = stemsforlexeme(td, lex)
    if isempty(stemmatches)
        @warn("No matches in data set for lexeme $(lex).")
        nothing
    else
        gndr = lmpGender(stemmatches[1])
        genderforms = filter(f -> lmpGender(f) ==  gndr, nounforms())
        sing = filter(f -> lmpNumber(f) ==  LMPNumber(1), genderforms)
        sing_analyses = map(f -> generate(f, lex, td), sing)

        pl = filter(f -> lmpNumber(f) ==  LMPNumber(2), genderforms)
        pl_analyses  = map(f -> generate(f, lex, td), pl)

        for (i,f) in enumerate(sing)
            caselabel = lmpCase(f) |> label
            singtokenlist =  CitableParserBuilder.tokens(sing_analyses[i])
            pltokenlist = CitableParserBuilder.tokens(pl_analyses[i])
            push!(mdlines, string("| **", caselabel, "** | ", singtokenlist, " | ", pltokenlist, " |"))
        end

    end
    join(mdlines,"\n") * "\n\n"
end



"""Compose markdown table with parallel declensions of a list of lexemes.
$(SIGNATURES)
"""
function md_declension(lexemelist::Vector{LexemeUrn}, td::Tabulae.Dataset; vocative = false, headings = [])
    mdlines = []
    if length(headings) == length(lexemelist)
        push!(mdlines, "| | " * join(headings, " | ") * " |")   
    else
        push!(mdlines, "| |" * join(map(l -> l.objectid, lexemelist), " | ") * " |")
    end
    colcount = length(lexemelist) + 1
    separator = "|" * repeat(" --- |", colcount)
    push!(mdlines, separator)




    genderlist = map(l -> Tabulae.stemsforlexeme(td, l)[1] |> lmpGender, lexemelist)
    # Singular forms:
    for (i, label) in enumerate(caselabels())
        row = []
        for (j,lex) in enumerate(lexemelist)
            gndr = genderlist[j]
            frm = LMFNoun(gndr, lmpCase(i), lmpNumber(1))
            token = generate(frm, lex, td) |> CitableParserBuilder.tokens
            push!(row, token)
        end

        push!(mdlines, "| *" * label * "* | " * join(row, " | ") * " |")
    end
    

    # loop cases and add column for each lexeme


    join(mdlines,"\n")
end
