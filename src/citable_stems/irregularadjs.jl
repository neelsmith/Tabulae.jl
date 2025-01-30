"A record for a single irregular verb stem."
struct TabulaeIrregularAdjective <: TabulaeIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    inflectionclass::AbstractString
end



"""Override Base.show for irregular infinitive stem type.
$(SIGNATURES)
"""
function show(io::IO, adj::TabulaeIrregularAdjective)
    print(io, label(adj))
end

"""Human-readable label for an `TabulaeIrregularAdverb`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adj::TabulaeIrregularAdjective)
    string("Irregular adjective form ", adj.form)
end
