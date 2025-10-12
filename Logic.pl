% Logic.pl - Reglas de Traduccion usando DCG
% Este archivo implementa la logica de traduccion basada en analisis sintactico

:- consult('BD.pl').

% ===============================================
% ESTRUCTURAS DE DATOS
% ===============================================
% oracion(SN, SV) - Representa una oracion completa
%   SN = sintagma_nominal(...)
%   SV = sintagma_verbal(...)
%
% sintagma_nominal(Componentes)
%   Ejemplos:
%   - sn([det(el), nom(gato)])
%   - sn([det(el), adj(grande), nom(gato)])
%   - sn([pron(yo)])
%
% sintagma_verbal(Componentes)
%   Ejemplos:
%   - sv([v(come)])
%   - sv([v(come), sn([det(el), nom(pescado)])])
%   - sv([v(esta), sp([prep(en), sn([det(la), nom(casa)])])])
%
% sintagma_preposicional(prep, sn)
%   - sp([prep(en), sn([det(la), nom(casa)])])

% ===============================================
% DETECCION DE IDIOMA
% ===============================================
% Detecta si una lista de palabras esta en espanol o ingles
detectar_idioma([], espanol).
detectar_idioma([P|_], espanol) :- palabra(P, _, _), !.
detectar_idioma([P|_], ingles)  :- palabra(_, P, _), !.
detectar_idioma([_|R], Idioma)  :- detectar_idioma(R, Idioma).

% ===============================================
% NORMALIZACION Y CONVERSION
% ===============================================
% Normaliza una palabra: minusculas y sin puntuacion
normalizar_palabra(P, N) :-
    atom(P),
    downcase_atom(P, M),
    atom_chars(M, Ch),
    eliminar_puntuacion(Ch, Limp),
    atom_chars(N, Limp).

eliminar_puntuacion([], []).
eliminar_puntuacion([C|R], [C|R2]) :- 
    char_type(C, alpha), !, 
    eliminar_puntuacion(R, R2).
eliminar_puntuacion([C|R], [C|R2]) :- 
    char_type(C, space), !, 
    eliminar_puntuacion(R, R2).
eliminar_puntuacion([_|R], R2) :- 
    eliminar_puntuacion(R, R2).

% Convierte una oracion (atom) a lista de palabras
oracion_a_lista(O, L) :- 
    atom(O), 
    atomic_list_concat(Ps, ' ', O), 
    maplist(normalizar_palabra, Ps, L).

% Convierte lista de palabras a oracion (atom)
lista_a_oracion([], '').
lista_a_oracion([P], P) :- !.
lista_a_oracion([P|R], O) :- 
    lista_a_oracion(R, OR), 
    atomic_list_concat([P, OR], ' ', O).

% Capitaliza la primera letra de una oracion
capitalizar_oracion(O, OC) :-
    O \= '',
    atom_chars(O, [X|R]),
    upcase_atom(X, XU),
    atom_chars(XU, [XUC]),
    atom_chars(OC, [XUC|R]), !.
capitalizar_oracion(O, O).

% ===============================================
% ANALISIS SINTACTICO CON DCG
% ===============================================
% Analiza una oracion y devuelve su estructura sintactica

% Oracion completa: SN + SV o solo SV o interjeccion
analizar_oracion_dcg(Lista, oracion(SN, SV)) :-
    append(L1, L2, Lista),
    L1 \= [], L2 \= [],
    parsear_sn(L1, SN),
    parsear_sv(L2, SV), !.

analizar_oracion_dcg(Lista, oracion(vacio, SV)) :-
    parsear_sv(Lista, SV), !.

analizar_oracion_dcg([hola], interjeccion(hola)) :- !.
analizar_oracion_dcg([hello], interjeccion(hello)) :- !.

% Parsear Sintagma Nominal
parsear_sn([Det, Nom], sn([det(Det), nom(Nom)])) :-
    palabra(Det, _, articulo),
    palabra(Nom, _, sustantivo), !.

parsear_sn([Det, Adj, Nom], sn([det(Det), adj(Adj), nom(Nom)])) :-
    palabra(Det, _, articulo),
    palabra(Adj, _, adjetivo),
    palabra(Nom, _, sustantivo), !.

