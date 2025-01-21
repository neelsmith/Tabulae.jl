
"Inflectional rule for a noun rule."
struct TabulaeAdjectiveRule <: TabulaeRule
    ruleid::RuleUrn
    inflectionclass::AbstractString
    ending::AbstractString
    adjgender::LMPGender
    adjcase::LMPCase
    adjnumber::LMPNumber
end