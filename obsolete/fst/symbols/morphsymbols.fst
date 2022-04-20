% morphsymbols.fst
%
% Definitions of all symbols used to express a morphological analysis
%
% "Parts of speech": not traditional definition, but distinguished by
% analytical pattern.  E.g., <infin> has distinct pattern that is neither
% noun nor verb.
#pos# = <noun><adj><verb><vadj><infin><gerundive><gerund><supine><ptcpl><adv><pron><irregcverb><irregnoun><irregadj><irregadv><irreginfin><irregptcpl><irreggrnd><irreggrndv><irregsupn><irregpron><indecl>

#verbparts# = <verb><infin><ptcpl><gerundive><gerund><supine>
%
% 1. Noun morphology:
%
#gender# = <masculine><feminine><neuter>
#case# = <nominative><accusative><genitive><dative><ablative><vocative>
#number# = <singular><plural>
%
% 2. Additional adjective morphology:
%
#degree# = <positive><comparative><superlative>
%
% 3. Verb morphology:
%
#person# = <first><second><third>
% number already defined in noun morphology
#tense# = <present><imperfect><future><future_perfect><perfect><pluperfect>
#mood# = <indicative><subjunctive><imperative>
#voice# = <active><passive>
%
% 4. Uninflected forms:
%
#uninflected# =  <conjunction><particle><interjection><preposition><adverb><numeral>


% Need to add gerunds, supine....

#finiteform# = <infin><ptcpl>

#morphtag# = #pos# #gender# #case# #number# #person# #tense# #mood# #voice# #degree# #finiteform#

%
% 4. Indeclinable forms:
%
#indecl# = <indeclprep><indeclconj><indeclinterj><indeclnum>


% Consider whether those belong here or elsewhere...?

% Transducers for the above variables:
$gender$ = [#gender#]
$case$ = [#case#]
$number$ = [#number#]

$person$ = [#person#]
$tense$ = [#tense#]
$mood$ = [#mood#]
$voice$ = [#voice#]

$degree$ = [#degree#]


% Identity variables for the transducers:
$=gender$ = [#gender#]
$=case$ = [#case#]
$=number$ = [#number#]