parsear_sn([Nom], sn([nom(Nom)])) :-
    palabra(Nom, _, sustantivo), !.

parsear_sn([Pron], sn([pron(Pron)])) :-
    palabra(Pron, _, pronombre), !.

% Parsear Sintagma Verbal
parsear_sv([V], sv([v(V)])) :-
    palabra(V, _, verbo), !.

parsear_sv(Lista, sv([v(V), SN])) :-
    Lista = [V|Resto],
    palabra(V, _, verbo),
    parsear_sn(Resto, SN), !.

parsear_sv(Lista, sv([v(V), SP])) :-
    Lista = [V|Resto],
    palabra(V, _, verbo),
    parsear_sp(Resto, SP), !.

parsear_sv(Lista, sv([v(V), Comp])) :-
    Lista = [V, Palabra|_],
    palabra(V, _, verbo),
    (palabra(Palabra, _, adjetivo) -> Comp = adj(Palabra)
    ; palabra(Palabra, _, adverbio) -> Comp = adv(Palabra)
    ; fail), !.

% Parsear Sintagma Preposicional
parsear_sp([Prep|Resto], sp([prep(Prep), SN])) :-
    palabra(Prep, _, preposicion),
    parsear_sn(Resto, SN), !.

parsear_sp([Prep, Nom], sp([prep(Prep), nom(Nom)])) :-
    palabra(Prep, _, preposicion),
    palabra(Nom, _, sustantivo), !.

% ===============================================
% TRADUCCION DE ESTRUCTURAS
% ===============================================
% Traduce una estructura sintactica de un idioma a otro

% Traducir oracion completa
traducir_estructura(oracion(SN, SV), espanol, ingles, oracion(SNen, SVen)) :-
    traducir_sn(SN, espanol, ingles, SNen),
    traducir_sv(SV, espanol, ingles, SVen).

traducir_estructura(oracion(SN, SV), ingles, espanol, oracion(SNes, SVes)) :-
    traducir_sn(SN, ingles, espanol, SNes),
    traducir_sv(SV, ingles, espanol, SVes).

traducir_estructura(interjeccion(hola), espanol, ingles, interjeccion(hello)).
traducir_estructura(interjeccion(hello), ingles, espanol, interjeccion(hola)).

% Traducir Sintagma Nominal
traducir_sn(vacio, _, _, vacio) :- !.

traducir_sn(sn(Componentes), Origen, Destino, sn(ComponentesTraducidos)) :-
    traducir_componentes_sn(Componentes, Origen, Destino, ComponentesTraducidos).

% Traducir componentes de SN
traducir_componentes_sn([], _, _, []).

traducir_componentes_sn([det(D)|R], espanol, ingles, [det(Den)|R2]) :-
    palabra(D, Den, articulo), !,
    traducir_componentes_sn(R, espanol, ingles, R2).

traducir_componentes_sn([det(D)|R], ingles, espanol, [det(Des)|R2]) :-
    palabra(Des, D, articulo), !,
    traducir_componentes_sn(R, ingles, espanol, R2).

traducir_componentes_sn([nom(N)|R], espanol, ingles, [nom(Nen)|R2]) :-
    palabra(N, Nen, sustantivo), !,
    traducir_componentes_sn(R, espanol, ingles, R2).

traducir_componentes_sn([nom(N)|R], ingles, espanol, [nom(Nes)|R2]) :-
    palabra(Nes, N, sustantivo), !,
    traducir_componentes_sn(R, ingles, espanol, R2).

traducir_componentes_sn([adj(A)|R], espanol, ingles, [adj(Aen)|R2]) :-
    palabra(A, Aen, adjetivo), !,
    traducir_componentes_sn(R, espanol, ingles, R2).

traducir_componentes_sn([adj(A)|R], ingles, espanol, [adj(Aes)|R2]) :-
    palabra(Aes, A, adjetivo), !,
    traducir_componentes_sn(R, ingles, espanol, R2).

traducir_componentes_sn([pron(P)|R], espanol, ingles, [pron(Pen)|R2]) :-
    palabra(P, Pen, pronombre), !,
    traducir_componentes_sn(R, espanol, ingles, R2).

