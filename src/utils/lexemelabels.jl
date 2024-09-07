LEWIS_SHORT_URL = "http://shot.holycross.edu/lexica/ls-articles.cex"





"""Create a dictionary with lemma strings as keys to `LexemeUrn`s for
lexemes in the `lsj` dataset. Note that some distinct lemmata may reduce to a single stripped versions, only one of which will appear in this convenience data.

$(SIGNATURES)
"""
function lsid_dict(repodir = pwd())
    lsfile = joinpath(repodir, "lexicaldata", "ls.cex")
    iddict = Dict()
    idpairs = filter(ln -> !isempty(ln), readlines(lsfile))
    for pr in idpairs[2:end]
        pieces = split(pr, "|")
        keyval = Unicode.normalize(pieces[2], stripmark = true)
        iddict[keyval]= LexemeUrn(pieces[1])
    end
    iddict
end


"""Create a dictionary with `LexemeUrn`s for keys to lemma strings in the `lsj` dataset. 
$(SIGNATURES)
"""
function lslemma_dict(repodir = pwd())
    lsfile = joinpath(repodir, "lexicaldata", "ls.cex")
    iddict = Dict()
    idpairs = filter(ln -> !isempty(ln), readlines(lsfile))
    for pr in idpairs[2:end]
        pieces = split(pr, "|")
        iddict[pieces[1]]= pieces[2]
    end
    iddict
end


"""Create a dictionary with lemma strings as keys to `LexemeUrn`s for
lexemes in both the `ls` and `lsx` datasets.  Note that some distinct lemmata may reduce to a single stripped versions, only one of which will appear in this convenience data.

$(SIGNATURES)
"""
function lexid_dict(repodir = pwd())
    iddict = lsid_dict(repodir)

    lsxfile = joinpath(repodir, "lexicaldata", "lsx.cex")
    idpairs = filter(ln -> !isempty(ln), readlines(lsxfile))
    for pr in idpairs[2:end]
        pieces = split(pr, "|")
        keyval = pieces[2]
        iddict[keyval]= LexemeUrn(pieces[1])
    end
    iddict
end

"""Create a dictionary with lemma strings as keys to `LexemeUrn`s for
lexemes in both the `ls` and `lsx` datasets.  Note that some distinct lemmata may reduce to a single stripped versions, only one of which will appear in this convenience data.

$(SIGNATURES)
"""
function lexlemma_dict(repodir = pwd())
    iddict = lslemma_dict(repodir)

    lsxfile = joinpath(repodir, "lexicaldata", "lsx.cex")
    idpairs = filter(ln -> !isempty(ln), readlines(lsxfile))
    for pr in idpairs[2:end]
        pieces = split(pr, "|")

        iddict[pieces[1]]= pieces[2]
    end
    iddict
end

function lexlemma_dict_remote()
    iddict = Dict()
    url1 = "https://raw.githubusercontent.com/neelsmith/Tabulae.jl/main/lexicaldata/ls.cex"
    f1 = Downloads.download(url1)
    idpairs = filter(ln -> !isempty(ln), readlines(f1))
    rm(f1)
    for pr in idpairs[2:end]
        pieces = split(pr, "|")

        iddict[pieces[1]]= pieces[2]
    end

    url2 = "https://raw.githubusercontent.com/neelsmith/Tabulae.jl/main/lexicaldata/lsx.cex"
    f2 = Downloads.download(url2)
    idpairs = filter(ln -> !isempty(ln), readlines(f2))
    rm(f2)
    for pr in idpairs[2:end]
        pieces = split(pr, "|")

        iddict[pieces[1]]= pieces[2]
    end
    iddict
end


function label(lemma::LexemeUrn, dict = nothing)
    lemmadict = isnothing(dict) ? lexlemma_dict_remote() : dict
    keystring = string(lemma)
    if haskey(lemmadict, string(keystring))
        string(lemma, " (", lemmadict[string(lemma)], ")")
    else
        keystring * " (?)"
    end
end