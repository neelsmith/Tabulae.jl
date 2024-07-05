"""A record for generating stems for a single compound verb.

$(SIGNATURES)
"""
struct TabulaeCompoundVerbStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    prefix::AbstractString
    simplex::LexemeUrn
    notes::AbstractString
end


"""Override Base.show for compound verb stem type.
$(SIGNATURES)
"""
function show(io::IO, verb::TabulaeCompoundVerbStem)
    print(io, label(verb))
end


"""Override Base.== for compound verb stem type.
$(SIGNATURES)
"""
function ==(v1::TabulaeCompoundVerbStem, v2::TabulaeCompoundVerbStem)
    stemid(v1) == stemid(v2) &&
    lexeme(v1) == lexeme(v2) &&
    prefix(v1) == prefix(v2)  &&
    simplex(v1) == simplex(v2) &&
    notes(v1) == notes(v2) 
end


CitableTrait(::Type{TabulaeCompoundVerbStem}) = CitableByCite2Urn()
"""Compound verb stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeCompoundVerbStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeCompoundVerbStem`.
$(SIGNATURES)
"""
function label(vs::TabulaeCompoundVerbStem)
    isempty(vs.notes) ? string("Compound verb (", vs.lexid,") formed by addding ", vs.prefix, " to simplex ", vs.simplex) : string("Compound verb (", vs.lexid,") formed by addding ", vs.prefix, " to simplex ", vs.simplex, " (", vs.notes, ")")
end


"""URN identifying a compound verb stem.
$(SIGNATURES)
"""
function urn(vs::TabulaeCompoundVerbStem; registry = nothing)
    if isnothing(registry)
        vs.stemid
    else
        expand(vs.stemid, registry)
    end
end


struct  TabulaeCompoundVerbStemCex <: CexTrait end
"""Compound verb stems are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeCompoundVerbStem})  
    TabulaeCompoundVerbStemCex()
end


"""Compose delimited text representation of a compound verb stem.
$(SIGNATURES)
"""
function cex(vs::TabulaeCompoundVerbStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([vs.stemid, lexeme(vs), vs.prefix,  vs.simplex, vs.notes, vs.augmented], delimiter)
    else
        c2urn = expand(vs.stemid, registry)
        lexurn = expand(ns.lexid, registry)
        join([c2urn, lexurn,  vs.prefix,  vs.simplex, vs.notes, vs.augmented], delimiter)
    end
end



"""Instantiate a compound verb stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeCompoundVerbStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    cols = split(cexsrc, delimiter)
    @debug("Making compound stem from $(cols)")
    if length(cols) < 5
        throw(ArgumentError("Cannot form compound verb stem: too few columns in $(cols)"))
    end
    TabulaeCompoundVerbStem(
        StemUrn(cols[1]),
        LexemeUrn(cols[2]),
        cols[3],
        LexemeUrn(cols[4]),
        cols[5]
    )
end



function pos(cvs::TabulaeCompoundVerbStemCex)
    :verb
end


"""Identify this `compound` stem record.
$(SIGNATURES)
"""
function stemid(compound::TabulaeCompoundVerbStem)
    compound.stemid
end


"""The prefix to apply to simplex verb to form compound forms.
$(SIGNATURES)
"""
function prefix(compound::TabulaeCompoundVerbStem)
    compound.prefix
end


"""Identify the lexeme of the compound verb.
$(SIGNATURES)
"""
function lexeme(compound::TabulaeCompoundVerbStem)
    compound.lexid
end

"""Identify the lexeme of the simplex verb.
$(SIGNATURES)
"""
function simplex(compound::TabulaeCompoundVerbStem)
    compound.simplex
end

"""Find any annotations for the compound verb stem record..
$(SIGNATURES)
"""
function notes(compound::TabulaeCompoundVerbStem)
    compound.notes
end


"""Compose a vector of `VerbStem`s for `compound` by adding `compound`'s prefix
to each `Stem` in `stemlist` for `compound`'s simplex identifier.
$(SIGNATURES)
"""
function stems(compound::TabulaeCompoundVerbStem, stemlist, ortho = latin25())
    @debug("Make compounds for $(compound) using $(stemlist)...")

    compounded = []
    for s in filter(s -> lexeme(s) == simplex(compound),  stemlist)
        catted = string(prefix(compound), stemvalue(s))
        @debug(catted)
        newstem = TabulaeVerbStem(
            stemid(compound),
            lexeme(compound),
            catted,
            inflectionclass(s)
        )
        push!(compounded, newstem)
    end
    compounded
end


"""Compose a vector of `VerbStem`s for `compound` by adding `compound`'s prefix
to each `Stem` in `stemlist`.
$(SIGNATURES)
"""
function irregularstems(compound::TabulaeCompoundVerbStem, stemlist, ortho = latin25())
    
    results = Stem[]
    simplexstems = filter(s -> lexeme(s) == simplex(compound),  stemlist)
    @debug("Compounding/stem count", compound, length(simplexstems))
    irrverbs = filter(s -> s isa TabulaeIrregularVerb, simplexstems)
    finiteresults = irregularverbstems(compound, irrverbs, ortho)

   # irrinfins = filter(s -> s isa IrregularInfinitiveStem, simplexstems)
    infinitiveresults = []# irregularinfinitivestems(compound, irrinfins, ortho)
    # Add:
    # Participle
    # Verbal adjective
    results = vcat(finiteresults, infinitiveresults)
end



function irregularverbstems(compound::TabulaeCompoundVerbStem, stemlist, ortho = literaryGreek())
    @info("Now make finite verb forms")
    compounds = TabulaeIrregularVerb[]
    for s in stemlist
        catted = string(prefix(compound), stemvalue(s))
        newstem = TabulaeIrregularVerb(
            stemid(compound),
            lexeme(compound),
            catted,
            lmpPerson(s),
            lmpNumber(s),
            lmpTense(s),
            lmpMood(s),
            lmpVoice(s),
            "irregularfiniteverb"
        )
        push!(compounds, newstem)
    end
    compounds
end


function irregularinfinitivestems(compound::TabulaeCompoundVerbStem, stemlist, ortho = literaryGreek())
    @debug("Now make irregular infinitive verb forms")
    #=
    compounds = TabulaeIrregularInfinitiveStem[]
    for s in stemlist
        catted = string(prefix(compound), "#", stemstring(s))
        newstem = IrregularInfinitiveStem(
            stemid(compound),
            lexeme(compound),
            catted,
            lmpTense(s),
            lmpVoice(s),
            "irregularinfinitive"
        )
        push!(compounds, newstem)
    end
    compounds
    =#
    []
end

