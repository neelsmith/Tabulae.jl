"A record for a single noun stem."
struct TabulaeUninflectedStem <: TabulaeStem
    stemid::StemUrn
    lexid::LexemeUrn
    token::String
    inflectionclass::AbstractString 
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