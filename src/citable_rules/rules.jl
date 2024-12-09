abstract type TabulaeRule <: Rule end



"""Instantiate `LatinMorphologicalForm` identified by `rule`.
$(SIGNATURES)
"""
function latinForm(rule::T) where {T <: TabulaeRule}
    @warn "Function latinForm not implemented for rules of type $(typeof(rule))."
    nothing
end


"""Find inflection class identified by `rule`.
$(SIGNATURES)
"""
function inflectionclass(rule::T) where {T <: TabulaeRule}
    @warn "Function inflectionclass not implemented for rules of type $(typeof(rule))."
    nothing
end

"""Find ending for `rule`.
$(SIGNATURES)
"""
function ending(rule::T) where {T <: TabulaeRule}
    @warn "Function ending not implemented for rules of type $(typeof(rule))."
    nothing
end


function lmpGender(stem::T) where {T <: TabulaeRule}
    @warn "Function lmpGender not implemented for rules of type $(typeof(stem))."
    nothing
end

function lmpCase(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpCase not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpNumber(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpNumber not implemented for rules of type $(typeof(rule))."
    nothing
end


function lmpPerson(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpPerson not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpTense(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpTense not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpMood(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpMood not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpVoice(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpVoice not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpDegree(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpDegree not implemented for rules of type $(typeof(rule))."
    nothing
end

function lmpUninflected(rule::T) where {T <: TabulaeRule}
    @warn "Function lmpUninflected not implemented for rules of type $(typeof(rule))."
    nothing
end


#=
function latinForm(r::T) where {T <: TabulaeRule}
    formurn(r) |> latinForm
end
=#


function delimitedrule(r::T; delimiter = "|") where {T <: TabulaeRule}
    if isnothing(latinForm(r))
        @warn("Yikes got nothing for a rule of type $(typeof(r))...")
    else
        data = [
            id(r),
            inflectionclass(r),
            ending(r),
            abbreviate(urn(latinForm(r)))
        ]
        
        join(data, delimiter)
    end
end


function fromdelimited(row::AbstractString; delimiter = "|")
    cols = split(row, delimiter)
    if length(cols) < 4
        throw(DomainError("Too few columns in $(row)"))
    end

    frm = cols[4] |> FormUrn |> latinForm
    rule = RuleUrn(cols[1])
    @debug("Type to create is $(typeof(frm))")
    @debug("Creating rule for form $(frm)")
    formrule(rule, cols[2], cols[3], frm)
end




function formrule(id::RuleUrn, infltype::AbstractString, ending::AbstractString, f::LatinMorphologicalForm)
    @debug("No implementation of formrule function for type $(typeof(f))")
end



"""Write a Vector of rules to a delimited-text file in uniform (succinct) format.
$(SIGNATURES)
"""
function tofile(v::Vector{Rule}, f; delimiter = "|")
    @info("Writing rules to file $(f) with delimiter $(delimiter)")
    headings = ["Rule", "Inflectional type","Ending","Form"]
    hdr = join(headings, delimiter)
    data = delimitedrule.(v; delimiter = delimiter )
    content = hdr * "\n" * join(data,"\n")
    open(f, "w") do io
        write(f, content)
    end
end



"""Read a set of Tabulae Rules from delimited text in succinct format.
$(SIGNATURES)
"""
function ruleset(s, freader::Type{StringReader};  delim = "|")
    data = filter(row -> !isempty(row),split(s,"\n"))[2:end]

    map(data) do row
        @debug("Mapping row $(row)")
        fromdelimited(row; delimiter = delim)
    end
    #fromdelimited.(data; delimiter = delim)
end



"""Read a set of Tabulae Rules from delimited-text file in succinct format.
$(SIGNATURES)
"""
function ruleset(f, freader::Type{FileReader};  delim = "|")  
    ruleset(read(f, String), StringReader; delim = delim)
end



"""Read a set of Tabulae Rules from delimited-text source succinct format on the internet.
$(SIGNATURES)
"""
function ruleset(u, freader::Type{UrlReader};  delim = "|")  
    @debug("Read a rules set from a URL source")
    tmp = Downloads.download(u)
    data = read(tmp, String)
    rm(tmp)
    #@debug("Data for rules set: $(data)")
    ruleset(data, StringReader; delim = delim)
end



"""Compose an abbreviated URN for a rule.

$(SIGNATURES)
"""
function formurn(rule::T) where {T <: TabulaeRule}
    latinForm(rule) |> formurn
end