@enumx PartOfSpeech begin
    verb
    noun
    adjective
    adverb
    pronoun
    uninflected
end



function label(pos::PartOfSpeech.T)
    if pos == PartOfSpeech.verb        
        "verb"
    elseif pos == PartOfSpeech.noun
        "noun"
    elseif pos == PartOfSpeech.adjective
        "adjective"
    elseif pos == PartOfSpeech.adverb
        "adverb"
    elseif pos == PartOfSpeech.pronoun
        "pronoun"
    elseif pos == PartOfSpeech.uninflected
        "nouninflectedun"
    else
        "look harder"
    end
end