% MIX HEURISTICS

    :- writeln('Mix Heuristic has loaded.').

    %Board est le plateau actuel
    % P1 is the current player while P2 is the enemy

    heuristic_mix(Board, P1, P2, H) :-
    heuristic_mix_compute(Board, P1, P2, H).

    %heuristic_mix_compute(_,_,0,H):- H is 0.
heuristic_mix_compute(Board,P1,P2,H):-
    heuristic_actual_mobility(Board, P1, P2, H1),
    heuristic_cornersCaptured(Board, P1, P2, H2),
    heuristic_stability(Board, P1, P2, H3),
    heuristic_coin_parity(Board, P1, P2, H4),
    H is 0.07 * H1
    +0.8 * H2
    +0.07 * H3
    +0.06 * H4.