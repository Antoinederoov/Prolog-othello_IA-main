% HEURISTIQUE RANDOM
    :- writeln ('Random heuristic has loaded').


    heuristic_random(Board, Player, H) :-
        allValidMoves(Board, Player, MoveList) ->
            length(MoveList, NbMoves),
        Upper is NbMoves - 1,
            random_between(0, Upper, Index),
            nth0(Index, MoveList, H).