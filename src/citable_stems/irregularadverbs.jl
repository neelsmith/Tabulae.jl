"A record for a single irregular verb stem."
struct TabulaeIrregularAdverb <: TabulaeIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    degree::LMPDegree
    inflectionclass::AbstractString
end

# latcommon.irreginf65|ls.n65|abire|present|active


"""Override Base.show for irregular infinitive stem type.
$(SIGNATURES)
"""
function show(io::IO, adv::TabulaeIrregularAdverb)
    print(io, label(adv))
end

"""Override Base.== for irregular adverb stem type.
$(SIGNATURES)
"""
function ==(adv1::TabulaeIrregularAdverb, adv2::TabulaeIrregularAdverb)
    id(adv1) == id(adv2) &&
    lexeme(adv1) == lexeme(adv2) &&
    stemvalue(adv1) == stemvalue(adv2)  &&
    lmpDegree(adv1) == lmpDegree(adv2)  &&
    inflectionclass(adv1) == inflectionclass(adv2)
end

CitableTrait(::Type{TabulaeIrregularAdverb}) = CitableByCite2Urn()
"""Irregular adverb stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeIrregularAdverb})
    CitableByCite2Urn()
end

"""Human-readable label for an `TabulaeIrregularAdverb`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adv::TabulaeIrregularAdverb)
    string("Irregular adverb form ", adv.form, " (", label(adv.degree), ")")
end

"""Identifying URN for a `TabulaeIrregularAdverb`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adv::TabulaeIrregularAdverb; registry = nothing)
    if isnothing(registry)
        adv.stemid
    else
        expand(adv.stemid, registry)
    end
end

struct TabulaeIrregularAdverbCex <: CexTrait end
"""Irregular verb stems are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeIrregularAdverb})  
    TabulaeIrregularAdverbCex()
end

"""Compose CEX text for a `TabulaeIrregularAdverb`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adv::TabulaeIrregularAdverb; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([
            id(adv), lexeme(adv), stemvalue(adv),
            
            label(adv.degree), 
            inflectionclass(adv)
        ], delimiter)
    else
        c2urn = expand(adv.stemid, registry)
        join([c2urn,  lexeme(adv), stemvalue(adv),
        label(adv.tense), label(adv.voice),
        inflectionclass(adv) ], delimiter)
    end
end

"""Instantiate an irregular adverb stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeIrregularAdverbCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 5
        msg = "Irregular infinitive stem: too few parts in $(cexsrc)."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    d = lmpDegree(parts[4])
    inflclass = parts[5]

    TabulaeIrregularAdverb(stemid,lexid,stem,d, inflclass)
end


"""Identify degree of irregular adverb.
$(SIGNATURES)
"""
function lmpDegree(adv::TabulaeIrregularAdverb)
    adv.degree
end


"""Identify id for irregular adverb.
$(SIGNATURES)
"""
function id(adv::TabulaeIrregularAdverb)
    adv.stemid
end

"""Identify stem (full token) for irregular adverb.
$(SIGNATURES)
"""
function stemvalue(adv::TabulaeIrregularAdverb)
    adv.form
end

"""Identify inflection class for irregular adverb.
$(SIGNATURES)
"""
function inflectionclass(adv::TabulaeIrregularAdverb)
    adv.inflectionclass
end


"""Identify lexeme for irregular adverb.
$(SIGNATURES)
"""
function lexeme(adv::TabulaeIrregularAdverb)
    adv.lexid
end


"""Compose a digital code string for an irregular infinitive.
$(SIGNATURES)
"""
function code(adv::TabulaeIrregularAdverb)
      # PosPNTMVGCDCat
     string( ADVERB,"00000000", code(adv.degree))
end

function latinForm(adv::TabulaeIrregularAdverb)
    LMFAdverb(
        lmpDegree(adv)
    )
end

