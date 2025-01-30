"A record for a single irregular verb stem."
struct TabulaeIrregularNounStem <: TabulaeIrregularStem
    stemid::AbbreviatedUrn
    lexid::AbbreviatedUrn
    form::AbstractString

    gender::LMPGender
    case::LMPCase
    number::LMPNumber
    
    inflectionclass::AbstractString
end



"""Override Base.show for irregular infinitive stem type.
$(SIGNATURES)
"""
function show(io::IO, n::TabulaeIrregularNounStem)
    print(io, label(n))
end
"""Override Base.== for irregular noun stem type.
$(SIGNATURES)
"""
function ==(n1::TabulaeIrregularNounStem, n2::TabulaeIrregularNounStem)
    id(n1) == id(n2) &&
    lexeme(n1) == lexeme(n2) &&
    stemvalue(n1) == stemvalue(n2)  &&
    lmpGender(n1) == lmpGender(n2)  &&
    lmpCase(n1) == lmpCase(n2) &&
    lmpNumber(n1) == lmpNumber(n2)  &&
    
    inflectionclass(n1) == inflectionclass(n2)
end


"""Human-readable label for an `TabulaeIrregularNounStem`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(n::TabulaeIrregularNounStem)
    string("Irregular noun form ", n.form)
end


CitableTrait(::Type{TabulaeIrregularNounStem}) = CitableByCite2Urn()
"""Irregular noun stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeIrregularNounStem})
    CitableByCite2Urn()
end



"""Identifying URN for an `TabulaeIrregularNounStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.
$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(n::TabulaeIrregularNounStem; registry = nothing)
    if isnothing(registry)
        n.stemid
    else
        (n.stemid, registry)
    end
end


struct TabulaeIrregularNounStemCex <: CexTrait end
"""Irregular adjective stems are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeIrregularNounStem})  
    TabulaeIrregularNounStemCex()
end


"""Compose CEX text for an `TabulaeIrregularNounStem`.
If `registry` is nothing, use abbreviated URN;
otherwise, expand identifier to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function cex(adj::TabulaeIrregularNounStem; delimiter = "|", registry = nothing)
    #StemUrn|LexicalEntity|String|Gender|Case|Number
    #latcommon.irregn13573gbis|ls.n13573|dii|masculine|nominative|plural

    if isnothing(registry)
        join([
            id(adj), lexeme(adj), stemvalue(adj),
            
            label(adj.gender), label(adj.case),label(adj.number),
            inflectionclass(adj)
        ], delimiter)
    else
        c2urn = expand(adj.stemid, registry)
        join([c2urn,  lexeme(adj), stemvalue(adj),
        label(adj.gender), label(adj.case),label(adj.number), 
        inflectionclass(adj) ], delimiter)
    end
end



"""Instantiate an irregular noun stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeIrregularNounStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)
    #StemUrn|LexicalEntity|String|Gender|Case|Number|Degree
    if length(parts) < 7
        msg = "Irregular noun stem: too few parts in $(cexsrc)."
        @warn msg
        throw(ArgumentError(msg))
    end
    
    stemid = StemUrn(parts[1])
    lexid = LexemeUrn(parts[2])
    stem = parts[3]
    g = lmpGender(parts[4])
    c = lmpCase(parts[5])
    n = lmpNumber(parts[6])
    
    inflclass = parts[7]

    TabulaeIrregularNounStem(stemid,lexid,stem,g,c,n,inflclass)
end




"""Identify gender of irregular noun.
$(SIGNATURES)
"""
function lmpGender(n::TabulaeIrregularNounStem)
    n.gender
end

"""Identify case of irregular noun.
$(SIGNATURES)
"""
function lmpCase(n::TabulaeIrregularNounStem)
    n.case
end



"""Identify number of irregular noun.
$(SIGNATURES)
"""
function lmpNumber(n::TabulaeIrregularNounStem)
    n.number
end



"""Identify id for irregular noun.
$(SIGNATURES)
"""
function id(n::TabulaeIrregularNounStem)
    n.stemid
end

"""Identify stem (full token) for irregular noun.
$(SIGNATURES)
"""
function stemvalue(n::TabulaeIrregularNounStem)
    n.form
end

"""Identify inflection class for irregular noun.
$(SIGNATURES)
"""
function inflectionclass(n::TabulaeIrregularNounStem)
    n.inflectionclass
end


"""Identify lexeme for irregular noun.
$(SIGNATURES)
"""
function lexeme(n::TabulaeIrregularNounStem)
    n.lexid
end


"""Compose a digital code string for an irregular noun.
$(SIGNATURES)
"""
function code(n::TabulaeIrregularNounStem)
      # PosPNTMVGCDCat
     string( NOUN,"0", code(n.number), "000", code(n.gender), code(n.case), "00")
end



function latinForm(n::TabulaeIrregularNounStem)
    LMFNoun(
        lmpGender(n),
        lmpCase(n),
        lmpNumber(n)
    )
end


