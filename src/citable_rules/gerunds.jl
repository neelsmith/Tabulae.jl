
"Inflectional rule for a gerund form."
struct TabulaeGerundRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    gcase::LMPCase
end