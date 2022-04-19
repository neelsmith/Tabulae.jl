"""Generate vector of possible strings for a form of `lex` identified by `form`.

$(SIGNATURES)
"""
function generate(frm::T, lex::LexemeUrn,  td::Tabulae.Dataset) where {T <: LatinMorphologicalForm}
    generated = []
    stems = stemsarray(td)
    stemlist = filter(s -> lexeme(s) == lex, stems)
    if isempty(stemlist)
        @warn("No stems matched lexeme $(lex)")
        
    else
        rules = rulesarray(td)
        
        for stem in stemlist
            classrules = filter(r -> inflectionType(r) == inflectionType(stem) && lmForm(r) == frm, rules)
            for r in classrules
                push!(generated, string(stemvalue(stem), ending(r)))
            end
        end
    end
    generated
end 