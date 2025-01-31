"A record for a single irregular verb stem."
struct TabulaeIrregularAdjectiveStem <: TabulaeIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString

    gender::LMPGender
    case::LMPCase
    number::LMPNumber
    degree::LMPDegree
    inflectionclass::AbstractString
end



"""Override Base.show for irregular infinitive stem type.
$(SIGNATURES)
"""
function show(io::IO, adj::TabulaeIrregularAdjectiveStem)
    print(io, label(adj))
end
"""Override Base.== for irregular verb infinitive stem type.
$(SIGNATURES)
"""
function ==(adj1::TabulaeIrregularAdjectiveStem, adj2::TabulaeIrregularAdjectiveStem)
    id(adj1) == id(adj2) &&
    lexeme(adj1) == lexeme(adj2) &&
    stemvalue(adj1) == stemvalue(adj2)  &&
    lmpGender(adj1) == lmpGender(adj2)  &&
    lmpCase(adj1) == lmpCase(adj2) &&
    lmpNumber(adj1) == lmpNumber(adj2)  &&
    lmpDegree(adj1) == lmpDegree(adj2)  &&
    inflectionclass(adj1) == inflectionclass(adj2)
end


"""Human-readable label for an `TabulaeIrregularAdverbStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(adj::TabulaeIrregularAdjectiveStem)
    string("Irregular adjective form ", adj.form)
end



CitableTrait(::Type{TabulaeIrregularAdjectiveStem}) = CitableByCite2Urn()
"""Irregular adjective stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeIrregularAdjectiveStem})
    CitableByCite2Urn()
end




"""Identifying URN for an `TabulaeIrregularAdjectiveStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(adj::TabulaeIrregularAdjectiveStem; registry = nothing)
    if isnothing(registry)
        adj.stemid
    else
        expand(adj.stemid, registry)
    end
end


struct TabulaeIrregularAdjectiveStemCex <: CexTrait end
"""Irregular adjective stems are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeIrregularAdjectiveStem})  
    TabulaeIrregularAdjectiveStemCex()
end


"""Compose CEX text for an `TabulaeIrregularAdjectiveStem`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::TabulaeIrregularAdjectiveStem; delimiter = "|", registry = nothing)
    #StemUrn|LexicalEntity|String|Gender|Case|Number|Degree
    #"latcommon.irregpron1896p|ls.n1896|aliam|feminine|accusative|singular|positive|irregularadjective"
    if isnothing(registry)
        join([
            id(adj), lexeme(adj), stemvalue(adj),
            
            label(adj.gender), label(adj.case),label(adj.number), label(adj.degree),
            inflectionclass(adj)
        ], delimiter)
    else
        c2urn = expand(adj.stemid, registry)
        join([c2urn,  lexeme(adj), stemvalue(adj),
        label(adj.gender), label(adj.case),label(adj.number), label(adj.degree),
        inflectionclass(adj) ], delimiter)
    end
end



"""Instantiate an irregular infinitive stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeIrregularAdjectiveStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    #StemUrn|LexicalEntity|String|Gender|Case|Number|Degree
    if length(parts) < 8
        msg = "Irregular adjective stem: too few parts in $(cexsrc)."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    g = lmpGender(parts[4])
    c = lmpCase(parts[5])
    n = lmpNumber(parts[6])
    d = lmpDegree(parts[7])
    inflclass = parts[8]

    TabulaeIrregularAdjectiveStem(stemid,lexid,stem,g,c,n,d,inflclass)
end




"""Identify gender of irregular adjective.
$(SIGNATURES)
"""
function lmpGender(adj::TabulaeIrregularAdjectiveStem)
    adj.gender
end

"""Identify case of irregular adjective.
$(SIGNATURES)
"""
function lmpCase(adj::TabulaeIrregularAdjectiveStem)
    adj.case
end



"""Identify number of irregular adjective.
$(SIGNATURES)
"""
function lmpNumber(adj::TabulaeIrregularAdjectiveStem)
    adj.number
end

"""Identify degree of irregular adjective.
$(SIGNATURES)
"""
function lmpDegree(adj::TabulaeIrregularAdjectiveStem)
    adj.degree
end


"""Identify id for irregular adjective.
$(SIGNATURES)
"""
function id(adj::TabulaeIrregularAdjectiveStem)
    adj.stemid
end

"""Identify stem (full token) for irregular adjective.
$(SIGNATURES)
"""
function stemvalue(adj::TabulaeIrregularAdjectiveStem)
    adj.form
end

"""Identify inflection class for irregular adjective.
$(SIGNATURES)
"""
function inflectionclass(adj::TabulaeIrregularAdjectiveStem)
    adj.inflectionclass
end




"""Identify lexeme for irregular noun.
$(SIGNATURES)
"""
function lexeme(adj::TabulaeIrregularAdjectiveStem)
    adj.lexid
end


"""Compose a digital code string for an irregular noun.
$(SIGNATURES)
"""
function code(adj::TabulaeIrregularAdjectiveStem)
      # PosPNTMVGCDCat
     string( NOUN,"0", code(adj.number), "000", code(adj.gender), code(adj.case), code(adj.degree), "0")
end



function latinForm(adj::TabulaeIrregularAdjectiveStem)
    LMFAdjective(
        lmpGender(adj),
        lmpCase(adj),
        lmpNumber(adj),
        lmpDegree(adj)
    )
end
