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
    print(io, string(iclass.id, ": ", label(iclass)))
end

"""Description for a TabulaeInflectionClass.
$(SIGNATURES)
"""
function label(iclass::TabulaeInflectionClass)
    string(iclass.description)
end

"""Part of speech label for a TabulaeInflectionClass.
$(SIGNATURES)
"""
function pos(iclass::TabulaeInflectionClass)
    label(iclass.pos)
end


"""List of paradigm words for a TabulaeInflectionClass.
$(SIGNATURES)
"""
function paradigms(iclass::TabulaeInflectionClass)
    iclass.paradigms
end

"""ID string for a TabulaeInflectionClass.
$(SIGNATURES)
"""
function id(iclass::TabulaeInflectionClass)
    iclass.id
end