traducir_componentes_sn([pron(P)|R], ingles, espanol, [pron(Pes)|R2]) :-
    palabra(Pes, P, pronombre), !,
    traducir_componentes_sn(R, ingles, espanol, R2).

traducir_componentes_sn([H|R], O, D, [H|R2]) :-
    traducir_componentes_sn(R, O, D, R2).

% Traducir Sintagma Verbal
traducir_sv(sv(Componentes), Origen, Destino, sv(ComponentesTraducidos)) :-
    traducir_componentes_sv(Componentes, Origen, Destino, ComponentesTraducidos).

% Traducir componentes de SV
traducir_componentes_sv([], _, _, []).

traducir_componentes_sv([v(V)|R], espanol, ingles, [v(Ven)|R2]) :-
    palabra(V, Ven, verbo), !,
    traducir_componentes_sv(R, espanol, ingles, R2).

traducir_componentes_sv([v(V)|R], ingles, espanol, [v(Ves)|R2]) :-
    palabra(Ves, V, verbo), !,
    traducir_componentes_sv(R, ingles, espanol, R2).

traducir_componentes_sv([SN|R], O, D, [SNt|R2]) :-
    SN = sn(_),
    traducir_sn(SN, O, D, SNt), !,
    traducir_componentes_sv(R, O, D, R2).

traducir_componentes_sv([SP|R], O, D, [SPt|R2]) :-
    SP = sp(_),
    traducir_sp(SP, O, D, SPt), !,
    traducir_componentes_sv(R, O, D, R2).

traducir_componentes_sv([adj(A)|R], espanol, ingles, [adj(Aen)|R2]) :-
    palabra(A, Aen, adjetivo), !,
    traducir_componentes_sv(R, espanol, ingles, R2).

traducir_componentes_sv([adj(A)|R], ingles, espanol, [adj(Aes)|R2]) :-
    palabra(Aes, A, adjetivo), !,
    traducir_componentes_sv(R, ingles, espanol, R2).

traducir_componentes_sv([adv(A)|R], espanol, ingles, [adv(Aen)|R2]) :-
    palabra(A, Aen, adverbio), !,
    traducir_componentes_sv(R, espanol, ingles, R2).

traducir_componentes_sv([adv(A)|R], ingles, espanol, [adv(Aes)|R2]) :-
    palabra(Aes, A, adverbio), !,
    traducir_componentes_sv(R, ingles, espanol, R2).

traducir_componentes_sv([H|R], O, D, [H|R2]) :-
    traducir_componentes_sv(R, O, D, R2).

% Traducir Sintagma Preposicional
traducir_sp(sp(Componentes), Origen, Destino, sp(ComponentesTraducidos)) :-
    traducir_componentes_sp(Componentes, Origen, Destino, ComponentesTraducidos).

traducir_componentes_sp([], _, _, []).

traducir_componentes_sp([prep(P)|R], espanol, ingles, [prep(Pen)|R2]) :-
    palabra(P, Pen, preposicion), !,
    traducir_componentes_sp(R, espanol, ingles, R2).

traducir_componentes_sp([prep(P)|R], ingles, espanol, [prep(Pes)|R2]) :-
    palabra(Pes, P, preposicion), !,
    traducir_componentes_sp(R, ingles, espanol, R2).

traducir_componentes_sp([SN|R], O, D, [SNt|R2]) :-
    SN = sn(_),
    traducir_sn(SN, O, D, SNt), !,
    traducir_componentes_sp(R, O, D, R2).

traducir_componentes_sp([nom(N)|R], espanol, ingles, [nom(Nen)|R2]) :-
    palabra(N, Nen, sustantivo), !,
    traducir_componentes_sp(R, espanol, ingles, R2).

traducir_componentes_sp([nom(N)|R], ingles, espanol, [nom(Nes)|R2]) :-
    palabra(Nes, N, sustantivo), !,
    traducir_componentes_sp(R, ingles, espanol, R2).

traducir_componentes_sp([H|R], O, D, [H|R2]) :-
    traducir_componentes_sp(R, O, D, R2).

% ===============================================
% GENERACION DE ORACIONES DESDE ESTRUCTURA
% ===============================================
% Convierte una estructura sintactica de vuelta a lista de palabras

