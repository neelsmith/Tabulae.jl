
#=
"""True if `verbcode` identifies a finite verb form with
a valid combination of tense and mood.
$(SIGNATURES)
"""
function validverbform(verbcode::AbstractString)
    verb = gmfFiniteVerb(verbcode)
    if lmpTense(verb) == lmpTense("imperfect")
        # Only accept imperfect indicative:
        lmpMood(verb) == lmpMood("indicative")

    elseif lmpTense(verb) == lmpTense("future")
        # No future subjunctive:
        lmpMood(verb) == lmpMood("indicative")

    else
        true
    end
end


=#