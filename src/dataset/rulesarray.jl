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
        "nouns" => NounIO("noun"),
        "finiteverbs" => VerbIO("verb"),
        "infinitives" => InfinitiveIO("infinitives")
        ]
    )
    rulesdirs = [
        "nouns",
      
        "finiteverbs",
        "infinitives",
        
    ]
    rulesarr = Rule[]

    for datasrc in dirlist
        for dir in rulesdirs 
            #@info("PROCESSING DIR ", dirname)
            fullpath = joinpath(datasrc, "rules-tables", dir)
            cexfiles = glob("*.cex", fullpath)

            delimitedreader = (iodict[dir])
            for f in cexfiles
                #@info("PROCESS FILE ", f)
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    #@info("LINE IS ", lines[i])
                    rule = readrulerow(delimitedreader, lines[i], delimiter = delimiter)
                    push!(rulesarr,rule)
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