"""
A Tabulae dataset in a local file system.  

**Members**:

- `dirs` is a list of full paths to the root directory of one or more datasets.  
Their subdirectory organization must follow Tabulae's specifications.
- `orthography` is an implementation of the `Orthography` interface
"""
struct Dataset
    dirs
    orthography::LatinOrthographicSystem
    function Dataset(dirlist; ortho::T = latin25()) where {T <: LatinOrthographicSystem}
        if isempty(rulesarray(dirlist))
            throw(ArgumentError("No inflectional rules found in dirlist $(dirlist)."))

        elseif isempty(stemsarray(dirlist))
            throw(ArgumentError("No lexicon of stems found in dirlist $(dirlist)."))
        
        # elseif ## if no urn registry ...
        # need to enforce referential integrity of data
        # with registry
        
        else
            
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

"""List inflectional types appearing in dataset's rulesets.
$(SIGNATURES)
"""
function ruleclasses(td::Tabulae.Dataset)
    map(v -> inflectionclass(v), rulesarray(td)) |> unique |> sort
end

"""List inflectional types appearing in dataset's stem lists.
$(SIGNATURES)
"""
function stemclasses(td::Tabulae.Dataset)
    map(v -> inflectionclass(v), stemsarray(td)) |> unique |> sort
end

function nounstems(td::Tabulae.Dataset)
    filter(s -> s isa TabulaeNounStem, stemsarray(td))
end

function nounstemclasses(td::Tabulae.Dataset)
    map(s -> inflectionclass(s), nounstems(td)) |> unique |> sort
end



function nounrules(td::Tabulae.Dataset)
    filter(s -> s isa TabulaeNounRule, rulesarray(td))
end

function nounruleclasses(td::Tabulae.Dataset)
    map(s -> inflectionclass(s), nounrules(td)) |> unique |> sort
end



function verbstems(td::Tabulae.Dataset)
    filter(s -> s isa TabulaeVerbStem, stemsarray(td))
end

function verbstemclasses(td::Tabulae.Dataset)
    map(s -> inflectionclass(s), verbstems(td)) |> unique |> sort
end

