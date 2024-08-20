
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
    finalarr = []
    iodict = Dict(
        [
        #"adjectives" => AdjectiveIO("adjective"),
        "nouns" => TabulaeNounStem,
        "pronouns" => TabulaePronounStem,
        #"uninflected" => UninflectedIO("uninflected"),
        "verbs-simplex" => TabulaeVerbStem,
        "verbs-compound" => TabulaeCompoundVerbStem,
        ]
    )
    stemdirs = [
        #"adjectives",
        "nouns",
        "pronouns",
        #"uninflected",
        "verbs-simplex",
        #"verbs-compound",
        
    ]

    #stemsarr = Union{TabulaeStem, TabulaeIrregularStem}[]
    stemsarr = Stem[]
    #stemsarr = Vector{<: Stem}()
    for datasrc in dirlist
        for dirname in stemdirs 
            @debug("Read stems from dir ", dirname)
            dir = joinpath(datasrc, "stems-tables", dirname)
            @debug("dir = ", dir)
            cexfiles = glob("*.cex", dir)
            delimitedtype = iodict[dirname]
            for f in cexfiles
                raw = readlines(f)
                @debug("reading steam from raw ", raw)
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

    # Add compounds of regular verbs:
    for datasrc in dirlist
        dirname = "verbs-compound"
        dir = joinpath(datasrc, "stems-tables", dirname)
        delimitedtype = iodict[dirname]

        cexfiles = glob("*.cex", dir)
        for f in cexfiles
            raw = readlines(f)
            # Trim lines first:
            lines = filter(s -> ! isempty(s), raw)
            for ln in lines[2:end]
                stem = fromcex(ln, delimitedtype)
                for newstem in stems(stem, stemsarr)
                    @debug("Add stem $(newstem)")
                    push!(stemsarr,newstem)
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
        # "nouns" => "irregularnoun",
        # "adjectives" => "irregularadjective",
        "verbs" => "irregularfiniteverb",
        # "infinitives" => "irregularinfinitive",
    )

  
    @debug("Getting irregular stems for $dirlist")
    irregulars = Union{TabulaeStem, TabulaeIrregularStem}[]
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
                    push!(irregulars,stem)
                    
                end
            end
        end
    end


    # Add compounds of irregular verbs:
    for datasrc in dirlist
        dirname = "verbs-compound"
        dir = joinpath(datasrc, "stems-tables", dirname)
        delimitedtype = iodict[dirname]

        cexfiles = glob("*.cex", dir)
        for f in cexfiles
            raw = readlines(f)
            # Trim lines first:
            lines = filter(s -> ! isempty(s), raw)
            for ln in lines[2:end]
                stem = fromcex(ln, delimitedtype)
                @debug("Handle stem $(stem)")
                for newstem in irregularstems(stem, irregulars)
                    @debug("Add stem $(newstem)")
                    push!(stemsarr,newstem)
                end
            end
        end
    end


   vcat(irregulars, stemsarr) |> unique
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