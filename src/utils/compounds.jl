"""Index compound verbs in a dataset to the simplex verbs they are built on.
$(SIGNATURES)
"""
function compoundsmap(tds::Tabulae.Dataset; delimiter = "|")
    compoundsmap(tds.dirs; delimiter = delimiter)
end


"""Index compound verbs in a dataset diretory tree to the simplex verbs they are built on.
$(SIGNATURES)
"""
function compoundsmap(dirlist; delimiter = "|")
    dict = Dict()
    for datasrc in dirlist
        dir = joinpath(datasrc, "stems-tables", "verbs-compound")
        @debug("Index $(dir)")
        cexfiles = glob("*.cex", dir)
        for f in cexfiles
            raw = readlines(f)
            # Trim lines first:
            lines = filter(s -> ! isempty(s), raw)
            for ln in lines[2:end]
                @info("Parse $(ln)")
                pieces = split(ln, delimiter)
                compound = pieces[2]
                simplex = pieces[4]
                dict[compound] = simplex
            end
        end
    end
    dict
end


"""Using an index of compound verbs to simplex verbs,
find the simplex verb for an Analysis.
$(SIGNATURES)
"""
function simplex(a::Analysis, d::Dict)
    compound = lexemeurn(a) |> string
    d[compound] |> LexemeUrn
end