"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
function generate(lex::LexemeUrn, nounform::LMFNoun,   td::Tabulae.Dataset)::Vector{Analysis}
    generated = Analysis[]   
    targetgender = lmpGender(nounform) 
    stems = stemsarray(td)
    stemlist = filter(s -> lexemeurn(s) == lex && s isa TabulaeNounStem, stems)

    if isempty(stemlist)
        @warn("No stems matched lexeme $(lex)")   

    else
        rules = rulesarray(td)
        for stem in stemlist
            stemgender = lmpGender(stem)
            if stemgender == targetgender
                classrules = filter(r -> inflectionType(r) == inflectionType(stem) && lmForm(r) == nounform, rules)
                for rule in classrules
                    if lmForm(rule) isa LMFNoun
                        rulegender = lmpGender(lmForm(rule))
                        if targetgender == rulegender
                            token = string(stemvalue(stem), ending(rule))
                            @debug("Matching, created $(token) for infl type $(inflectionType(rule)) and form $(lmForm(rule))")
                            push!(generated, Analysis(token, lexemeurn(stem),Tabulae.formurn(lmForm(rule)), urn(stem),urn(rule)))
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

    generated = Analysis[]
    stems = stemsarray(td)
    stemlist = filter(s -> lexemeurn(s) == lex, stems)
    if isempty(stemlist)
        @warn("No stems matched lexeme $(lex)")
        
    else
        
        rules = rulesarray(td)
        for stem in stemlist
            classrules = filter(r -> inflectionType(r) == inflectionType(stem) && lmForm(r) == frm, rules)
            for rule in classrules
                token = string(stemvalue(stem), ending(rule))
                @debug("Matching, created $(token) for infl type $(inflectionType(rule)) and form $(lmForm(rule))")
                push!(generated, Analysis(token, lexemeurn(stem),Tabulae.formurn(lmForm(rule)), urn(stem),urn(rule)))
            end
            
        end
    end
    generated
end 


function generate(lex::LexemeUrn, frmUrn::FormUrn,  td::Tabulae.Dataset)::Vector{Analysis} 
    generate(lex, latinForm(frmUrn), td)
end


"""Generate vector of possible strings the combination of `rule` and `stem`.

$(SIGNATURES)
"""
function generate(stem::TStem, rule::TRule, td::Tabulae.Dataset)::Vector{Analysis} where {TRule <: TabulaeRule, TStem <: TabulaeStem}
    generate(lmForm(rule), lexemeurn(stem), td)
end 
