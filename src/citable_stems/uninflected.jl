"A record for a single noun stem."
struct TabulaeUninflectedStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    token::String
    inflectionclass::LMPUninflectedType 
end




"""Override Base.show for uninflected stem type.
$(SIGNATURES)
"""
function show(io::IO, st::TabulaeUninflectedStem)
    print(io, label(st))
end

"""Override Base.== for uninflected stem type.
$(SIGNATURES)
"""
function ==(st1::TabulaeUninflectedStem, st2::TabulaeUninflectedStem)
    id(st1) == id(st2) &&
    lexeme(st1) == lexeme(st2) &&
    stemvalue(st1) == stemvalue(st2)  &&
    lmpUninflectedType(st1) == lmpUninflectedType(st2) 
end


CitableTrait(::Type{TabulaeUninflectedStem}) = CitableByCite2Urn()
"""Uninflected stems are citable by Cite2Urn.
$(SIGNATURES)
"""
function citabletrait(::Type{TabulaeUninflectedStem})
    CitableByCite2Urn()
end

"""Human-readlable label for a `TabulaeUninflectedStem`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function label(st::TabulaeUninflectedStem)
    string("Uninflected ", label(st.inflectionclass), " ", st.token)
end


"""Identifying URN for a `TabulaeUninflectedStem`.  If
no registry is included, use abbreviated URN;
otherwise, expand to full `Cite2Urn`.

$(SIGNATURES)
Required for `CitableTrait`.
"""
function urn(st::TabulaeUninflectedStem; registry = nothing)
    if isnothing(registry)
        st.stemid
    else
        expand(st.stemid, registry)
    end
end



struct TabulaeUninflectedStemCex <: CexTrait end
"""Uninflected stems are are CEX serializable.
$(SIGNATURES)
"""
function cextrait(::Type{TabulaeUninflectedStem})  
    TabulaeUninflectedStemCex()
end

"""Compose CEX text for a `TabulaeUninflectedStem`.
If `registry` is nothing, use abbreivated URN;
otherwise, expand identifier to full `Cite2Urn`.
$(SIGNATURES)
"""
function cex(st::TabulaeUninflectedStem; delimiter = "|", registry = nothing)
    if isnothing(registry)
        data = [
            id(st), lexeme(st), stemvalue(st),
            label(lmpUninflectedType(st))
        ]
        @debug("No registry: basic data $(data)")
        txt  = join(data, delimiter)

        @debug("Result is $(txt)")
        txt
    else
        c2urn = expand(id(st), registry)
        lexurn = expand(lexeme(st), registry)

        data = [c2urn, lexurn, stemvalue(st),
            label(lmpUninflectedType(st))
        ]
        join(data, delimiter)
    end
end



"""Instantiate an uninflected stem from delimited-text source.
$(SIGNATURES)
"""
function fromcex(traitvalue::TabulaeUninflectedStemCex, cexsrc::AbstractString, T;      
    delimiter = "|", configuration = nothing, strict = true)
    parts = split(cexsrc, delimiter)

    @debug("$(length(parts)) parts: $(parts)")
    if length(parts) < 4
        throw(DomainError("Too few parts in $(delimited)"))
    else
        
        stemid = StemUrn(parts[1])
        lexid = LexemeUrn(parts[2])
        stem = parts[3]
        @debug("Look at parts4 $(parts[4])")
        pos = lmpUninflectedType(parts[4])
        
        
        TabulaeUninflectedStem(stemid,lexid,stem,pos)
    end
end

function stemvalue(st::TabulaeUninflectedStem)
    st.token
end

function lexeme(st::TabulaeUninflectedStem)
    st.lexid
end


function latinForm(st::TabulaeUninflectedStem)
    LMFUninflected(st.inflectionclass)
end

function lmpUninflectedType(st::TabulaeUninflectedStem)
    st.inflectionclass
end

function id(st::TabulaeUninflectedStem)
    st.stemid
end

function inflectionclass(st::TabulaeUninflectedStem)
    string(st.inflectionclass)
end