

"""Compose markdown tabe with declension of a single lexeme.
$(SIGNATURES)
"""
function mddeclension(lex::LexemeUrn, td::Tabulae.Dataset; vocative = false)
    mdlines = ["| | Singular | Plural |", "| --- | --- | --- |"]
    stems = stemsarray(td)
    stemmatches = filter(s -> lexeme(s) == lex, stems)
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
            
            singtokenlist = sing_analyses[i][1].token # REPLACE WIHT REAL FUNTION FROM CPB
            pltokenlist = pl_analyses[i][1].token # REPLACE WIHT REAL  FUCNTION FROM CitableParserBuilder
            push!(mdlines, string("| **", caselabel, "** | ", singtokenlist, " | ", pltokenlist, " |"))
            
            
        end

    end
    join(mdlines,"\n")
end


#=
function mddeclension(lex::LexemeUrn, kd::Kanones.Dataset; withvocative::Bool = false)
    labels = ["nominative", "genitive", "dative", "accusative"]
    lines = ["| | Singular | Plural |", "| --- | --- | --- |"]
    arry = decline(lex, kd;  withvocative = withvocative)
    for i in 1:4
        push!(lines, string("| **", labels[i], "** | ", join(arry[i], ", "), " | ", join(arry[i + 4], ", "), " |"))
    end
    join(lines,"\n")
end
=#