
"""Install `alphabet.fst` required to be part of an individual project.

$(SIGNATURES)
"""
function installalphabet(src::Tabulae.Dataset, target::AbstractString)
    targetdir = joinpath(target,  "symbols")
    if ! ispath(targetdir)
        mkdir(targetdir)
    end
    targetfile = joinpath(targetdir, "alphabet.fst")
    lines = [
        "% Characters list supplied by dataset's orthography functions:",
        string("#alphabetic# = ", alphabetic(src.orthography)),
        "",
        string("#punctuation# = ", punctuation(src.orthography)),
        ""
    ]
    open(targetfile, "w") do io
        write(io, join(lines,"\n"))
    end
end


"""Install symbols FST from generic FST source applying to many projects.

$(SIGNATURES)
"""
function installsymbols(src::AbstractString, target::AbstractString)
    targetdir = joinpath(target, "symbols")
    if ! ispath(targetdir)
        mkdir(targetdir)
    end
    fstfiles = ["markup.fst", "morphsymbols.fst", "stemtypes.fst"]
    for fst in fstfiles
        srcfile = joinpath(src, "symbols", fst)
        targetfile = joinpath(targetdir, fst)
        cp(srcfile, targetfile; force=true)
    end
    toplevel = joinpath(target, "symbols.fst")
    open(toplevel, "w") do io
        print(io, symbolsfst(target))
    end
    phonologyfst = open(joinpath(src, "symbols", "phonology.fst"), "r") do phonology
        read(phonology, String)
    end
    prefix = join([
        "% phonology.fst",
        "%",
        "% Definitions of all legal symbols in stem files (lexica) except for",
        "% stem types (defined in stemtypes.fst)",
        "%",
        "% Basic alphabet specific to this orthographic system:",
        "#include \"" * target * "/symbols/alphabet.fst\""
    ], "\n")
    open(joinpath(target, "symbols", "phonology.fst"), "w") do io
        print(io, prefix * "\n\n" * phonologyfst * "\n")
    end
    
end

"""Compose content for top-level `symbols.fst` file.

$(SIGNATURES)
"""
function symbolsfst(dir::AbstractString)
    lines = [
        "% symbols.fst",
        "% A single include file for all symbols used in this FST.",
        "",
        "% 1. morphological tags",
        "#include \"$(dir)/symbols/morphsymbols.fst\"",
        "#include \"$(dir)/symbols/stemtypes.fst\"",
        "",        
        "% 2. ASCII representation of polytonic Greek",
        "#include \"$(dir)/symbols/phonology.fst\"",
        "",
        "% 3. Editorial symbols",
        "#include \"$(dir)/symbols/markup.fst\""
    ]
    join(lines,"\n")
end

