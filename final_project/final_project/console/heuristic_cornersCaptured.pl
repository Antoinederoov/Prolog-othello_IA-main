
% CORNERS CAPTURED HEURISTICS

    :- writeln('Corners Captured heuristic has loaded.').

    % P1 is the current player while P2 is the enemy
    % Corners Captured
    %P1 is the current player
    %Cette heuristique cherche à mener vers les configurations qui tendent à remporter les coins du plateau
    % On distingue trois catégories : les ActualCorners, les coins qui sont réellement occupés par un disque du joueur
    %                                 les PotentialCorners, les coins qui peuvent être pris par le joueur au prochain mouvement
    %                                 et les UnlikelyCorners, les coins non occupés et qui ne sont pas susceptibles de l être dans les prochains coups
    % Chaque ActualCorner rapport 4 points, les PotentialCorners 2 points et les UnlikelyCorners 0 points
    % La valeur de l heuristique est égale à l écart relatif entre le nombre de points du joueur max et celui du joueur min

    heuristic_cornersCaptured(Board, P1, P2, H) :-
    %Récupérer tous les disques
    getCorners(Board, Corners),

    %Compter le nombre de coins effectifs
        countByPlayer(Corners, P1, NbDiskP1),
        countByPlayer(Corners, P2, NbDiskP2),

        %Compter le nombre de coins potentiels
            countPotentialCorners(Board, P1, 0, 0, NbPotentialFinal1),
            countPotentialCorners(Board, P2, 0, 0, NbPotentialFinal2),

            %Compter le score de chaque joueur en prenant en compte les coins effectifs, potentiels et improbables
                ScoreP1 is 5*NbDiskP1+3*NbPotentialFinal1,
                    ScoreP2 is 5*NbDiskP2+3*NbPotentialFinal2,
                        write(ScoreP1),
                        write(ScoreP2),

                        %Somme des scores
    Somme is ScoreP1 + ScoreP2,

        %Calculer l heuristique
    heuristic_compute(ScoreP1, ScoreP2, Somme, H).


        getCorners(Board, Corners) :- getCorners(Board, Corners, 0).
    getCorners([],[],64).
    getCorners([D|B], [D|C], I) :- (I==0 ; I==7 ; I==56; I==63) , J is I+1, getCorners(B, C, J).
    getCorners([_|B], C, I) :-  J is I+1, getCorners(B, C, J).

    % on compte les actualCorners
    countByPlayer([], _, 0).
        countByPlayer([D|C], P, NbDiskP) :- var(D), countByPlayer(C, P, NbDiskP).
    countByPlayer([P|C], P, NbDiskP) :- countByPlayer(C, P, NewNbDiskP), NbDiskP is NewNbDiskP + 1.
countByPlayer([_|C], P, NbDiskP) :- countByPlayer(C, P, NbDiskP).

    % on compte les potentialCorners
    countPotentialCorners(Board, Player, Index, NbPotential, NbPotentialFinal):- Index >= 64, NbPotentialFinal is NbPotential.
    countPotentialCorners(Board, Player, Index, NbPotential, NbPotentialFinal):- Index < 64, (Index==0 ; Index==7 ; Index==56; Index==63), isValid(Board, Player, Index), IndexActuel is Index + 1, NbPotentialActuel is NbPotential + 1, countPotentialCorners(Board, Player, IndexActuel, NbPotentialActuel,NbPotentialFinal).
    countPotentialCorners(Board, Player, Index, NbPotential, NbPotentialFinal):- Index < 64, IndexActuel is Index + 1, countPotentialCorners(Board, Player, IndexActuel, NbPotential, NbPotentialFinal).

    heuristic_compute(_,_,0,0).
    heuristic_compute(NbDiskP1, NbDiskP2, Somme, H) :- H is 100 * (NbDiskP1-NbDiskP2) / Somme.