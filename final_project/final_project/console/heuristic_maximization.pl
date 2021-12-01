%Board est le plateau actuel
    % P1 is the current player while P2 is the ennemy


	heuristic_maximisation(Board, P1, P2, H) :-
	% on trouve le max de coins qui peuvent être retournés pour chaque joueur
	countMaxCoinSandwich(Board,0,_,IndexMaxFinalP1,P1,0,FinalCoinsMaxP1),
	countMaxCoinSandwich(Board,0,_,IndexMaxFinalP2,P2,0,FinalCoinsMaxP2),
	Somme is FinalCoinsMaxP1 + FinalCoinsMaxP2,
		% calculer lheuristique
	heuristic_maximization(FinalCoinsMaxP1,FinalCoinsMaxP2,Somme,H).

		heuristic_maximization(_,_,0,H):- H is 0.
heuristic_maximization(NbDiskP1,NbDiskP2,Somme,H):- H is 100 * (NbDiskP1-NbDiskP2) / Somme.
