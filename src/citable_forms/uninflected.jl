"""Uninflected forms belong to a part of speech."""
struct LMFUninflected <: LatinMorphologicalForm
    pos::LMPUninflectedType
end

"""Override Base.show for a pronoun form.
$(SIGNATURES)
"""
function show(io::IO, uninfl::LMFUninflected)
    print(io, label(uninfl))
end

"""Compose a label for a `LMFUninflected`
$(SIGNATURES)
"""
function label(uninfl::LMFUninflected)    
    "uninflected " * label(uninfl.pos)
end


"""Override Base.== for a pronoun form.
$(SIGNATURES)
"""
function ==(uninf1::LMFUninflected, uninf2::LMFUninflected)
    lmpUninflectedType(uninf1)  == lmpUninflectedType(uninf2) 
end


CitableTrait(::Type{LMFUninflected}) = CitableByCite2Urn()
"""Uninflected forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFUninflected})
    CitableByCite2Urn()
end



"""Construct a `LMFUninflected` from an integeter code.
$(SIGNATURES)
"""
function lmfUninflected(num::Int)
    LMFUninflected(
        lmpUninflectedType(num)
    )
end

"""Construct an uninflected form a from a string value.
$(SIGNATURES)
"""
function lmfUninflected(pos::AbstractString)
    LMFUninflected(
        lmpUninflectedType(uninflectedcodes[pos])
    )
end

"""Find part of speech of uninflected form.
$(SIGNATURES)
"""
function lmpUninflectedType(uninfl::LMFUninflected)
    uninfl.pos
end


"""Compose a digital code string for an uninflected form.
$(SIGNATURES)
"""
function code(uninfl::LMFUninflected)
      # PosPNTMVGCDCat
     string( UNINFLECTED,"00000000", code(uninfl.pos))
end