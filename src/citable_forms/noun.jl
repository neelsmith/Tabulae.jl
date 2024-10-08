"""Nouns have gender, case and number."""
struct LMFNoun <: LatinMorphologicalForm
    ngender::LMPGender
    ncase::LMPCase
    nnumber::LMPNumber
end

"""Override Base.show for a noun form.
$(SIGNATURES)
"""
function show(io::IO, noun::LMFNoun)
    print(io, label(noun))
end

"""Override Base.== for a noun form.
$(SIGNATURES)
"""
function ==(vb1::LMFNoun, vb2::LMFNoun)
    lmpGender(vb1)  == lmpGender(vb2) &&
    lmpCase(vb1)  == lmpCase(vb2) &&
    lmpNumber(vb1)  == lmpNumber(vb2) 
end


CitableTrait(::Type{LMFNoun}) = CitableByCite2Urn()
"""Noun forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFNoun})
    CitableByCite2Urn()
end

"""Compose a label for a `LMFNoun`
$(SIGNATURES)
"""
function label(noun::LMFNoun)    
    join([ label(noun.ngender), label(noun.ncase), label(noun.nnumber)], " ")
end



"""Construct a `LMFNoun` from string values.
$(SIGNATURES)
"""
function lmfNoun(g::AbstractString, c::AbstractString, n::AbstractString)
    LMFNoun(
        gendercodedict[g] |> LMPGender,
        casecodedict[c] |> LMPCase,
        numbercodedict[n] |> LMPNumber
    )
end


"""Generate list of codes for all noun forms.
$(SIGNATURES)
"""
function nounformcodes()
    genderints = keys(Tabulae.genderlabeldict) |> collect |> sort
    caseints = keys(Tabulae.caselabeldict) |> collect |> sort
    numints = keys(Tabulae.numberlabeldict) |> collect |> sort
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                push!(formlist, "20$(n)000$(g)$(c)00")
            end
        end
    end
    formlist
end

"""Generate list of all noun forms.
$(SIGNATURES)
"""
function nounforms()
    nounformcodes() .|> lmfNoun
end


"""Create a `GMFNoun` from a string value.

$(SIGNATURES)
"""
function lmfNoun(code::AbstractString)
    morphchars = split(code, "")
    ngender = lmpGender(parse(Int64, morphchars[7]))
    ncase = lmpCase(parse(Int64, morphchars[8]))
    nnumber = lmpNumber(parse(Int64,morphchars[3]))
    
    LMFNoun(ngender, ncase, nnumber)
end

"""Create a `LMFNoun` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfNoun(urn::Cite2Urn)
    lmfNoun(objectcomponent(urn))
end

"""Create a `GMFNoun` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfNoun(f::FormUrn)
    lmfNoun(f.objectid)
end


"""Sequence of digits encoding form `noun`
$(SIGNATURES)
"""
function code(noun::LMFNoun)::String
     string(NOUN,"0",code(noun.nnumber),"000",code(noun.ngender),code(noun.ncase),"00")
end


"""Find gender of a `LMFNoun`.

$(SIGNATURES)
"""
function lmpGender(noun::LMFNoun)
    noun.ngender
end


"""Find case of a `LMFNoun`.

$(SIGNATURES)
"""
function lmpCase(noun::LMFNoun)
    noun.ncase
end

"""Find number of a `LMFNoun`.

$(SIGNATURES)
"""
function lmpNumber(noun::LMFNoun)
    noun.nnumber
end

"""Generate a complete list of all possible noun forms.
$(SIGNATURES)
"""
function nounanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)

    nounstems = filter(s -> s isa TabulaeNounStem, stems)
    for (i, nounstem) in enumerate(nounstems)
        # Filter nounforms() for matching gender.
        @debug("Analyzing noun $(i)/$(length(nounstems))")
       
        # THEN generate for those forms
        for f in filter(nf -> lmpGender(nf) == lmpGender(nounstem),  nounforms())
            generated = analyses(lexeme(nounstem), f,  td)
            for g in generated
                push!(formlist, g)
            end
        end
    end

    
    formlist
end
