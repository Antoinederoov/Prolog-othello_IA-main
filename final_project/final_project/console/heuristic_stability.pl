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
    HP is 0,
        HO is 0,
            heuristic_stability(Board, Player, Opponent, SW, HP, HO, H).


                heuristic_stability([Player|BT], Player, Opponent, [SWH|SWT], HP, HO, H) :-
    NewHP is HP + SWH,
        heuristic_stability(BT, Player, Opponent, SWT, NewHP, HO, H).


            heuristic_stability([Opponent|BT], Player, Opponent, [SWH|SWT], HP, HO, H) :-
    NewHO is HO + SWH,
        heuristic_stability(BT, Player, Opponent, SWT, HP, NewHO, H).

            heuristic_stability([_|BT], Player, Opponent, [_|SWT], HP, HO, H) :-
    heuristic_stability(BT, Player, Opponent, SWT, HP, HO, H).

    heuristic_stability([], _, _, [], HP, HO, H) :-
    H is HP - HO.