generar_oracion_desde_estructura(interjeccion(Palabra), [Palabra]) :- !.

generar_oracion_desde_estructura(oracion(SN, SV), Lista) :-
    generar_sn(SN, ListaSN),
    generar_sv(SV, ListaSV),
    append(ListaSN, ListaSV, Lista).

% Generar palabras desde SN
generar_sn(vacio, []) :- !.
generar_sn(sn(Componentes), Lista) :-
    generar_componentes(Componentes, Lista).

% Generar palabras desde SV
generar_sv(sv(Componentes), Lista) :-
    generar_componentes(Componentes, Lista).

% Generar palabras desde SP
generar_sp(sp(Componentes), Lista) :-
    generar_componentes(Componentes, Lista).

% Generar componentes genericos
generar_componentes([], []).

generar_componentes([det(D)|R], [D|R2]) :-
    generar_componentes(R, R2).

generar_componentes([nom(N)|R], [N|R2]) :-
    generar_componentes(R, R2).

generar_componentes([adj(A)|R], [A|R2]) :-
    generar_componentes(R, R2).

generar_componentes([v(V)|R], [V|R2]) :-
    generar_componentes(R, R2).

generar_componentes([pron(P)|R], [P|R2]) :-
    generar_componentes(R, R2).

generar_componentes([prep(P)|R], [P|R2]) :-
    generar_componentes(R, R2).

generar_componentes([adv(A)|R], [A|R2]) :-
    generar_componentes(R, R2).

generar_componentes([SN|R], Lista) :-
    SN = sn(_),
    generar_sn(SN, L1),
    generar_componentes(R, L2),
    append(L1, L2, Lista).

generar_componentes([SV|R], Lista) :-
    SV = sv(_),
    generar_sv(SV, L1),
    generar_componentes(R, L2),
    append(L1, L2, Lista).

generar_componentes([SP|R], Lista) :-
    SP = sp(_),
    generar_sp(SP, L1),
    generar_componentes(R, L2),
    append(L1, L2, Lista).

% ===============================================
% AJUSTES POST-TRADUCCION
% ===============================================
% Ajustes necesarios para corregir genero, articulos, orden, etc.

% Ajustar orden de adjetivos (ingles: adj antes de nom, espanol: despues)
ajustar_orden_ingles([], []).
ajustar_orden_ingles([Nom, Adj|R], [Adj, Nom|R2]) :-
    palabra(_, Nom, sustantivo),
    palabra(_, Adj, adjetivo), !,
    ajustar_orden_ingles(R, R2).
ajustar_orden_ingles([H|R], [H|R2]) :-
    ajustar_orden_ingles(R, R2).

ajustar_orden_espanol([], []).
ajustar_orden_espanol([Adj, Nom|R], [Nom, Adj|R2]) :-
    palabra(Adj, _, adjetivo),
    palabra(Nom, _, sustantivo), !,
    ajustar_orden_espanol(R, R2).
ajustar_orden_espanol([H|R], [H|R2]) :-
    ajustar_orden_espanol(R, R2).

% Ajustar genero de articulos en espanol
femenino(casa). femenino(mesa). femenino(silla). femenino(computadora).
femenino(mujer). femenino(familia). femenino(escuela). femenino(universidad).
femenino(ciudad). femenino(mano). femenino(agua).

ajustar_genero_articulos([], []).
ajustar_genero_articulos([el, N|R], [la, N|R2]) :-
    femenino(N), !,
    ajustar_genero_articulos(R, R2).
ajustar_genero_articulos([un, N|R], [una, N|R2]) :-
    femenino(N), !,
    ajustar_genero_articulos(R, R2).
ajustar_genero_articulos([H|R], [H|R2]) :-
    ajustar_genero_articulos(R, R2).

% Agregar signos de interrogacion
agregar_interrogacion(Lista, ListaConSigno) :-
    (member(how, Lista) ; member(what, Lista) ; member(where, Lista)),
    append(Lista, ['?'], ListaConSigno), !.
agregar_interrogacion(Lista, Lista).

% ===============================================
% FUNCIONES PRINCIPALES DE TRADUCCION
% ===============================================

