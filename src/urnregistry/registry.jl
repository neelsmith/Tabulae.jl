
"""Compile a dictionary of collection IDs to colleciton-leve `Cite2Urn`s.
$(SIGNATURES)
"""
function registry(td::Tabulae.Dataset)
    dict = Dict{String, Cite2Urn}()
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
                for f in cexfiles
                    lns = readlines(f)
                    for ln in filter(l -> !isempty(l), lns[2:end])
                        cols = split(ln, "|")
                        u = Cite2Urn(cols[2])
                        dict[cols[1]] = u
                    end
                end

            end
        end
    end
    dict
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