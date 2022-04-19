
"""Compile a dictionary of collection IDs to colleciton-leve `Cite2Urn`s.
$(SIGNATURES)
"""
function registry(td::Tabulae.Dataset)
    registrydirs = [
        "lexemes",
        "rules",
        "stems"
    ]
    for dir in td.dirs
        for reg in registrydirs
            src = joinpath(dir, "urnregistry", reg)
            cexfiles = glob("*.cex", src)
            if isempty(cexfiles)
                @warn("No URN registry  found for $(reg) in dataset $(dir)")
            else
                
            end
        end
    end
end


"""True if configuration file found in lexemes, rules and stems.
$(SIGNATURES)
"""
function registryfilesfound(dir::AbstractString)
    ok = true
    registrydirs = [
        "lexemes",
        "rules",
        "stems",
        
    ]
    for reg in registrydirs
        src = joinpath(dir, "urnregistry", reg)
        cexfiles = glob("*.cex", src)
        if isempty(cexfiles)
            @warn("No URN registry  found for $(reg) in dataset $(dir)")
            ok = false
        end
    end
    ok
end