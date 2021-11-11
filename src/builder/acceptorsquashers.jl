
"""Compose `acceptor.fst` and write to file `target`.

$(SIGNATURES)

- `target` is the full path to `acceptor.fst`
"""
function buildacceptor(target)
    fstroot = dirname(target)
    incl = string("#include \"", fstroot, "/symbols.fst\"")

    squashers = join([
        #irregularsquasher(),
        #uninflsquasher(),
        nounsquasher(),
        #finiteverbsquasher(),
        #infinitivesquasher(),
        #participlesquasher(),
        #verbaladjectivesquasher(),
        #adjectivesquasher(),
        #pronounsquasher()

    ], "\n")
    squasherunion = join(["% Union of all URN squashers:",
    raw"$acceptor$ =  $squashnounurn$ ", "\n"])
    #=join([
        "% Union of all URN squashers:",
        raw"$acceptor$ = $squashuninflurn$ | $squashnounurn$ | $squashirregurn$ | $squashverburn$ | $squashinfinitiveurn$ | $squashparticipleurn$ | $squashverbaladjectiveurn$ | $squashadjectiveurn$ | $squashpronounurn$ "
    ], "\n")
    =#
    stripper = join([
        "%% Put all symbols in 2 categories:  pass",
        "%% surface symbols through, suppress analytical symbols.",
        raw"#analysissymbol# = #editorial# #urntag# #uninflected# #pos# #morphtag# #stemtype#  #separator#",
        raw"#surfacesymbol# = #letter#",
        raw"ALPHABET = [#surfacesymbol#] [#analysissymbol#]:<>",
        raw"$stripsym$ = .+"
    ],"\n")
    closing = join([
        "%% The canonical pipeline: (morph data) -> acceptor -> parser/stripper"
        raw"$acceptor$ || $stripsym$"
    ],"\n")

    doc = join([incl,squashers,squasherunion,stripper,closing], "\n\n")
    open(target, "w") do io
        print(io, doc)
    end
end

"""Compose transducer for filtering nouns.

$(SIGNATURES)
"""
function nounsquasher()
    join([
    "% Noun acceptor:",
    raw"$=nounclass$ = [#nounclass#]",
    raw"$=gender$ = [#gender#]",
    raw"$squashnounurn$ = <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u> <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>[#stemchars#]+<noun>$=gender$ $=nounclass$   <div> $=nounclass$  <noun> [#stemchars#]* $=gender$ $case$ $number$ <u>[#urnchar#]:<>+\.:<>[#urnchar#]:<>+</u>"

    ], "\n")
end

