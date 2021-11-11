%% latin.fst : a Finite State Transducer for ancient latin morphology
%
% All symbols used in the FST:
#include "/Users/nsmith/Desktop/linglat/Tabulae.jl/quicktest/testtabbuild/symbols.fst"


% Dynamically loaded lexica of stems:
$stems$ = "/Users/nsmith/Desktop/linglat/Tabulae.jl/quicktest/testtabbuild/lexicon.fst"


% Dynamically loaded inflectional rules:
$ends$ = "</Users/nsmith/Desktop/linglat/Tabulae.jl/quicktest/testtabbuild/inflection.a>"


% Morphology data is the crossing of stems and endings:
$morph$ = $stems$ <div> $ends$


% Acceptor (1) filters for content satisfying requirements for
% morphological analysis and  (2) maps from underlying to surface form
% by suppressing analytical symbols, and allowing only surface strings.
$acceptor$ = "</Users/nsmith/Desktop/linglat/Tabulae.jl/quicktest/testtabbuild/acceptor.a>"


% Final transducer:
$morph$ || $acceptor$