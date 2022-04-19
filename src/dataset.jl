"""
A Tabulae dataset in a local file system.  

# Members

- `dirs` is a list of full paths to the root directory of one or more datasets.  
Their subdirectory organization must follow Tabulae' specifications.
- `orthography` is an implementation of the `Orthography` interface
"""
struct Dataset
    dirs
    orthography::LatinOrthographicSystem
    function Dataset(dirlist; ortho::T = latin23()) where {T <: LatinOrthographicSystem}
        if isempty(rulesarray(dirlist))
            throw(ArgumentError("No inflectional rules found."))

        elseif isempty(stemsarray(dirlist))
            throw(ArgumentError("No lexicon of stems found."))
        
        # elseif ## if no urn registry ...
        # need to enforce referential integrity of data
        # with registry
        
        else
            try
                
            catch
            end
            new(dirlist, ortho)
        end   
    end
end

"""Create a `Tabulae.Dataset` from a single data source.

$(SIGNATURES)

# Arguments

- `dir` Full path to a directory with Tabulae data.
- `ortho` An instance of a `Orthography`.
"""
function dataset(dir::AbstractString; ortho::T = latin23()) where {T <: LatinOrthographicSystem}
    Tabulae.Dataset([dir]; ortho = ortho)
end



"""Create a `Tabulae.Dataset` from one or more data sources.

$(SIGNATURES)

# Arguments

- `srclist` List of full paths to a directory with Tabulae data.
- `ortho` An instance of a `LatinOrthographicSystem`; defaults to `Latin23`.
"""
function dataset(srclist::Array; ortho::T = latin23()) where {T <: LatinOrthographicSystem}
    Tabulae.Dataset(srclist; ortho =  ortho)
end


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
        for dirname in rulesdirs 
            #@info("PROCESSING DIR ", dirname)
            dir = joinpath(datasrc, "rules-tables", dirname)
            cexfiles = glob("*.cex", dir)

            delimitedreader = (iodict[dirname])
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
        #"verbs-simplex" => VerbIO("verb")
        ]
    )
    stemdirs = [
        #"adjectives",
        "nouns",
        #"pronouns",
        #"uninflected",
        #"verbs-simplex",
        
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




