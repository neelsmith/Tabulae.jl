function generatenoun(lex::LexemeUrn, nounform::LMFNoun, td::Tabulae.Dataset)::Vector{Analysis}
    @info("generate a noun form from a lexeme urn + form + dataset")
    generated = Analysis[]   
    targetgender = lmpGender(nounform) 
    stems = stemsarray(td)
    stemlist = filter(s -> lexeme(s) == lex, stems)
    if isempty(stemlist)
        @warn("No stems matched lexeme $(lex)")   

    else
        rules = rulesarray(td)
        for stem in stemlist
            stemgender = lmpGender(stem)
            if stemgender == targetgender
                classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && latinForm(r) == nounform, rules)
                for rule in classrules
                    if latinForm(rule) isa LMFNoun
                        rulegender = lmpGender(latinForm(rule))
                        if targetgender == rulegender
                           # token = string(stemvalue(stem), ending(rule))
                            tknid = "A"
                            push!(generated, analysis(stem, rule; tokenid = tknid))
                        end
                    end
                end
            end
            
        end
    end

    generated
end

"""Generate vector of possible strings for a form of `lex` identified by `form` for types where stem encodes the form.

$(SIGNATURES)
"""
function generatefromstemform(lex::LexemeUrn, frm::T, td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
end

"""Generate vector of possible strings for a form of `lex` identified by `form` for types where stem encodes the form.

$(SIGNATURES)
"""
function generatefromruleform(lex::LexemeUrn, frm::T, td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
end

"""Find all analyses that can be composed from a given dataset for a given lexeme in a given form.

$(SIGNATURES)
"""
function analyses(lex::LexemeUrn, frm::T,   td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
    @debug("Genrerating analyzes from lexeme urn + form in a dataset")
    if frm isa LMFNoun
        generatenoun(lex, frm, td)

    else
        @debug("generate $(lex) in form $(frm) from a dataset")
        
        stems = stemsarray(td)
        rules = rulesarray(td)

        generated = Analysis[]

        stemlist = filter(s -> lexeme(s) == lex, stems)
        if isempty(stemlist)
            @warn("No stems matched lexeme $(lex)")

        else
            for stem in stemlist
                if buildfromstem(stem)
                    if latinForm(stem) == frm
                        @debug("BUILD FORM FROM STEM: $(frm)")
                        classrules = filter(rules) do r
                            inflectionclass(r) == inflectionclass(stem) #&& latinForm(stem) == frm
                        end
                        @debug(classrules)
                        for rule in classrules
                            token = string(stemvalue(stem), ending(rule))
                            tknid = "A"
                            push!(generated, analysis(stem, rule; tokenid = tknid))
                        end
                    end

                else   
                    classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && latinForm(r) == frm, rules)
                    @info("Build from rule: $(classrules)")
                    for rule in classrules
                        token = string(stemvalue(stem), ending(rule))
                        tknid = "A"
                        push!(generated, analysis(stem, rule; tokenid = tknid))
                    end  
                end 
            end
        end
        
        generated
    end
end 

"""Find all analyses that can be composed from a given dataset for a given lexeme URN + a given form URN.

$(SIGNATURES)
"""
function analyses(lex::LexemeUrn, frm::FormUrn, td::Tabulae.Dataset)::Vector{Analysis} 
    @debug("Genrerating analyzes from lexeme urn + form urn in a dataset")
    analyses(lex, latinForm(frm), td)
end


"""Generate an `Analysis` frm the combination of a stem and a rule.

$(SIGNATURES)
"""
function analysis(stem::TStem, rule::TRule; tokenid = "A")::Analysis where {TRule <: TabulaeRule, TStem <: TabulaeStem}
    morphform = buildfromrule(rule) ? latinForm(rule) : latinForm(stem)
    token = string(stemvalue(stem), ending(rule))
    Analysis(token, lexeme(stem),Tabulae.formurn(morphform), urn(stem),urn(rule), token, tokenid)
end 
