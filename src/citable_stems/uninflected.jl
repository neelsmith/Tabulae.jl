"A record for a single noun stem."
struct TabulaeUninflectedStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    inflectionclass::AbstractString 
end