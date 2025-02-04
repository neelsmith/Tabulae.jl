"""Adjectives have gender, case, number and degree."""
struct LMFAdjective <: LatinMorphologicalForm
    agender::LMPGender
    acase::LMPCase
    anumber::LMPNumber
    adegree::LMPDegree
end


"""Override Base.show for a noun form.
$(SIGNATURES)
"""
function show(io::IO, adj::LMFAdjective)
    println(io, label(adj))
end

"""Override Base.== for a noun form.
$(SIGNATURES)
"""
function ==(adj1::LMFAdjective, adj2::LMFAdjective)
    lmpGender(adj1)  == lmpGender(adj2) &&
    lmpCase(adj1)  == lmpCase(adj2) &&
    lmpNumber(adj1)  == lmpNumber(adj2) 
end


CitableTrait(::Type{LMFAdjective}) = CitableByCite2Urn()
"""Adjective forms are citable by Cite2Urn
$(SIGNATURES)
"""
function citabletrait(::Type{LMFAdjective})
    CitableByCite2Urn()
end

"""Compose a label for a `LMFAdjective`
$(SIGNATURES)
"""
function label(adj::LMFAdjective)    
    valuelist = [adj.agender, adj.acase, adj.anumber, adj.adegree]
    join(valuelist, " ")
end



"""Construct a `LMFAdjective` from string values.
$(SIGNATURES)
"""
function lmfAdjective(g::AbstractString, c::AbstractString, n::AbstractString)
    LMFAdjective(
        gendercodedict[g] |> LMPGender,
        casecodedict[c] |> LMPCase,
        numbercodedict[n] |> LMPNumber
    )
end


"""Generate list of codes for all adjective forms.
$(SIGNATURES)
"""
function adjectiveformcodes()
    genderints = keys(Tabulae.genderlabeldict) |> collect |> sort
    caseints = keys(Tabulae.caselabeldict) |> collect |> sort
    numints = keys(Tabulae.numberlabeldict) |> collect |> sort
    degreeints = keys(Tabulae.degreelabeldict) |> collect |> sort
    formlist = []
    for n in numints
        for g in genderints
            for c in caseints
                for d in degreeints
                    push!(formlist, "$(ADJECTIVE)0$(n)000$(g)$(c)$(d)0")
                end
            end
        end
    end
    formlist
end

"""Generate list of all noun forms.
$(SIGNATURES)
"""
function adjectiveforms()
    adjectiveformcodes() .|> lmfAdjective
end


"""Create a `LMFAdjective` from a string value.

$(SIGNATURES)
"""
function lmfAdjective(code::AbstractString)
    morphchars = split(code, "")
    gender = lmpGender(parse(Int64, morphchars[7]))
    case = lmpCase(parse(Int64, morphchars[8]))
    number = lmpNumber(parse(Int64,morphchars[3]))
    degree = lmpDegree(parse(Int, morphchars[9]))
    LMFAdjective(gender, case, number, degree)
end

"""Create a `LMFAdjective` from a `Cite2Urn`.

$(SIGNATURES)
"""
function lmfAdjective(urn::Cite2Urn)
    lmfAdjective(objectcomponent(urn))
end

"""Create a `GMFNoun` from a `FormUrn`.

$(SIGNATURES)
"""
function lmfAdjective(f::FormUrn)
    lmfAdjective(f.objectid)
end


"""Sequence of digits encoding form `noun`
$(SIGNATURES)
"""
function code(adj::LMFAdjective)::String
     string(ADJECTIVE,"0",code(adj.anumber),"000",code(adj.agender),code(adj.acase),code(adj.adegree),"0")
end


"""Find gender of a `LMFAdjective`.

$(SIGNATURES)
"""
function lmpGender(adj::LMFAdjective)
    adj.agender
end


"""Find case of a `LMFAdjective`.

$(SIGNATURES)
"""
function lmpCase(adj::LMFAdjective)
    adj.acase
end


"""Find number of a `LMFAdjective`.

$(SIGNATURES)
"""
function lmpNumber(adj::LMFAdjective)
    adj.anumber
end


"""Find degree of a `LMFAdjective`.

$(SIGNATURES)
"""
function lmpDegree(adj::LMFAdjective)
    adj.adegree
end



"""Generate a complete list of all possible noun forms.
$(SIGNATURES)
"""
function adjectiveanalyses(td::Tabulae.Dataset)::Vector{Analysis}
    formlist = Analysis[]

    stems = stemsarray(td)

    adjstems = filter(s -> s isa TabulaeAdjectiveStem, stems)
    for (i, adjstem) in enumerate(adjstems)
        # Filter nounforms() for matching gender.
        @info("Analyzing adjective $(i)/$(length(adjstems))")
       
        # THEN generate for those forms
        for f in filter(nf -> lmpGender(nf) == lmpGender(nounstem),  adjectiveforms())
            generated = analyses(lexeme(adjstem), f,  td)
            for g in generated
                push!(formlist, g)
            end
        end
    end

    
    formlist
end

