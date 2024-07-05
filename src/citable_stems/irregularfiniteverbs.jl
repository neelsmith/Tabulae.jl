"A record for a single irregular verb stem."
struct TabulaeIrregularVerb <: TabulaeIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString
    vperson::LMPPerson
    vnumber::LMPNumber
    vtense::LMPTense
    vmood::LMPMood
    vvoice::LMPVoice
    inflectionclass::AbstractString
end

#latcommon.irregverbn46529a|ls.n46529|sum|first|singular|present|indicative|active


"""Override Base.show for irregular verb stem type.
$(SIGNATURES)
"""
function show(io::IO, vb::TabulaeIrregularVerb)
    print(io, label(vb))
end

"""Override Base.== for irregular verb stem type.
$(SIGNATURES)
"""
function ==(s1::TabulaeIrregularVerb, s2::TabulaeIrregularVerb)
    id(s1) == id(s2) &&
    lexeme(s1) == lexeme(s2) &&
    tokenvalue(s1) == tokenvalue(s2)  &&

    lmpPerson(s1) == lmpPerson(s2)  &&
    lmpNumber(s1) == lmpNumber(s2)  &&
    lmpTense(s1) == lmpTense(s2)  &&
    lmpMood(s1) == lmpMood(s2)  &&
    lmpVoice(s1) == lmpVoice(s2)  &&

    inflectionclass(s1) == inflectionclass(s2)
end

CitableTrait(::Type{TabulaeIrregularVerb}) = CitableByCite2Urn()
"""Irregular verb stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeIrregularVerb})
    CitableByCite2Urn()
end

"""Human-readable label for an `TabulaeIrregularVerb`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(verb::TabulaeIrregularVerb)
    string("Irregular verb form ", verb.form, " (", label(verb.vperson), " ", label(verb.vnumber), " ", label(verb.vtense)," ", label(verb.vmood), " ", label(verb.vvoice), ")")
end

"""Identifying URN for an `TabulaeIrregularVerb`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(verb::TabulaeIrregularVerb; registry = nothing)
    if isnothing(registry)
        verb.stemid
    else
        expand(verb.stemid, registry)
    end
end



struct TabulaeIrregularVerbCex <: CexTrait end
"""Irregular verb stems are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeIrregularVerb})  
    TabulaeIrregularVerbCex()
end

"""Compose CEX text for an `TabulaeIrregularVerb`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(verb::TabulaeIrregularVerb; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([
            id(verb), lexeme(verb), tokenvalue(verb),
            
            label(verb.vperson), label(verb.vnumber), label(verb.vtense), label(verb.vmood), label(verb.vvoice),
            inflectionclass(verb)
        ], delimiter)
    else
        c2urn = expand(verb.stemid, registry)
        join([c2urn,  lexeme(verb), tokenvalue(verb),
            
        label(verb.vperson), label(verb.vnumber), label(verb.vtense), label(verb.vmood), label(verb.vvoice),
        inflectionclass(verb) ], delimiter)
    end
end

"""Instantiate an irregular verb stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeIrregularVerbCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    if length(parts) < 9
        msg = "Too few parts in $delimited."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    p = lmpPerson(parts[4])
    n = lmpNumber(parts[5])
    t = lmpTense(parts[6])
    m = lmpMood(parts[7])
    v = lmpVoice(parts[8])
    inflclass = parts[9]

    TabulaeIrregularVerb(stemid,lexid,stem,p,n,t,m,v, inflclass)
end
#=
function pos(vb::TabulaeIrregularVerb)
    :verb
end
=#


function tokenvalue(irrv::TabulaeIrregularVerb)
    irrv.form
end

function lmForm(irrv::TabulaeIrregularVerb)
    LMFFiniteVerb(
        lmpPerson(irrv),
        lmpNumber(irrv),
        lmpTense(irrv),
        lmpMood(irrv),
        lmpVoice(irrv)
    )
end

"""Identify person of `verb`.
$(SIGNATURES)
"""
function lmpPerson(verb::TabulaeIrregularVerb)
    verb.vperson
end


"""Identify tense of `verb`.
$(SIGNATURES)
"""
function lmpNumber(verb::TabulaeIrregularVerb)
    verb.vnumber
end

"""Identify tense of `verb`.
$(SIGNATURES)
"""
function lmpTense(verb::TabulaeIrregularVerb)
    verb.vtense
end

"""Identify mood of `verb`.
$(SIGNATURES)
"""
function lmpMood(verb::TabulaeIrregularVerb)
    verb.vmood
end


"""Identify voice of `verb`.
$(SIGNATURES)
"""
function lmpVoice(verb::TabulaeIrregularVerb)
    verb.vvoice
end


"""Identify value of stem string for `verb`.
$(SIGNATURES)
"""
function stemvalue(verb::TabulaeIrregularVerb)
    verb.form
end

"""Identify lexeme for `verb`.
$(SIGNATURES)
"""
function lexeme(verb::TabulaeIrregularVerb)
    verb.lexid
end

"""Identify inflection class for `verb`.
$(SIGNATURES)
"""
function inflectionclass(verb::TabulaeIrregularVerb)
    verb.inflectionclass
end




"""Compose a digital code string for the form identified in `verb`.
$(SIGNATURES)
"""
function code(verb::TabulaeIrregularVerb)
      # PosPNTMVGCDCat
     string( FINITEVERB,"$(code(verb.vperson))$(code(verb.vnumber))$(code(verb.vtense))$(code(verb.vmood))$(code(verb.vvoice))0000")
end


"""Compose an abbreviated URN for a rule from a `IrregularAdjectiveStem`.

$(SIGNATURES)
"""
function formurn(verb::TabulaeIrregularVerb)
    FormUrn("$(COLLECTION_ID)." * code(verb))
end

"""Identifier for a `TabulaeIrregularVerb`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(vs::TabulaeIrregularVerb)
    vs.stemid
end

#=
function greekForm(verb::TabulaeIrregularVerb) 
    formurn(verb) |> greekForm
end

=#