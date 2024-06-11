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
    inflectionclass
end

#latcommon.irregverbn46529a|ls.n46529|sum|first|singular|present|indicative|active

#=
function pos(vb::TabulaeIrregularVerb)
    :verb
end
=#


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



"""
Read one row of a stems table for irregular finite verb tokens and create an `TabulaeIrregularVerb`.

$(SIGNATURES)    
"""
function readstemrow(usp::IrregularVerbIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    # Example:
    #latcommon.irregverbn46529a|ls.n46529|sum|first|singular|present|indicative|active

    if length(parts) < 8
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
    inflclass = "irregularfiniteverb"

    TabulaeIrregularVerb(stemid,lexid,stem,p,n,t,m,v, inflclass)
end



"""Irregular verb stems are citable by Cite2Urn"""

CitableTrait(::Type{TabulaeIrregularVerb}) = CitableByCite2Urn()
"""Human-readlable label for an `TabulaeIrregularVerb`.

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



"""Compose CEX text for an `TabulaeIrregularVerb`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(verb::TabulaeIrregularVerb; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([verb.stemid, label(verb), stemstring(verb), lexeme(verb), inflectionclass(verb), label(verb.vperson), label(verb.vnumber), label(verb.vtense), label(verb.vmood), label(verb.vvoice) ], delimiter)
    else
        c2urn = expand(verb.stemid, registry)
        join([c2urn, label(verb), stemstring(verb), lexeme(verb), inflectionclass(verb), label(verb.vperson), label(verb.vnumber), label(verb.vtense), label(verb.vmood), label(verb.vvoice) ], delimiter)
    end
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
function lexemeurn(verb::TabulaeIrregularVerb)
    verb.lexid
end

"""Identify inflection class for `verb`.
$(SIGNATURES)
"""
function inflectionType(verb::TabulaeIrregularVerb)
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