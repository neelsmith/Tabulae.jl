#=
What we need to know:

- string id
- stem class it applies to
- rules classes it applies to
- descriptoin
- paradigm lexeme
=#

"""Object for documenting all inflection classes."""
struct TabulaeInflectionClass
    id::AbstractString
    description::AbstractString
    paradigms::Vector{LexemeUrn}
    pos::PartOfSpeech.T
end



"""Override Base.show for TabulaeInflectionClass.
$(SIGNATURES)
"""
function show(io::IO, iclass::TabulaeInflectionClass)
    print(io, label(iclass))
end

"""Description for a TabulaeInflectionClass.
$(SIGNATURES)
"""
function label(iclass::TabulaeInflectionClass)
    string(iclass.description)
end

function pos(iclass::TabulaeInflectionClass)
    label(iclass.pos)
end


function paradigms(iclass::TabulaeInflectionClass)
    iclass.paradigms
end

function id(iclass::TabulaeInflectionClass)
    iclass.id
end