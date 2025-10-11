% BNF.pl - Gramatica Libre de Contexto e Interface de Usuario
% Este archivo implementa la gramatica DCG y la interfaz del usuario

:- consult('Logic.pl').

% ========== GRAMATICA LIBRE DE CONTEXTO (DCG) ==========
% Definicion de la gramatica para analisis sintactico

% Oracion completa
oracion --> sintagma_nominal, sintagma_verbal.
oracion --> sintagma_verbal.
oracion --> interjeccion.

% Sintagma Nominal
sintagma_nominal --> determinante, nombre.
sintagma_nominal --> determinante, adjetivo, nombre.
sintagma_nominal --> nombre.
sintagma_nominal --> pronombre.

% Sintagma Verbal
sintagma_verbal --> verbo.
sintagma_verbal --> verbo, sintagma_nominal.
sintagma_verbal --> verbo, sintagma_preposicional.
sintagma_verbal --> verbo, adjetivo.
sintagma_verbal --> verbo, adverbio.
sintagma_verbal --> verbo, sintagma_nominal, sintagma_preposicional.

% Sintagma Preposicional
sintagma_preposicional --> preposicion, sintagma_nominal.
sintagma_preposicional --> preposicion, nombre.

% Componentes lexicos
determinante --> [X], {palabra(X, _, articulo)}.
determinante --> [X], {palabra(_, X, articulo)}.

nombre --> [X], {palabra(X, _, sustantivo)}.
nombre --> [X], {palabra(_, X, sustantivo)}.

verbo --> [X], {palabra(X, _, verbo)}.
verbo --> [X], {palabra(_, X, verbo)}.

adjetivo --> [X], {palabra(X, _, adjetivo)}.
adjetivo --> [X], {palabra(_, X, adjetivo)}.

adverbio --> [X], {palabra(X, _, adverbio)}.
adverbio --> [X], {palabra(_, X, adverbio)}.

pronombre --> [X], {palabra(X, _, pronombre)}.
pronombre --> [X], {palabra(_, X, pronombre)}.

preposicion --> [X], {palabra(X, _, preposicion)}.
preposicion --> [X], {palabra(_, X, preposicion)}.

conjuncion --> [X], {palabra(X, _, conjuncion)}.
conjuncion --> [X], {palabra(_, X, conjuncion)}.

interjeccion --> [X], {palabra(X, _, sustantivo), X = hola}.
interjeccion --> [X], {palabra(_, X, sustantivo), X = hello}.

% ========== ANALISIS Y TRADUCCION CON DCG ==========
% Analiza si una lista de palabras es una oracion valida
es_oracion_valida(Lista) :-
    oracion(Lista, []).

% Traduce usando analisis DCG
traducir_con_dcg(Entrada, Salida) :-
    oracion_a_lista(Entrada, ListaEntrada),
    (   es_oracion_valida(ListaEntrada)
    ->  traducir_auto(Entrada, Salida)
    ;   traducir_auto(Entrada, Salida)  % Traduce aunque no sea valida
    ).

% ========== INTERFACE DE USUARIO ==========
% Predicado principal para TransLogEI (Espanol a Ingles)
translog_ei :-
    writeln('==========================================='),
    writeln('   TransLogEI - Traductor Espanol-Ingles   '),
    writeln('==========================================='),
    writeln('Escribe oraciones en espanol (escribe "salir" para terminar)'),
    writeln(''),
    ciclo_traduccion_ei.

% Ciclo de traduccion Espanol -> Ingles
ciclo_traduccion_ei :-
    write('Usuario: '),
    read_line_to_string(user_input, Entrada),
    (   Entrada = "salir"
    ->  writeln('Hasta luego!')
    ;   Entrada = "exit"
    ->  writeln('Hasta luego!')
    ;   (   atom_string(EntradaAtom, Entrada),
            traducir_esp_a_ing(EntradaAtom, Salida),
            format('TransLogEI: ~w~n~n', [Salida]),
            ciclo_traduccion_ei
        )
    ).

% Predicado principal para TransLogIE (Ingles a Espanol)
translog_ie :-
    writeln('==========================================='),
    writeln('   TransLogIE - Traductor Ingles-Espanol   '),
    writeln('==========================================='),
    writeln('Write sentences in English (type "exit" to quit)'),
    writeln(''),
    ciclo_traduccion_ie.

