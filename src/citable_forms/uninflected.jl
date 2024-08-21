"""Uninflected forms belong to a part of speech."""
struct LMFUninflected <: LatinMorphologicalForm
    pos::LMPUninflectedType
end


"""Compose a digital code string for an uninflected form.
$(SIGNATURES)
"""
function code(uninfl::LMFUninflected)
      # PosPNTMVGCDCat
     string( UNINFLECTED,"00000000", code(uninfl.inflectionclass))
end