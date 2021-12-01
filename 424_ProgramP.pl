% Ian McNichols
% CS 424
% The following is my own work from my brain

a(X) :- X > 89, X < 101.
b(X) :- X > 79, X < 90.
c(X) :- X > 69, X < 80.
f(X) :- X > -1, X < 70.
zero(X) :- X < 0.
    
letter(M, Grade) :- a(M) ->  Grade="A".
letter(M, Grade) :- b(M) ->  Grade="B".
letter(M, Grade) :- c(M) ->  Grade="C".
letter(M, Grade) :- f(M) ->  Grade="F".
letter(M, Grade) :- not(number(M)); zero(M) ->  Grade = "Not_allowed_value".

countValues(_, [], 0).
countValues(A, [H|T], Out) :- dif(A,H), countValues(A, T, Out).
countValues(A, [H|T], Out) :- A = H, countValues(A, T, Out1), Out is Out1 + 1.

not_disjoint(A, B) :- member(X,A), member(X,B).
disjoint(A, B) :- not(not_disjoint(A, B)).