% Ciclo de traduccion Ingles -> Espanol
ciclo_traduccion_ie :-
    write('User: '),
    read_line_to_string(user_input, Entrada),
    (   Entrada = "exit"
    ->  writeln('Goodbye!')
    ;   Entrada = "salir"
    ->  writeln('Goodbye!')
    ;   (   atom_string(EntradaAtom, Entrada),
            traducir_ing_a_esp(EntradaAtom, Salida),
            format('TransLogIE: ~w~n~n', [Salida]),
            ciclo_traduccion_ie
        )
    ).

% Predicado principal para TransLog (Auto-detecta idioma)
translog :-
    writeln('==========================================='),
    writeln('        TransLog - Traductor Bilingue      '),
    writeln('==========================================='),
    writeln('Escribe en espanol o ingles (escribe "salir"/"exit" para terminar)'),
    writeln(''),
    ciclo_traduccion_auto.

% Ciclo de traduccion automatica
ciclo_traduccion_auto :-
    write('Usuario/User: '),
    read_line_to_string(user_input, Entrada),
    (   (Entrada = "salir" ; Entrada = "exit")
    ->  writeln('Hasta luego! / Goodbye!')
    ;   (   atom_string(EntradaAtom, Entrada),
            oracion_a_lista(EntradaAtom, Lista),
            detectar_idioma(Lista, Idioma),
            (   Idioma = espanol
            ->  traducir_esp_a_ing(EntradaAtom, Salida),
                format('TransLog (EN): ~w~n~n', [Salida])
            ;   traducir_ing_a_esp(EntradaAtom, Salida),
                format('TransLog (ES): ~w~n~n', [Salida])
            ),
            ciclo_traduccion_auto
        )
    ).

% ========== PREDICADOS DE PRUEBA ==========
% Prueba la traduccion de una oracion
probar_traduccion_ei(Oracion) :-
    write('Entrada (ES): '), writeln(Oracion),
    traducir_esp_a_ing(Oracion, Traduccion),
    write('Salida (EN): '), writeln(Traduccion).

probar_traduccion_ie(Oracion) :-
    write('Entrada (EN): '), writeln(Oracion),
    traducir_ing_a_esp(Oracion, Traduccion),
    write('Salida (ES): '), writeln(Traduccion).

% ========== EJEMPLOS DE USO ==========
% Para ejecutar el sistema:
% ?- translog_ei.     % Para español a inglés
% ?- translog_ie.     % Para inglés a español
% ?- translog.        % Para auto-detección

% Ejemplos de prueba:
% ?- probar_traduccion_ei('hola').
% ?- probar_traduccion_ie('how are you').
% ?- probar_traduccion_ei('el gato come').

% ========== ANÁLISIS SINTÁCTICO ==========
% Analiza la estructura de una oración
analizar_oracion(OracionAtom) :-
    oracion_a_lista(OracionAtom, Lista),
    writeln('Análisis sintáctico:'),
    (   oracion(Lista, [])
    ->  writeln('✓ Oración válida'),
        analizar_componentes(Lista)
    ;   writeln('✗ Oración no válida según la gramática')
    ).

% Analiza los componentes de una oración
analizar_componentes(Lista) :-
    writeln('Componentes:'),
    (   sintagma_nominal(SN, []),
        append(SN, SV, Lista)
    ->  format('  - Sintagma Nominal: ~w~n', [SN]),
        format('  - Sintagma Verbal: ~w~n', [SV])
    ;   format('  - Oración completa: ~w~n', [Lista])
    ).

% ========== AYUDA ==========
mostrar_ayuda :-
    writeln(''),
    writeln('=== COMANDOS DISPONIBLES ==='),
    writeln('translog_ei.          - Inicia traductor Espanol->Ingles'),
    writeln('translog_ie.          - Inicia traductor Ingles->Espanol'),
    writeln('translog.             - Inicia traductor con auto-deteccion'),
    writeln('mostrar_ayuda.        - Muestra esta ayuda'),
    writeln(''),
    writeln('=== EJEMPLOS ==='),
    writeln('probar_traduccion_ei(\'hola\').'),
    writeln('probar_traduccion_ie(\'hello\').'),
    writeln('analizar_oracion(\'el gato come\').'),
    writeln('').

% Mensaje de bienvenida al cargar el archivo
:- initialization((
    writeln(''),
    writeln('==========================================='),
    writeln('       TransLog - Sistema Experto          '),
    writeln('      Traduccion Espanol - Ingles           '),
    writeln('==========================================='),
    writeln(''),
    writeln('Escribe "mostrar_ayuda." para ver los comandos disponibles.'),
    writeln('')
)).