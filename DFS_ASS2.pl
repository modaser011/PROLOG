search(Open, _, Goal,E):-
Open = [State|_],
isgoal(State,Goal),
State=[E,_].

search(Open, Closed, Goal,E):-
Open = [State|RestOfOpen],
getAllValidChildren(State, Open, Closed, Children),
append(Children,RestOfOpen,NewOpen), 
append([State], Closed, NewClosed),
search(NewOpen, NewClosed, Goal,E).
 
getAllValidChildren(State, Open, Closed, Children):-
findall(X, getNextState(State, Open, Closed, X), Children).
 
getNextState(State, Open, Closed,NextState):-
move(State, NextState),
not(member(NextState, Open)),
not(member(NextState, Closed)),
isOkay(NextState).

isOkay(_).

isgoal(State,Goal):-
State=[R,_],
length(R,3),
sum_list(R,Goal).

move(State,NextState):-
State=[R,[HT|TT]],
NextState=[[HT|R],TT].

move(State,NextState):-
State=[R,[_|TT]],
not(length(R,3)),
NextState=[R,TT].

threeSum(List,Goal,Output):-
X=[[],List],
search([X],[],Goal,Output).