% ALGORITMO DE TRADUCCION ESPANOL -> INGLES
% Paso 1: Convertir oracion a lista de palabras
% Paso 2: Analizar sintacticamente con DCG (parsear a estructura)
% Paso 3: Traducir la estructura sintactica
% Paso 4: Generar lista de palabras desde estructura traducida
% Paso 5: Ajustar orden y detalles especificos del idioma destino
% Paso 6: Convertir lista a oracion y capitalizar

traducir_esp_a_ing(OracionEsp, OracionIng) :-
    % Paso 1: Tokenizar
    oracion_a_lista(OracionEsp, ListaEsp),
    
    % Paso 2: Analisis sintactico
    (analizar_oracion_dcg(ListaEsp, Estructura) ->
        % Paso 3: Traduccion de estructura
        traducir_estructura(Estructura, espanol, ingles, EstructuraEn),
        
        % Paso 4: Generacion
        generar_oracion_desde_estructura(EstructuraEn, ListaEn0)
    ;
        % Fallback: traduccion palabra por palabra si no se puede parsear
        traducir_lista_simple(ListaEsp, espanol, ingles, ListaEn0)
    ),
    
    % Paso 5: Ajustes post-traduccion
    ajustar_orden_ingles(ListaEn0, ListaEn1),
    agregar_interrogacion(ListaEn1, ListaEn2),
    
    % Paso 6: Generar oracion final
    lista_a_oracion(ListaEn2, OracionSinCap),
    capitalizar_oracion(OracionSinCap, OracionIng).

% ALGORITMO DE TRADUCCION INGLES -> ESPANOL
traducir_ing_a_esp(OracionIng, OracionEsp) :-
    % Paso 1: Tokenizar
    oracion_a_lista(OracionIng, ListaIng),
    
    % Paso 2: Analisis sintactico
    (analizar_oracion_dcg(ListaIng, Estructura) ->
        % Paso 3: Traduccion de estructura
        traducir_estructura(Estructura, ingles, espanol, EstructuraEs),
        
        % Paso 4: Generacion
        generar_oracion_desde_estructura(EstructuraEs, ListaEs0)
    ;
        % Fallback: traduccion palabra por palabra
        traducir_lista_simple(ListaIng, ingles, espanol, ListaEs0)
    ),
    
    % Paso 5: Ajustes post-traduccion
    ajustar_orden_espanol(ListaEs0, ListaEs1),
    ajustar_genero_articulos(ListaEs1, ListaEs2),
    
    % Paso 6: Generar oracion final
    lista_a_oracion(ListaEs2, OracionSinCap),
    capitalizar_oracion(OracionSinCap, OracionEsp).

% Traduccion simple palabra por palabra (fallback)
traducir_lista_simple([], _, _, []).
traducir_lista_simple([P|R], espanol, ingles, [T|R2]) :-
    (palabra(P, T, _) -> true ; T = P),
    traducir_lista_simple(R, espanol, ingles, R2).
traducir_lista_simple([P|R], ingles, espanol, [T|R2]) :-
    (palabra(T, P, _) -> true ; T = P),
    traducir_lista_simple(R, ingles, espanol, R2).

% Traduccion con auto-deteccion de idioma
traducir_auto(Entrada, Salida) :-
    oracion_a_lista(Entrada, Lista),
    detectar_idioma(Lista, Idioma),
    (Idioma = espanol ->
        traducir_esp_a_ing(Entrada, Salida)
    ;
        traducir_ing_a_esp(Entrada, Salida)
    ).

% ===============================================
% PREDICADOS DE ANALISIS Y DEBUG
% ===============================================

% Muestra la estructura sintactica de una oracion
analizar_y_mostrar(Oracion) :-
    oracion_a_lista(Oracion, Lista),
    write('Lista de palabras: '), writeln(Lista),
    (analizar_oracion_dcg(Lista, Estructura) ->
        write('Estructura sintactica: '), writeln(Estructura)
    ;
        writeln('No se pudo analizar la oracion')
    ).

% Descompone una oracion en sintagma nominal y verbal
descomponer_oracion(Oracion, SN, SV) :-
    oracion_a_lista(Oracion, Lista),
    analizar_oracion_dcg(Lista, oracion(SNest, SVest)),
    generar_sn(SNest, SN),
    generar_sv(SVest, SV).