
"""True if all necessary SFST components are installed.

$(SIGNATURES)
"""
function fstok()::Bool
    cmdok("make") && cmdok("fst-compiler-utf8") && cmdok("fst-infl")
end

"""True if executable cmd is found.

$(SIGNATURES)
"""
function cmdok(cmd::AbstractString)::Bool
    try
        f = read(`which $cmd`, String)
        true
    catch e
        println(e)
        false
    end
end
