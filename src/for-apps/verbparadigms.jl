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



"""Compose markdown for full conjugation of verb identified
by LexemeUrn.
$(SIGNATURES)
"""
function md_verb_conjugation(lexu::LexemeUrn, td::Tabulae.Dataset)
    sections = [   
        md_presentsystem(lexu, td),
        md_futuresystem(lexu, td),
        md_perfectsystem(lexu, td),
    ]
    join(sections, "\n\n")
end


function md_futuresystem(lexu::LexemeUrn, td::Tabulae.Dataset)
    "## TBA: future system"
end



function md_perfectsystem(lexu::LexemeUrn, td::Tabulae.Dataset)
    "## TBA: perfect system"
end

"""Compose markdown table with imperative conjugation of `lex`.
$(SIGNATURES)
"""
function imperativeconjugation_md(lex::LexemeUrn, td::Tabulae.Dataset)
    p = lmpPerson("second")
    t = lmpTense("present")
    m = lmpMood("imperative")

    mdlines = ["| | Singular | Plural|",   
    "| --- | --- | --- |"]

    act = lmpVoice("active")
    pass = lmpVoice("passive")

    sing = lmpNumber("singular")
    pl = lmpNumber("plural")

    singforms = [
        LMFFiniteVerb(p,sing,t,m, act),
        LMFFiniteVerb(p,sing,t,m, pass),
    ]
    generatedsing = []
    for f in singforms
        frmstring = join(generate(lex, formurn(f), td) .|> token,", ")
        push!(generatedsing, frmstring)
    end
    plforms = [
        LMFFiniteVerb(p,pl,t,m, act),
        LMFFiniteVerb(p,pl,t,m, pass),
    ]
    generatedpl = []
    for f in plforms
        frmstring = join(generate(lex, formurn(f),td) .|> token,", ")
        push!(generatedpl,frmstring)
    end
    for i in 1:2
        push!(mdlines, "| **$(voicelabeldict[i])** | $(generatedsing[i] ) | $(generatedpl[i] )  |")
    end
    join(mdlines,"\n")

end


"""Compose markdown for conjugation in the present system of the verb identified by LexemeUrn.
$(SIGNATURES)
"""
function md_presentsystem(lexu::LexemeUrn, td::Tabulae.Dataset)
 
    inf_act = LMFInfinitive(
        lmpTense("present"), lmpVoice("active")
    )
    inf_actforms = join(token.(generate(lexu, formurn(inf_act), td)), ", ")
    inf_pass = LMFInfinitive(
        lmpTense("present"), lmpVoice("passive")
    )
    inf_passforms = join(token.(generate(lexu, formurn(inf_pass), td)), ", ")
    actptcpl = participleslashline(lexu, lmpTense("present"), lmpVoice("active"), td)   
    #passptcpl = participleslashline(lexu, lmpTense("present"), lmpVoice("passive"), td)
    
    mdoutput = [
    "## Present system","",
    "### Present tense","",



    #"*Active voice*:","",

    md_tenseconjugation(lmpTense("present"), lexu, td),
    "",
    
   # "*Passive voice*:","",
   # verb_conjugation_md(lmpTense("present"), lmpVoice("passive"), lexu, kd),
   # "",


    "### Imperative","",
    imperativeconjugation_md(lexu, td), 


    "### Infinitives","",

    "*active*: " * inf_actforms,"",
    "*passive*: " * inf_passforms,"",

    


    "### Participles","",

    "*active*: " * actptcpl,





    "### Imperfect tense","",
    #"*Active voice*:","",
    md_tenseconjugation(lmpTense("imperfect"), lexu, td),
    "",
    ]
    join(mdoutput, "\n")
end



"""Compose a string with masculine, feminine, neuter nominative singular of a given particple for `lexeme`.
$(SIGNATURES)
"""
function participleslashline(
    lex::LexemeUrn,  
    tense::LMPTense, voice::LMPVoice, 
    td::Tabulae.Dataset;
    examplecase = lmpCase("nominative")
    )::String

    formslist = filter(f -> f isa LMFParticiple && lmpTense(f) == tense && lmpVoice(f) == voice && lmpNumber(f) == lmpNumber(1) && lmpCase(f) == examplecase, allforms())

    generated = map(f -> token.(generate(lex, formurn(f), td)),  formslist)
    join(map(v -> isempty(v) ? "" : v[1], generated), ", ")
end


"""Compile list of all possible form codes.
$(SIGNATURES)
"""
function allformcodes()
    vcat(
        #nounformcodes(), 
        #adjectiveformcodes(),
        finiteverbcodes(),
        infinitiveformcodes(),
        participleformcodes(),
        ##pronounformcodes(),
        #uninflectedformcodes()
    )
end

"""Generate list of all possible form objects.
$(SIGNATURES)
"""
function allforms()
    allformcodes() .|> latinForm
end

