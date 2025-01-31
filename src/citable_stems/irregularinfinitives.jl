"A record for a single irregular verb stem."
struct TabulaeIrregularInfinitiveStem <: TabulaeIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    tense::LMPTense
    voice::LMPVoice
    inflectionclass::AbstractString
end

# latcommon.irreginf65|ls.n65|abire|present|active


"""Override Base.show for irregular infinitive stem type.
$(SIGNATURES)
"""
function show(io::IO, inf::TabulaeIrregularInfinitiveStem)
    print(io, label(inf))
end

"""Override Base.== for irregular verb infinitive stem type.
$(SIGNATURES)
"""
function ==(inf1::TabulaeIrregularInfinitiveStem, inf2::TabulaeIrregularInfinitiveStem)
    id(inf1) == id(inf2) &&
    lexeme(inf1) == lexeme(inf2) &&
    stemvalue(inf1) == stemvalue(inf2)  &&
    lmpTense(inf1) == lmpTense(inf2)  &&
    lmpVoice(inf1) == lmpVoice(inf2)  &&
    inflectionclass(inf1) == inflectionclass(inf2)
end

CitableTrait(::Type{TabulaeIrregularInfinitiveStem}) = CitableByCite2Urn()
"""Irregular verb stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeIrregularInfinitiveStem})
    CitableByCite2Urn()
end

"""Human-readable label for an `TabulaeIrregularInfinitiveStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(inf::TabulaeIrregularInfinitiveStem)
    string("Irregular infinitive form ", inf.form, " (", label(inf.tense)," ", label(inf.voice), ")")
end

"""Identifying URN for an `TabulaeIrregularInfinitiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(inf::TabulaeIrregularInfinitiveStem; registry = nothing)
    if isnothing(registry)
        inf.stemid
    else
        expand(inf.stemid, registry)
    end
end

struct TabulaeIrregularInfinitiveStemCex <: CexTrait end
"""Irregular verb stems are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeIrregularInfinitiveStem})  
    TabulaeIrregularInfinitiveStemCex()
end

"""Compose CEX text for an `TabulaeIrregularVerb`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(inf::TabulaeIrregularInfinitiveStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([
            id(inf), lexeme(inf), stemvalue(inf),
            
            label(inf.tense), label(inf.voice),
            inflectionclass(inf)
        ], delimiter)
    else
        c2urn = expand(verb.stemid, registry)
        join([c2urn,  lexeme(inf), stemvalue(inf),
        label(inf.tense), label(inf.voice),
        inflectionclass(inf) ], delimiter)
    end
end

"""Instantiate an irregular infinitive stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeIrregularInfinitiveStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 6
        msg = "Irregular infinitive stem: too few parts in $(cexsrc)."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    t = lmpTense(parts[4])
    v = lmpVoice(parts[5])
    inflclass = parts[6]

    TabulaeIrregularInfinitiveStem(stemid,lexid,stem,t,v,inflclass)
end


"""Identify tense of irregular infinitive.
$(SIGNATURES)
"""
function lmpTense(inf::TabulaeIrregularInfinitiveStem)
    inf.tense
end

"""Identify voice of irregular infinitive.
$(SIGNATURES)
"""
function lmpVoice(inf::TabulaeIrregularInfinitiveStem)
    inf.voice
end


"""Identify id for irregular infinitive.
$(SIGNATURES)
"""
function id(inf::TabulaeIrregularInfinitiveStem)
    inf.stemid
end

"""Identify stem (full token) for irregular infinitive.
$(SIGNATURES)
"""
function stemvalue(inf::TabulaeIrregularInfinitiveStem)
    inf.form
end

"""Identify inflection class for irregular infinitive.
$(SIGNATURES)
"""
function inflectionclass(inf::TabulaeIrregularInfinitiveStem)
    inf.inflectionclass
end


"""Identify lexeme for irregular infinitive.
$(SIGNATURES)
"""
function lexeme(inf::TabulaeIrregularInfinitiveStem)
    inf.lexid
end


"""Compose a digital code string for an irregular infinitive.
$(SIGNATURES)
"""
function code(inf::TabulaeIrregularInfinitiveStem)
      # PosPNTMVGCDCat
     string( INFINITIVE,"00", code(inf.tense), "0", code(inf.voice), "0000")
end

function latinForm(inf::TabulaeIrregularInfinitiveStem)
    LMFInfinitive(
        lmpTense(inf),
        lmpVoice(inf)
    )
end

