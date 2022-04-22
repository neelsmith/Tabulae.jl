
"""Read all stem data from a list of directories into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(kd::Tabulae.Dataset)
    stemsarray(kd.dirs)
end


"""Read all stem data from a `Tabulae.Dataset` into an array of `Stem`s.

$(SIGNATURES)
"""
function stemsarray(dirlist; delimiter = "|")
    #@info("Getting regular stems for $dirlist")
    iodict = Dict(
        [
        #"adjectives" => AdjectiveIO("adjective"),
        "nouns" => NounIO("noun"),
        #"pronouns" => PronounIO("pronoun"),
        #"uninflected" => UninflectedIO("uninflected"),
        "verbs-simplex" => VerbIO("verb")
        ]
    )
    stemdirs = [
        #"adjectives",
        "nouns",
        #"pronouns",
        #"uninflected",
        "verbs-simplex",
        
    ]

    stemsarr = Stem[]
    for datasrc in dirlist
        for dirname in stemdirs 
            #@info("Read stems from dir ", dirname)
            dir = joinpath(datasrc, "stems-tables", dirname)
            #@info("dir = ", dir)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (iodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                #@info("reading steam from raw ", raw)
                # Trim lines first:
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    push!(stemsarr,stem)
                end
            end
        end
    end


    irregiodict = Dict(
        [
        #"uninflected" => UninflectedIO("uninflected"),
        "nouns" => IrregularNounIO("noun"),
        #"verbs" => IrregularVerbIO("finite verb"),
        #"infinitives" => IrregularInfinitiveIO("infinitive"),
        #"adjectives" => IrregularAdjectiveIO("adjectives")
        ]
    )
    irregstemdirs = [
        "nouns",
        #"verbs",
        #"infinitives",
        #"adjectives"
    ]
    #@info("Getting irregular stems for $dirlist")
    for datasrc in dirlist
        for dirname in irregstemdirs 
            dir = joinpath(datasrc, "irregular-stems", dirname)
            cexfiles = glob("*.cex", dir)
            delimitedreader = (irregiodict[dirname])
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for i in 2:length(lines)
                    stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    push!(stemsarr,stem)
                end
            end
        end
    end
    unique(stemsarr)
end



"""
Find all stems in `stems` for lexeme `lex`.
$(SIGNATURES)
"""
function stemsforlexeme(stems::Vector{Stem}, lex::LexemeUrn)
    filter(s -> lexeme(s) == lex, stems)
end


"""
Find all stems in `stems` for lexeme `lex`.
$(SIGNATURES)
"""
function stemsforlexeme(td::Tabulae.Dataset, lex::LexemeUrn)
    filter(s -> lexeme(s) == lex, stemsarray(td))
end