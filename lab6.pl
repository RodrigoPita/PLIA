% 1) Crie um predicado range( X, Y, L ) p/ gerar uma lista L com todos os inteiros no intervalo entre X e Y
% Exemplo: 
% ?_ range( 3, 8, L ).
% L = [ 3, 4, 5, 6, 7, 8 ]

range( X, X, [X] ):- !.
range( X, Y, [X|T] ):- X < Y, !, X1 is X + 1, range( X1, Y, T ).
range( X, Y, [X|T] ):- X1 is X - 1, range( X1, Y, T ).

% 2) Crie um predicado dup( L1, N, L2 ) que duplica N vezes cada elemento da lista L1, produzindo a lista L2
% Exemplo:
% ?_ dup( [ a, c, d ], 3, L ).
% L = [ a, a, a, c, c, c, d, d, d ]

conc( [], L, L ).
conc( [X|T1], L2, [X|T3] ):- conc( T1, L2, T3 ).

multi( _, 0, [] ):- !.
multi( X, N, [X|T] ):- N1 is N - 1, multi( X, N1, T ).
 
dup([], _, [] ):- !.
dup( [X|T], N, L ):- multi( X, N, Lx ), dup( T, N, L1 ), conc( Lx, L1, L ).

% 3) Crie um predicado primo( N ) que eh verdade se N eh um numero primo
% Exemplo:
% ?_ primo( 13 ).
% True

composto( N ):- N1 is ceil( sqrt( N ) ), range( 2, N1, L ), member( X, L ), 0 is N mod X.
primo( N ):- not( composto( N ) ).

% 4) Crie um predicado compress( L1, L2 ) para eliminar duplicatas consecutivas de elementos de uma lista L1, produzindo uma lista L2
% Exemplo:
% ?_ compress( [ a, a, a, a, b, c, c, c, d, d ], L ).
% L = [ a, b, c, d ]

compress( [X], [X] ).
compress( [X, X|T], L ):- compress( [X|T], L ), !.
compress( [X, Y|T], [X|L] ):- X \= Y, compress( [Y|T], L ).

% 5) Crie um predicado pack( L1, L2 ), para empacotar os elementos consecutivos da lista L1 em listas separadas na lista L2
% Exemplo:
% ?_ pack( [ a, a, a, b, b, c, c, c ], L ).
% L = [ [ a, a, a ], [ b, b ], [ c, c, c ] ]

ultimo( [X], X ).
ultimo( [_|T], U ) :- ultimo( T,U ).

pack( L1, Final ):- conc( Ini, Resto, L1 ), compress( Ini, [_] ), ultimo( Ini, U ), Resto = [X|_], U \= X, !, pack( Resto, Resto2 ), Final = [Ini|Resto2].
pack( L, [L] ):- !.

% Crie um predicado removePos( L1, N, R, L2 ) que remove o N-esimo elemento R da lista L1 produzindo a lista L2
% Exemplo:
% ?_ removePos( [ a, b, c, d ], 3, X, L ).
% X = c
% L = [ a, b, d ]