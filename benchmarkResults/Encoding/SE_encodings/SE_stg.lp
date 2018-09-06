%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding for checking a single
% stage extensions S given by in/1
% has answer-set iff S is not stage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out(X) :- not in(X), arg(X).

%% S has to be conflict-free
ncf :- in(X), in(Y), att(X,Y).

range(X) :- in(X), not ncf.
range(X) :- in(Y), att(Y,X), not ncf.

% Guess a set S' \supset S
gIn(X) :- in(X), not ncf.
gIn(X) :- out(X), not gOut(X), not ncf.
gOut(X) :- out(X), not gIn(X), not ncf.

%% strict superset
strict :- gRange(X), not range(X), not ncf.
:- not strict, not ncf.

%% S' has to be conflict-free
:- gIn(X), gIn(Y), att(X,Y), not ncf.


gRange(X) :- gIn(X), not ncf.
gRange(X) :- gIn(Y), att(Y,X), not ncf.

nok.

#show nok/0.