"""A parser parsing tokens by looking them up in a precomputed dictionary of all recognized forms."""
struct DictionaryParser <: TabulaeParser
    dict    
end

"""Parse token `s` by looking it up in `p.dict`.
$(SIGNATURES)
"""
function parsetoken(s::AbstractString, p::DictionaryParser)::Vector{Analysis}

    results = Vector{Analysis}()
    analyses = p.dict[s]
    for a in analyses
        # An Analysis has five members: a token string value, and four abbreviated URNs, one each for the lexeme, form, rule and stem.
        cols = split(a, "|")
        lex = LexemeUrn(cols[1])
        frm = FormUrn(cols[2])
        rule = RuleUrn(cols[3])
        stem = StemUrn(cols[4])
        push!(results, Analysis(s, lex,frm,rule,stem))
    end
    results
end



"""Build a dictionary parser for a Tabulae.Dataset.
$(SIGNATURES)
"""
function dictionaryParser(td::Tabulae.Dataset)

    # all noun forms x all noun stems
    nounforms()
    # all finite forms x all verb stems
    # all infinitive forms x all verb stems
    # all participle forms x all verb stems
    # all gerund forms x all verb stems
    # all gerundive forms x all verb stems
    # all supine forms x all verb stems
    # all pronoun forms x all pronoun stems
    # all adjective forms x all adjective stems
end