% STABILITY HEURISTIC

:- writeln('Stability heuristic has loaded.').
% Resource : https://courses.cs.washington.edu/courses/cse573/04au/Project/mini1/RUSSIA/Final_Paper.pdf

% Daprès la simplification proposée dans larticle de la source
stabilityWeights([4,  -3,  2,  2,  2,  2, -3,  4,
                   -3, -4, -1, -1, -1, -1, -4, -3,
                   2,  -1,  1,  0,  0,  1, -1,  2,
                   2,  -1,  0,  1,  1,  0, -1,  2,
                   2,  -1,  0,  1,  1,  0, -1,  2,
                   2,  -1,  1,  0,  0,  1, -1,  2,
                   -3, -4, -1, -1, -1, -1, -4, -3,
                   4,  -3,  2,  2,  2,  2, -3,  4]).


heuristic_stability(Board, Player, Opponent, H) :-
    stabilityWeights(SW),
    heuristic_stability(Board, Player, H, SW).

heuristic_stability([BH|BT], Player, H, [SWH|SWT]) :-
    HP is 0,
    HO is 0,
    switchPlayer(Player, Opponent),
    BH==Player,
    NewHP is HP + SW,
    heuristic_stability(BT, Player, H, SWT, NewHP, HO).


heuristic_stability([BH|BT], Player, H, [SWH|SWT]) :-
    HP is 0,
    HO is 0,
    switchPlayer(Player, Opponent),
    BH==Opponent,
    NewHO is HO + SWH,
    heuristic_stability(BT, Player, H, SWT, HP, NewHO).
    

heuristic_stability([BH|BT], Player, H, [SWH|SWT], HP, HO) :-
    switchPlayer(Player, Opponent),
    BH==Player,
    NewHP is HP + SW,
    heuristic_stability(BT, Player, H, SWT, NewHP, HO).

heuristic_stability([BH|BT], Player, H, [SWH|SWT], HP, HO) :-
    switchPlayer(Player, Opponent),
    BH==Opponent,
    NewHO is HO + SWH,
    heuristic_stability(BT, Player, H, SWT, HP, NewHO).


heuristic_stability([], _, H, [], HP, HO) :-
    H is HP - HO.
