"""Uninflected forms belong to a part of speech."""
struct LMFUninflected <: LatinMorphologicalForm
    pos::LMPUninflectedType
end
