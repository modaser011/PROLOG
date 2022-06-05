hero(State,Herou,T):-
	State=[R,_,Herou],
    sum_list(R,E),
    Herou is T-E.

findMin([X], X):- !.

findMin([H|T], Min):-
	findMin(T, TmpMin),
	H = [_,_,HFn],
	TmpMin = [_,_, TmpFn],
	(TmpFn < HFn -> Min = TmpMin ; Min = H).

getBestChild(Open, BestChild, RestOfOpen):-
	findMin(Open, BestChild),
	delete(Open, BestChild, RestOfOpen).

search(Open, _, Goal,E):-
    getBestChild(Open,State,_),
	isgoal(State,Goal),
    State=[E,_,_].

search(Open, Closed, Goal,E):-
    getBestChild(Open,State,RestOfOpen),
	getAllValidChildren(State, Open, Closed, Children,Goal),
	append(Children,RestOfOpen,NewOpen), 
	append([State], Closed, NewClosed),
	search(NewOpen, NewClosed, Goal,E).
	
getAllValidChildren(State, Open, Closed, Children,Goal):-
	findall(X, getNextState(State, Open, Closed, X,Goal), Children).
	
getNextState(State, Open, Closed,NextState,Goal):-
	move(State, NextState),
	not(member(NextState, Open)),
	not(member(NextState, Closed)),
	hero(NextState,_,Goal),
	isOkay(NextState).

isOkay(_).

isgoal(State,Goal):-
	State=[R,_,_],
	length(R,3),
	sum_list(R,Goal).

move(State,NextState):-
	State=[R,[HT|TT],_],
	NextState=[[HT|R],TT,_].

move(State,NextState):-
	State=[R,[_|TT],_],
	not(length(R,3)),
	NextState=[R,TT,_].


threeSum(List,Goal,Output):-
	X=[[],List,Goal],
	search([X],[],Goal,Output).