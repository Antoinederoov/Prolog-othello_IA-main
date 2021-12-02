stabilityWeights([4,  -3,  2,  2,  2,  2, -3,  4,
                   -3, -4, -1, -1, -1, -1, -4, -3,
                   2,  -1,  1,  0,  0,  1, -1,  2,
                   2,  -1,  0,  1,  1,  0, -1,  2,
                   2,  -1,  0,  1,  1,  0, -1,  2,
                   2,  -1,  1,  0,  0,  1, -1,  2,
                   -3, -4, -1, -1, -1, -1, -4, -3,
                   4,  -3,  2,  2,  2,  2, -3,  4]).


stability(Board, Player, H) :- 
    stabilityWeights(SW),
    stability(Board, Player, H, SW).

stability([BH|BT], Player, H, [SWH|SWT]) :-
    HP is 0,
    HO is 0,
    switchPlayer(Player, Opponent),
    (
        BH==Player -> (NewHP is HP + SW, stability(BT, Player, H, SWT, NewHP, HO));
        BH==Opponent -> (NewHO is HO + SWH, stability(BT, Player, H, SWT, HP, NewHO)).
    ).
    



stability([BH|BT], Player, H, [SWH|SWT], HP, HO) :-
    switchPlayer(Player, Opponent),
    (
        BH==Player -> (NewHP is HP + SW, stability(BT, Player, H, SWT, NewHP, HO));
        BH==Opponent -> (NewHO is HO + SWH, stability(BT, Player, H, SWT, HP, NewHO)).
    ).

stability([], _, H, [], HP, HO) :-
    H is HP - HO.
