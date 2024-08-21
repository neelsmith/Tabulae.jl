"Inflectional rule for a pronoun rule."
struct TabulaeUninflectedRule <: TabulaeRule
    ruleid::RuleUrn
    uninflectedtype::LMPUninflectedType
end

function inflectionclass(r::TabulaeUninflectedRule)
    string(r.uninflectedtype)
end

function ending(r::TabulaeUninflectedRule)
    ""
end
