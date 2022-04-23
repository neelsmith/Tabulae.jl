"""
A Tabulae dataset in a local file system.  

# Members

- `dirs` is a list of full paths to the root directory of one or more datasets.  
Their subdirectory organization must follow Tabulae's specifications.
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




function ruleclasses(td::Tabulae.Dataset)
    "IMPLEMENT THIS"
end

function stemclasses(td::Tabulae.Dataset)
    "IMPLEMENT THIS"
end