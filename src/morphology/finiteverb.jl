"""Finite verbs have person, number, tense, mood and voice."""
struct LatinFiniteVerb <: LatinMorphologicalForm
    vperson::Int64
    personlabel::AbstractString    
    vnumber::Int64
    numberlabel::AbstractString    
    vtense::Int64
    tenselabel::AbstractString   
    vmood::Int64
    moodlabel::AbstractString    
    vvoice::Int64
    voicelabel::AbstractString 
end


"""Parse a string of SFST output into a `LatinFiniteVerb`

$(SIGNATURES)
"""
function verbfromfst(s)
end

#abduxit
#<u>latcommon.compoundn55_0</u><u>ls.n55</u><#>abdux<verb><pftact><div><pftact><verb>it<3rd><sg><pft><indic><act><u>latcommon.pftact_pft3</u>
