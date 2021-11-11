"A record for a single noun stem."
struct TabulaeNounStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    form::AbstractString
    gender::LMPGender
    inflectionclass
end

"""
Read one row of a stems table for noun tokens and create a `TabulaeNounStem`.

$(SIGNATURES)    
"""
function readstemrow(usp::NounIO, delimited::AbstractString; delimiter = "|")
    parts = split(delimited, delimiter)
    if length(parts) < 5
        throw(DomainError("Too few parts in $(delimited)"))
    else
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        stem = parts[3]
        gender = lmpGender(parts[4])
        inflclass = parts[5]
        TabulaeNounStem(stemid,lexid,stem,gender,inflclass)
    end
end

"""Noun stems are citable by Cite2Urn"""
CitableTrait(::Type{TabulaeNounStem}) = CitableByCite2Urn()

"""Human-readlable label for a `TabulaeNounStem`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function label(ns::TabulaeNounStem)
    string("Noun stem ", ns.form, "- (", label(ns.gender), ")")
end


"""Identifying URN for a `TabulaeNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(ns::TabulaeNounStem; registry = nothing)
    if isnothing(registry)
        ns.stemid
    else
        expand(ns.stemid, registry)
    end
end



"""Compose CEX text for a `TabulaeNounStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.

@(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(ns::TabulaeNounStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        join([ns.stemid, label(ns) ], delimiter)
    else
        c2urn = expand(ns.stemid, registry)
        join([c2urn, label(ns)], delimiter)
    end
end

"""Identifier for a `TabulaeNounStem`, as an
abbreviated URN.

$(SIGNATURES)
"""
function id(n::TabulaeNounStem)
    n.stemid
end

"""Lexeme for a `TabulaeNounStem`, as an 
abbreviated URN.

$(SIGNATURES)
"""
function lexeme(n::TabulaeNounStem)
    n.lexid
end

"""Compose representation of `TabulaeNounStem` for FST  lexicon.

$(SIGNATURES)
"""
function fst(n::TabulaeNounStem)
    # E.g.:
    # <u>latcommon\.nounn14736</u><u>ls\.n14736</u>don<noun><neut><us_i>
    join([
        "<u>", protectreserved(string(n.stemid)) ,"</u>", 
        "<u>", protectreserved(string(n.lexid)), "</u>", 
        n.form, 
        "<", label(n.gender), ">", 
        "<", n.inflectionclass ,">"
    ])
end