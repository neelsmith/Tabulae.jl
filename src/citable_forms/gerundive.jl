"""Gerundives have gender, case and number."""
struct LMFGerundive <: LatinMorphologicalForm
    ggender::LMPGender
    gcase::LMPCase
    gnumber::LMPNumber
end