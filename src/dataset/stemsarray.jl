
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
        "nouns" => TabulaeNounStem,
        #"pronouns" => PronounIO("pronoun"),
        #"uninflected" => UninflectedIO("uninflected"),
        "verbs-simplex" => TabulaeVerbStem
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
            delimitedtype = iodict[dirname]
            for f in cexfiles
                raw = readlines(f)
                #@info("reading steam from raw ", raw)
                # Trim lines first:
                lines = filter(s -> ! isempty(s), raw)
                for ln in lines[2:end]
                    #stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    stem = fromcex(ln, delimitedtype)
                    push!(stemsarr,stem)
                end
            end
        end
    end


    irregiodict = Dict(
        [
        #"uninflected" => UninflectedIO("uninflected"),
        #"nouns" => IrregularNounIO("noun"),
        "verbs" => TabulaeIrregularVerb,
        #"infinitives" => IrregularInfinitiveIO("infinitive"),
        #"adjectives" => IrregularAdjectiveIO("adjectives")
        ]
    )
    irregstemdirs = [
        #"nouns",
        "verbs",
        #"infinitives",
        #"adjectives"
    ]
    irreginfltypes = Dict(
        "verbs" => "irregularfiniteverb"
    )
#=  
irreginfl.irregular1|irregularnoun
irreginfl.irregular2|irregularfiniteverb
irreginfl.irregular3|irregularinfinitive
irreginfl.irregular4|irregularadjective
irreginfl.irregular5|irregularparticiple
        =#
  
    #@info("Getting irregular stems for $dirlist")
    for datasrc in dirlist
        for dirname in irregstemdirs 
            @debug("Collecting irregular stems from dir $(dirname) in src $(datasrc).")
            dir = joinpath(datasrc, "irregular-stems", dirname)
            cexfiles = glob("*.cex", dir)
            if ! isempty(cexfiles)
                @debug("Found these files for irregulars: $(cexfiles)")
            end
            delimitedtype = irregiodict[dirname]
            infltype = irreginfltypes[dirname]
            for f in cexfiles
                raw = readlines(f)
                lines = filter(s -> ! isempty(s), raw)
                for ln in lines[2:end]
                    #stem = readstemrow(delimitedreader, lines[i]; delimiter = delimiter)
                    data = join([ln,infltype], delimiter)
                    stem = fromcex(data, delimitedtype)
                    @debug("row $(ln) yielded $(stem)")
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