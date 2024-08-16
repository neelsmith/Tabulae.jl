function generatenoun(lex::LexemeUrn, nounform::LMFNoun, td::Tabulae.Dataset)##::Vector{Analysis}
    @info("generate a noun form from a lexeme urn + form + dataset")
    generated = Analysis[]   
    targetgender = lmpGender(nounform) 
    stems = stemsarray(td)
    stemlist = filter(s -> lexeme(s) == lex, stems)
end

"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
function generateXRMFORMERNOUN(lex::LexemeUrn, form::T,   td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
    if nounform isa LMFNoun
        generatenoun(lex, form, td)
    else

        @info("generate a non-noun form from a lexeme urn + form + dataset")
    end
        #=
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
                            token = string(stemvalue(stem), ending(rule))
                            tokenid = "A"
                            @debug("Matching, created $(token) for infl type $(inflectionclass(rule)) and form $(latinForm(rule))")
                            push!(generated, Analysis(token, lexeme(stem),Tabulae.formurn(latinForm(rule)), urn(stem),urn(rule), token, tokenid))
                        end
                    end
                end
            end
            
        end
    end

    generated=#
end

"""Generate vector of possible strings for a form of `lex` identified by `form` for types where stem encodes the form.

$(SIGNATURES)
"""
function generatefromstemform(lex::LexemeUrn, frm::T, td::Tabulae.Dataset) where {T <: LatinMorphologicalForm}
end


"""Generate vector of possible strings for a form of `lex` identified by `form` for types where stem encodes the form.

$(SIGNATURES)
"""
function generatefromruleform(lex::LexemeUrn, frm::T, td::Tabulae.Dataset) where {T <: LatinMorphologicalForm}
end

"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
#function generate(lex::LexemeUrn, frm::T,   td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
function generate(lex::LexemeUrn, frm::T,   td::Tabulae.Dataset) where {T <: LatinMorphologicalForm}
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
                            tokenid = "A"
                            @debug("Matching, created $(token) for infl type $(inflectionclass(rule)) and form $(latinForm(rule))")
                            push!(generated, Analysis(token, lexeme(stem),Tabulae.formurn(frm), urn(stem),urn(rule), token, tokenid))
                        end
                    end

                else   
                    @info("Build from rule")
                    classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && latinForm(r) == frm, rules)
               
                    
                end
                #=
               

                classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && latinForm(r) == frm, rules)
                @info("Filtered rules and got $(length(classrules)) for $(inflectionclass(stem)) == $(inflectionclass(r))")
                for rule in classrules
                    form = isnothing(stemform) ? latinForm(rule) : stemform
                    token = string(stemvalue(stem), ending(rule))
                    tokenid = "A"
                    @debug("Matching, created $(token) for infl type $(inflectionclass(rule)) and form $(latinForm(rule))")
                    push!(generated, Analysis(token, lexeme(stem),Tabulae.formurn(form), urn(stem),urn(rule), token, tokenid))
                end  
                =#  
            end
            

        end
        
        
        generated
    end
    #elseif buildfromstem(stem)
    #    generatefromstemform(lex,frm,td)

    #else
    #    generatefromruleform(lex,frm,td)
    


        #=
        @info("generate $(lex) in form $(frm) from a dataset")
        generated = Analysis[]
        stems = stemsarray(td)
        stemlist = filter(s -> lexeme(s) == lex, stems)
        if isempty(stemlist)
            @warn("No stems matched lexeme $(lex)")
            
        else
            
            rules = rulesarray(td)
            for stem in stemlist
                stemform = buildfromstem(stem) ? latinForm(stem) : nothing





                classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && latinForm(r) == frm, rules)
                @info("Filtered rules and got $(length(classrules)) for $(inflectionclass(stem)) == $(inflectionclass(r))")
                for rule in classrules
                    form = isnothing(stemform) ? latinForm(rule) : stemform
                    token = string(stemvalue(stem), ending(rule))
                    tokenid = "A"
                    @debug("Matching, created $(token) for infl type $(inflectionclass(rule)) and form $(latinForm(rule))")
                    push!(generated, Analysis(token, lexeme(stem),Tabulae.formurn(form), urn(stem),urn(rule), token, tokenid))
                end    
            end
        end
        generated
        =#
end 


function generate(lex::LexemeUrn, frmUrn::FormUrn,  td::Tabulae.Dataset)#::Vector{Analysis} 
    @info("generate $(lex) from form urn $(frmUrn) from a dataset")
    #generate(lex, latinForm(frmUrn), td)
    "Figure out rule or stem for lex/form/ds combo?"
end


"""Generate vector of possible strings the combination of `rule` and `stem`.

$(SIGNATURES)
"""
function generate(stem::TStem, rule::TRule, td::Tabulae.Dataset)::Vector{Analysis} where {TRule <: TabulaeRule, TStem <: TabulaeStem}
    @info("generate from stem/rule $(stem) / $(rule) from a dataset")
    @info("Figure out whether using stem or rule for latinForm")
    
    @info("")
    if buildfromrule(rule)
        generate(lexeme(stem), latinForm(rule), td)
    else
        generate(lexeme(stem), latinForm(stem), td)
    end
end 
