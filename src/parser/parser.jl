"""Abstract type of a morphological parser."""
abstract type TabulaeParser <: CitableParser end

"""Parse a single token `s` using parser `p`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, p::T) where {T <: TabulaeParser}
    @warn("Function parsetoken is not implemented for type $(typeof(p))")::Vector{Analysis}
    []
end