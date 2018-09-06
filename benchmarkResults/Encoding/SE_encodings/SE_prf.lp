%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding for checking a single
% preferred extensions S given by in/1
% has answer-set iff S is not preferred
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


out(X) :- not in(X), arg(X).

%% S is not conflict-free
nadm :- in(X), in(Y), att(X,Y).

%% The argument x is defeated by the set S
defeated(X) :- in(Y), att(Y,X).

%% Some argument x \in S is not defended by S (admissibility)
nadm :- in(X), att(Y,X), not defeated(Y).

% Guess a set S' \supset S
gIn(X) :- in(X), not nadm.
gIn(X)  :- out(X), not gOut(X), not nadm.
gOut(X) :- out(X), not gIn(X), not nadm.

%% strict superset
strict :- out(X), gIn(X).
:- not strict, not nadm.

%% S' has to be conflict-free
:- gIn(X), gIn(Y), att(X,Y), not nadm.

%% The argument x is defeated by the set S'
gDefeated(X) :- gIn(Y), att(Y,X), not nadm.

%% All arguments x \in S' need to be defended by S' (admissibility)
:- gIn(X), att(Y,X), not gDefeated(Y), not nadm.

nok.

#show nok/0.