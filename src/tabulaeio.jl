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


struct IrregularReaderIO <: TabulaeIO
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



"""
TabulaeIO type for reading and writing data for participle rules only.

$(SIGNATURES)

"""
struct ParticipleIO <: TabulaeIO
    label::AbstractString
end

"""
Required function for TabulaeIO subtypes.

$(SIGNATURES)
"""
function readrulerow(io::T, s::AbstractString; delimiter = "|") where {T <: TabulaeIO}
   # DomainError("readrulerow function has not been implemented for type $(typeof(io))")
   parts = split(s, delimiter)
    if length(parts) < 2
        msg = "Invalid syntax for irregular rule: too few components in $(delimited)"
        throw(ArgumentError(msg))
    else
        ruleid = RuleUrn(parts[1])
        inflectionaltype = parts[2]
        TabulaeIrregularRule(ruleid, inflectionaltype)
    end
end



"""
Required function for TabulaeIO subtypes.

$(SIGNATURES)
"""
function readstremrow(io::T, s::AbstractString) where {T <: TabulaeIO}
    DomainError("readstremrow function has not been implemented for type $(typeof(io))")
end