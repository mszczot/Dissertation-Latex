%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding for checking a single
% semi-stable extensions S given by in/1
% has answer-set iff S is not semi-stable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


out(X) :- not in(X), arg(X).

%% S has to be conflict-free
nadm :- in(X), in(Y), att(X,Y).

%% The argument x is defeated by the set S
defeated(X) :- in(Y), att(Y,X).

%% The argument x is not defended by S
not_defended(X) :- att(Y,X), not defeated(Y).

%% All arguments x \in S need to be defended by S (admissibility)
nadm :- in(X), not_defended(X).

range(X) :- in(X), not nadm.
range(X) :- defeated(X), not nadm.

% Guess a set S' \supset S
gIn(X) :- in(X), not nadm.
gIn(X)  :- out(X), not gOut(X), not nadm.
gOut(X) :- out(X), not gIn(X), not nadm.


%% strict superset
strict :- gRange(X), not range(X), not nadm.
:- not strict, not nadm.

%% S' has to be conflict-free
:- gIn(X), gIn(Y), att(X,Y), not nadm.

%% The argument x is defeated by the set S'
gDefeated(X) :- gIn(Y), att(Y,X), not nadm.

gRange(X) :- gIn(X), not nadm.
gRange(X) :- gDefeated(X), not nadm.


%% All arguments x \in S' need to be defended by S' (admissibility)
:- gIn(X), att(Y,X), not gDefeated(Y), not nadm.

nok.

#show nok/0.
