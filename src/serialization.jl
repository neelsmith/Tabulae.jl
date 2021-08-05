
function functionforform()
    Dict(
        "verb" =>  Tabulae.verbfromfst
    )
end

"""Parse a line of SFST output into a `LatinMorphologicalForm`.

$(SIGNATURES)
"""
function fromfst(s)

    (stemraw,rule) = split(s, "<div>")
    stem = replace(stemraw, "<#>" => "#")


    stemre = r"<u>([^<]+)</u><u>([^<]+)</u>([^<]+)<([^>]+)>(.+)"

    stemmatch = collect(eachmatch(stemre, stem))
    (stemidval, lexidval, tkn, analysiscat, stemdata) = stemmatch[1].captures
    
 
    rulere = r"(<[^>]+><[^>]+>)([^<]*)(.*)<u>(.+)</u>"
    rulematch = collect(eachmatch(rulere, rule))
    (typeinfo, ending, ruledata, ruleidval) = rulematch[1].captures


    fnctndict = functionforform()
    fnct = fnctndict[analysiscat]

    
    # Depends on what is regular, what is irregular!
    formurn = ""
    if analysiscat == "irregular"
        formurn = fnct(stemdata)
    else
        formurn =  string(typeinfo, ending, ruledata) |> fnct
    end
    
    Analysis(string(tkn,ending), LexemeUrn(lexidval), formurn, RuleUrn(ruleidval), StemUrn(stemidval))

end

# <u>latcommon.nounn305</u><u>ls.n305</u>acast<noun><masc><us_i><div><us_i><noun>i<masc><nom><pl><u>livymorph.us_i6</u>
