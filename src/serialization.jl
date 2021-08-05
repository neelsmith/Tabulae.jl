
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
    (typeinfo, ending, ruledata, ruleidval)

    # Look up function creating appropriate 
    # object for this category of word:
    fnctndict = functionforform()
    fnct = fnctndict[analysiscat]

    # Depends on what is regular, what is irregular!
    formcode = ""
    
    if analysiscat == "irregular"
        formcode = fnct(stemdata)  |> formurn
    else
        formcode =  fnct(string(typeinfo, ending, ruledata))  |> formurn
        
    end
    
    Analysis(string(tkn,ending), LexemeUrn(lexidval), formcode, RuleUrn(ruleidval), StemUrn(stemidval))

end

# <u>latcommon.nounn305</u><u>ls.n305</u>acast<noun><masc><us_i><div><us_i><noun>i<masc><nom><pl><u>livymorph.us_i6</u>


#<u>latcommon.compoundn87_3</u><u>ls.n87</u><#>abeg<verb><pftact><div><pftact><verb>it<3rd><sg><pft><indic><act><u>latcommon.pftact_pft3</u>
