# Implement uninflected forms as LatinMorphologicalForm


"""Uninflected verbs have a category."""
struct LatinUninflectedForm <: LatinMorphologicalForm
    ucategory::Int64
end


"""Compose a `LatinUninflectedForm` for a FormUrn.
"""
function uninflectedfromurn(frm::FormUrn)
    digitchars = split(frm.objectid,"")
    ucat = parse(Int64, digitchars[10])
    LatinUninflectedForm(ucat)
end

"""Compose a FormUrn for a `LatinUninflectedForm`.

$(SIGNATURES)
"""
function formurn(uninflected::LatinUninflectedForm)
    FormUrn(string("morphforms.100000000", uninflected.ucategory))
end




"""Parse a string of SFST output into a `LatinUninflectedForm`.

$(SIGNATURES)
"""
function uninflectedfromfst(fstdata)
    nothing
    # Tabulae does this better.
    #
    #=
    # <u>latcommon.indecln4</u><u>ls.n4</u>a<indecl><indeclprep><div><indeclprep><indecl><u>indeclinfl.1</u>
    nounrulere = r"<([^<]+)><([^<]+)><([^<]+)>"  
    matchedup = collect(eachmatch(nounrulere, fstdata))
    
    if isempty(matchedup)
        @warn("Unable to parse FST analysis \"" * fstdata * "\"")
        nothing

    else
        (g,c,n) = matchedup[1].captures
        
        genderdict = labeldict(genderpairs)
        casedict = labeldict(casepairs)
        numberdict = labeldict(numberpairs)

        LatinNoun(genderdict[g], casedict[c], numberdict[n])
    end
=#
end
