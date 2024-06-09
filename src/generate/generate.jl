"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
function generate(lex::LexemeUrn, frm::T,   td::Tabulae.Dataset)::Vector{Analysis} where {T <: LatinMorphologicalForm}
    generated = Analysis[]
    stems = stemsarray(td)
    stemlist = filter(s -> lexeme(s) == lex, stems)
    if isempty(stemlist)
        @warn("No stems matched lexeme $(lex)")
        
    else
        rules = rulesarray(td)
        
        for stem in stemlist
            classrules = filter(r -> inflectionType(r) == inflectionType(stem) && lmForm(r) == frm, rules)
            for rule in classrules
                token = string(stemvalue(stem), ending(rule))
                push!(generated, Analysis(token, lexeme(stem),Tabulae.formurn(lmForm(rule)), urn(stem),urn(rule)))
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
    generate(lmForm(rule), lexeme(stem), td)
end 


