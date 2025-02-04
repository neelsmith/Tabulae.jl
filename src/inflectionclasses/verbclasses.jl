
conj1classes = [conj1, conj1dep]
conj2classes = [conj2, conj2dep]

# Add conj3, conj3io and c3iopres:
conj3classes = [conj3, c3pres]
conj4classes = [conj4, conj4dep]


# Add stems for individual principal parts:
principalparts = [pftact, pftpass]
# c1pres, c2pres, c3iopres, c4pres


function verbclasses()
    vcat(conj1classes, conj2classes, conj3classes, conj4classes, principalparts)
end

