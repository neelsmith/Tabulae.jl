"""
Implementations of this type can read delimited text and write SFST.

$(SIGNATURES)
"""
abstract type TabulaeIO end

"""
TabulaeIO type for reading and writing data for regular noun forms.

$(SIGNATURES)
"""
struct NounIO <: TabulaeIO
    label::AbstractString
end

"""
TabulaeIO type for reading and writing data for irregular noun forms.

$(SIGNATURES)
"""
struct IrregularNounIO <: TabulaeIO
    label::AbstractString
end

"""
TabulaeIO type for reading and writing data for finite verb form.

$(SIGNATURES)
"""    
struct VerbIO <: TabulaeIO
    label::AbstractString
end

"""
TabulaeIO type for reading and writing data for irregular finite verb forms.

$(SIGNATURES)
"""
struct IrregularVerbIO <: TabulaeIO
    label::AbstractString
end

"""
TabulaeIO type for reading and writing data for infinitive rules only.

$(SIGNATURES)

"""
struct InfinitiveIO <: TabulaeIO
    label::AbstractString
end

"""
TabulaeIO type for reading and writing data for irregular infinitive forms.

$(SIGNATURES)

"""
struct IrregularInfinitiveIO <: TabulaeIO
    label::AbstractString
end

