"""Compose markdown for full conjugation of a deponent verb.

$(SIGNATURES)
"""
function md_deponent_conjugation(lexu::LexemeUrn, td::Tabulae.Dataset)
    sections = [   
        md_presentsystem_deponent(lexu, td),
        md_perfecthilites_deponent(lexu, td)
    ]
    join(sections, "\n\n")

end

function md_perfecthilites_deponent(lex::LexemeUrn, ds::Tabulae.Dataset)
    mdlines = ["## Perfect system","",
    "List participles here"
    ]
    join(mdlines, "\n")
end


"""Format markdown to display conjugational paradigm of a single tense system of a deponent verb.
$(SIGNATURES)
"""
function md_tenseconjugation_deponent(t::LMPTense, lex::LexemeUrn, td::Tabulae.Dataset)
    tenseforms = filter(f -> f.vtense == t, finiteverbforms())
   
    mdlines = []
    passive_origin = hassubjunctive(t) ?  13 : 7
    offset = perfectsystem(t) ? 3 : 6
    if perfectsystem(t)
        #push!(mdlines, "Passive voice of $(label(t)): TBA")
    else
        push!(mdlines,"Passive voice")
        push!(mdlines, "")
        push!(mdlines, "| | Indicative | Subjunctive |")
        push!(mdlines, "| --- | --- | --- |")
        for i in passive_origin:passive_origin+2
            ind = tenseforms[i]
            indicative = join(CitableParserBuilder.tokens( analyses(lex,ind,td)), ", ")
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")

            if hassubjunctive(t)
                subj = tenseforms[i + offset]
                subjunctive = join(CitableParserBuilder.tokens( analyses(lex,subj,td)), ", ")
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  $(subjunctive) | ")
            else
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  - | ")
            end
        end
        for i in passive_origin+3:passive_origin+5
            ind = tenseforms[i]
            indicative = join(CitableParserBuilder.tokens( analyses(lex,ind,td)), ", ")
            rowheader = join([label(lmpPerson(ind)), label(lmpNumber(ind)) ], " ")

            if hassubjunctive(t)
                subj = tenseforms[i + offset]
                subjunctive = join(CitableParserBuilder.tokens( analyses(lex,subj,td)), ", ")
                push!(mdlines, "| **$(rowheader)** | $(indicative) | $(subjunctive) | ")
            else
                push!(mdlines, "| **$(rowheader)** | $(indicative) |  - | ")
            end
        end
    end
    join(mdlines, "\n")
end


"""Compose markdown for conjugation in the present system of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function md_presentsystem_deponent(lexu::LexemeUrn, td::Tabulae.Dataset)
 
 #   inf_act = LMFInfinitive(
  #      lmpTense("present"), lmpVoice("active")
  #  )
  #  inf_actforms = join(token.(analyses(lexu, formurn(inf_act), td)), ", ")
    inf_pass = LMFInfinitive(
        lmpTense("present"), lmpVoice("passive")
    )
    inf_passforms = join(token.(analyses(lexu, formurn(inf_pass), td)), ", ")
    #actptcpl = participleslashline(lexu, lmpTense("present"), lmpVoice("active"), td)   
    
    
    mdoutput = [
    "## Present system","",
    "### Present tense","",



    ##"*Active voice*:","",

    #md_tenseconjugation(lmpTense("present"), lexu, td),
    "",
    
   "*Passive voice*:","",

   md_tenseconjugation_deponent(lmpTense("present"), lexu, td),

    "### Imperative","",
    
    imperativeconjugation_deponent_md(lexu, td), "",


    "### Infinitives",
    "",

    #"*active*: " * inf_actforms,"",
    "*passive*: " * inf_passforms,"",

    


    #"### Participles","",
    #"*active*: " * actptcpl,





    "### Imperfect tense", 
    "",
    #"*Active voice*:","",
    
    md_tenseconjugation_deponent(lmpTense("imperfect"), lexu, td),
    "",
   



    "### Future tense","",


    md_tenseconjugation_deponent(lmpTense("future"), lexu, td),
    "",
    
    #"### Participles","",

    #"*active*: " * participleslashline(lexu, lmpTense("future"), lmpVoice("active"), td),


   

    ]
    join(mdoutput, "\n")
end



"""Compose markdown table with imperative conjugation of `lex`.
$(SIGNATURES)
"""
function imperativeconjugation_deponent_md(lex::LexemeUrn, td::Tabulae.Dataset)
    p = lmpPerson("second")
    t = lmpTense("present")
    m = lmpMood("imperative")

    mdlines = ["| | Singular | Plural|",   
    "| --- | --- | --- |"]

    #act = lmpVoice("active")
    pass = lmpVoice("passive")

    sing = lmpNumber("singular")
    pl = lmpNumber("plural")

    singforms = [
        #LMFFiniteVerb(p,sing,t,m, act),
        LMFFiniteVerb(p,sing,t,m, pass),
    ]
    generatedsing = []
    for f in singforms
        frmstring = join(analyses(lex, formurn(f), td) .|> token,", ")
        push!(generatedsing, frmstring)
    end
    plforms = [
        #LMFFiniteVerb(p,pl,t,m, act),
        LMFFiniteVerb(p,pl,t,m, pass),
    ]
    generatedpl = []
    for f in plforms
        frmstring = join(analyses(lex, formurn(f),td) .|> token,", ")
        push!(generatedpl,frmstring)
    end
    for i in 1:1 # 1:2
        push!(mdlines, "| **passive** | $(generatedsing[i] ) | $(generatedpl[i] )  |")
    end
    join(mdlines,"\n")

end

