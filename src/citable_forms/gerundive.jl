"""Gerundives have gender, case and number."""
struct LMFGerundive <: LatinMorphologicalForm
    ggender::LMPGender
    gcase::LMPCase
    gnumber::LMPNumber
end



"""Override Base.show for a gerundive form.
$(SIGNATURES)
"""
function show(io::IO, g::LMFGerundive)
    print(io, label(g))
end

"""Override Base.== for a gerundive form.
$(SIGNATURES)
"""
function ==(g1::LMFGerundive, g2::LMFGerundive)
    lmpGender(g1)  == lmpGender(g2) &&
    lmpCase(g1)  == lmpCase(g2) &&
    lmpNumber(g1)  == lmpNumber(g2) 
end


CitableTrait(::Type{LMFGerundive}) = CitableByCite2Urn()
"""Gerundive forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFGerundive})
    CitableByCite2Urn()
end

"""Compose a label for a gerundive form.
$(SIGNATURES)
"""
function label(g::LMFGerundive)    
    join([ label(g.ggender), label(g.gcase), label(g.gnumber)], " ")
end


"""Construct a `LMFGerundive` from string values.
$(SIGNATURES)
"""
function lmfGerundive(g::AbstractString, c::AbstractString, n::AbstractString)
    LMFGerundive(
        gendercodedict[g] |> LMPGender,
        casecodedict[c] |> LMPCase,
        numbercodedict[n] |> LMPNumber
    )
end


"""Create a `LMFGerundive` from a string value with a series of digits.

$(SIGNATURES)
"""
function lmfGerundive(code::AbstractString)
    morphchars = split(code, "")
    gender = lmpGender(parse(Int64, morphchars[7]))
    case = lmpCase(parse(Int64, morphchars[8]))
    number = lmpNumber(parse(Int64,morphchars[3]))
    
    LMFGerundive(gender, case, number)
end


"""Create a `LMFNoun` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfGerundive(urn::Cite2Urn)
    lmfGerundive(objectcomponent(urn))
end

"""Create a `GMFNoun` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfGerundive(f::FormUrn)
    lmfGerundive(f.objectid)
end

"""Sequence of digits encoding a gerundive form.
$(SIGNATURES)
"""
function code(g::LMFGerundive)::String
     string(GERUNDIVE,"0",code(g.gnumber),"000",code(g.ggender),code(g.gcase),"00")
end


"""Find gender of a gerundive.

$(SIGNATURES)
"""
function lmpGender(g::LMFGerundive)
    g.ggender
end


"""Find case of a gerundive.

$(SIGNATURES)
"""
function lmpCase(g::LMFGerundive)
    g.gcase
end

"""Find number of a gerundive.

$(SIGNATURES)
"""
function lmpNumber(g::LMFGerundive)
    g.gnumber
end
