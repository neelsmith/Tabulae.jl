

function mustbe(parses::Vector{Analysis}, lex::LexemeUrn)
    @warn("Method not yet implemented")
    nothing
end


function mustbe(parses::Vector{Analysis}, form::FormUrn)
    @warn("Method not yet implemented")
    nothing
end


function mustbe(parses::Vector{Analysis}, form::T) where T <: LatinMorphologicalForm
    @warn("Method not yet implemented")
    nothing
end

function mustbe(parses::Vector{Analysis}, props::Vector{LatinMorphologicalProperty}) 
    @warn("Method not yet implemented")
    nothing
end



function couldbe(parses::Vector{Analysis}, lex::LexemeUrn)
    @warn("Method not yet implemented")
    nothing
end


function couldbe(parses::Vector{Analysis}, form::FormUrn)
    @warn("Method not yet implemented")
    nothing
end


function couldbe(parses::Vector{Analysis}, form::T) where T <: LatinMorphologicalForm
    @warn("Method not yet implemented")
    nothing
end

function couldbe(parses::Vector{Analysis}, props::Vector{LatinMorphologicalProperty}) 
    @warn("Method not yet implemented")
    nothing
end