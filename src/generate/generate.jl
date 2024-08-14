"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
function generate(lex::LexemeUrn, nounform::LMFNoun,   td::Tabulae.Dataset)::Vector{Analysis}
    @debug("generate noun $(lex) from form urn $(frmUrn) from a dataset")
    generated = Analysis[]   
    targetgender = lmpGender(nounform) 
    stems = stemsarray(td)
    stemlist = filter(s -> lexeme(s) == lex && s isa TabulaeNounStem, stems)

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

    generated
end

"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
function generate(lex::LexemeUrn, frm::T,   td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
    @debug("generate $(lex) in form $(frm) from a dataset")
    generated = Analysis[]
    stems = stemsarray(td)
    stemlist = filter(s -> lexeme(s) == lex, stems)
    if isempty(stemlist)
        @warn("No stems matched lexeme $(lex)")
        
    else
        
        rules = rulesarray(td)
        for stem in stemlist
            classrules = filter(r -> inflectionclass(r) == inflectionclass(stem) && latinForm(r) == frm, rules)
            @debug("Filtered rules and got $(length(classrules)) for $(inflectionclass(stem))")
            for rule in classrules
                token = string(stemvalue(stem), ending(rule))
                tokenid = "A"
                @debug("Matching, created $(token) for infl type $(inflectionclass(rule)) and form $(latinForm(rule))")
                push!(generated, Analysis(token, lexeme(stem),Tabulae.formurn(latinForm(rule)), urn(stem),urn(rule), token, tokenid))
            end
            
        end
    end
    generated
end 


function generate(lex::LexemeUrn, frmUrn::FormUrn,  td::Tabulae.Dataset)::Vector{Analysis} 
    @info("generate $(lex) from form urn $(frmUrn) from a dataset")
    generate(lex, latinForm(frmUrn), td)
end


"""Generate vector of possible strings the combination of `rule` and `stem`.

$(SIGNATURES)
"""
function generate(stem::TStem, rule::TRule, td::Tabulae.Dataset)::Vector{Analysis} where {TRule <: TabulaeRule, TStem <: TabulaeStem}
    @debug("generate from stem/rule $(stem) / $(rule) from a dataset")
    generate(lexeme(stem),latinForm(rule),  td)
end 
