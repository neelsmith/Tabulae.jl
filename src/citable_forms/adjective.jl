"""Adjectives have gender, case, number and degree."""
struct LMFAdjective <: LatinMorphologicalForm
    agender::LMPGender
    acase::LMPCase
    anumber::LMPNumber
    adegree::LMPDegree
end

function lmfAdjective()
end