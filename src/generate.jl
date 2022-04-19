
#=
"""From lists for stems and rules for regular nouns, 
form a list of all forms 
$(SIGNATURES)

# Arguments

- `form` Gender, case, number identifier to match
- `stem` Stem entries for a single noun lexeme.
- `rules` Noun rules for this dataset.
- `ortho` Orthography
"""
function selectregularnoun(form, stem, rules, ortho::GreekOrthography)::Vector{AbstractString}
    # 1. Find rules belonging to same inflection class as stem.
    # rule.inflectionclass ==   stem.inflectionclass
    classrules = filter(r -> r.inflectionclass == stem.inflectionclass, rules)
    @debug("Stems of class $(stem.inflectionclass) : ", length(classrules))
    
    # 2. Must have some morph form as analysis.
    #
    # NEED TO GET A GMF from a Rule (here a noun rule)
    #abbrs = map(r -> formurn(r), classrules)
    sameform = filter(r -> formurn(r) == form, classrules)

    # 3. combine stem and ending strings
    if isempty(sameform)
        @warn("No rules found for form $(form) and inflection class $(stem.inflectionclass)")
        nothing
    end
    raw = map(r -> stem.form * r.ending, sameform)
    
    # 4. determine accent pattern from stem.accentpersistence
    # and addaccent to resulting word.   
    msgs = []
    for r in raw
        if countaccents(r, ortho) == 1
            push!(msgs, stripmetachars(r))
        else
            if stem.accentpersistence == "recessive"
                clean = stripmetachars(accentword(r, :RECESSIVE, ortho))
                push!(msgs, clean)

            elseif stem.accentpersistence == "stemaccented"
                clean = stripmetachars( accentword(r, :PENULT, ortho))
                push!(msgs,clean)

            else 
                # place correct accent on ultima:
                @debug("ACC.ULTIMA:", r)
                caselabel = label(greekForm(form).ncase)   
                if caselabel == "genitive" || caselabel == "dative"
                    push!(msgs,  stripmetachars(accentultima(r, :CIRCUMFLEX, ortho)))
                    
                else
                    push!(msgs, stripmetachars(accentultima(r, :ACUTE, ortho)))
                    
                end
            
            end
        end
    end  
    msgs
end
=#


#=
# Generate noun forms by:
# combine stem.from  and rule.ending.
# determine accent pattern from stem.accentpersistence
# addaccent to resulting word.
#

"""Generate vector of possible strings for correctly accented form of a noun form identified by lexeme.

$(SIGNATURES)
"""
function generatenoun(form::FormUrn,lex::LexemeUrn,  kd::Kanones.Dataset)::Vector{AbstractString}
    
    # See if inflectionclass == "irregularnoun"
    # then find one matching form
    #
    stems = stemsarray(kd)
    irregnounstems = filter(s -> typeof(s) == IrregularNounStem, stems)
    irregnounmatches = filter(s -> s.lexid == lex, irregnounstems)
    if isempty(irregnounmatches)
        nounstems = filter(s -> typeof(s) == NounStem, stems)
        stemmatches = filter(s -> s.lexid == lex, nounstems)
        if isempty(stemmatches)
            @warn("No stems matched lexeme $(lex)")
            nothing
        else
            rules = rulesarray(kd)
            nounrules = filter(r -> typeof(r) == NounRule, rules)

            regulars = []
            for stem in stemmatches
                push!(regulars, selectregularnoun(form, stem, nounrules, kd.orthography))
            end
            regulars  |> Iterators.flatten |> collect
            #@info string("generatenoun: matching stems: ", length(stemmatches))
        end
    else
        #
        selectirregnoun(irregnounmatches, form)
    end
end
=#

"""Generate vector of possible strings for a form identified by `analysis`.

$(SIGNATURES)
"""
function generatenoun(analysis::Analysis, td::Tabulae.Dataset)::Vector{AbstractString}
    generate(analysis.form, analysis.lexeme,  td)
end

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
            #push!(applicable, classrules)
        end
    end
    generated
end 