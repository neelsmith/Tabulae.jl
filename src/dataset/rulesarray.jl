"""Read all rules data from a list of directories into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(td::Tabulae.Dataset; delimiter = "|")
    rulesarray(td.dirs, delimiter = delimiter)
end

"""Read all rules data from a `Tabulae.Dataset` into an array of `Rule`s.

$(SIGNATURES)
"""
function rulesarray(dirlist; delimiter = "|")
    iodict = Dict(
        [
        "nouns" => TabulaeNounRule,
        "verbs" => TabulaeFiniteVerbRule,
        "infinitives" => TabulaeInfinitiveRule,
        "participles" => TabulaeParticipleRule,
        "irregulars" => TabulaeIrregularRule,
        "pronouns" => TabulaePronounRule
        ]
    )
    rulesdirs = [
        "nouns",
        "verbs",
        "infinitives",
        "participles",
        "irregulars", 
        "pronouns"
        
    ]
    rulesarr = Rule[]

    for datasrc in dirlist
        for dir in rulesdirs 
            @debug("PROCESSING DIR ", dir)
            fullpath = joinpath(datasrc, "rules-tables", dir)
            @debug("full path ", fullpath)
            cexfiles = glob("*.cex", fullpath)

            delimitedtype = (iodict[dir])
            for f in cexfiles
                @debug("PROCESS FILE ", f)
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for ln in lines[2:end]
                    if delimitedtype isa TabulaeIrregularRule
                        @debug("LINE IS ", ln)
                    end
                    #rule = readrulerow(delimitedreader, lines[i], delimiter = delimiter)
                    @debug("Try to read this line as $(delimitedtype) : $(ln)")
                    rule = fromcex(ln, delimitedtype)
                    if rule isa DomainError
                        @warn("Erred on $(ln)")
                        @warn(rule)
                    else
                        push!(rulesarr,rule)
                    end
                end
            end
        end
    end

    unique(rulesarr)
end

"""
Find all rules in `rules` that have a type matching one of the types in `typelist`.
$(SIGNATURES)
"""
function rulesfortypes(rules::Vector{Rule}, typelist )::Vector{Rule}
    keepers = Rule[]
    for infl in typelist
        matches = filter(r -> r.inflectionclass == infl, rules)
        append!(keepers, matches)
    end
    keepers 
end

"""
Find all rules in `rules` that have a type matching `infltype`.
$(SIGNATURES)
"""
function rulesfortype(rules::Vector{Rule}, infltype )::Vector{Rule}
    filter(r -> r.inflectionclass == infltype, rules)
end

"""
Find all rules in `td` that have a type matching one of the types in `typelist`.
$(SIGNATURES)
"""
function rulesfortypes(td::Tabulae.Dataset, typelist )::Vector{Rule}
    rulesfortypes(rulesarray(td), typelist)
end

"""
Find all rules in `td` that have a type matching `infltype`.
$(SIGNATURES)
"""
function rulesfortype(td::Tabulae.Dataset, infltype)::Vector{Rule}
    filter(r -> r.inflectionclass == infltype, rulesarray(td))
end