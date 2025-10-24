% ======================================================================
% BNF.pl - Interfaz de Usuario
% ======================================================================

:- consult('BD.pl').
:- consult('Logic.pl').

% ----------------------------------------------------------------------
% ESTADO DE CONVERSACIÓN (para repetir última oración)
% ----------------------------------------------------------------------
:- dynamic ultima_entrada/1.
:- dynamic ultima_traduccion/1.

guardar_entrada(Entrada) :-
    retractall(ultima_entrada(_)),
    assert(ultima_entrada(Entrada)).

guardar_traduccion(Traduccion) :-
    retractall(ultima_traduccion(_)),
    assert(ultima_traduccion(Traduccion)).

% ----------------------------------------------------------------------
% INTERFAZ TRANSLOGEI (Español -> Inglés)
% ----------------------------------------------------------------------

translogei :-
    writeln('=============================================='),
    writeln('    TransLogEI - Traductor Español a Inglés'),
    writeln('=============================================='),
    writeln('Escriba oraciones en español para traducir.'),
    writeln('Para salir, escriba: salir'),
    writeln('=============================================='),
    nl,
    ciclo_translogei.

ciclo_translogei :-
    write('Usuario: '),
    read_line_to_string(user_input, Input),
    atom_string(InputAtom, Input),
    (InputAtom == salir ->
        writeln('¡Hasta luego!')
    ;
        procesar_entrada_es_en(InputAtom),
        nl,
        ciclo_translogei
    ).

procesar_entrada_es_en(Entrada) :-
    downcase_atom(Entrada, EntradaLower),

    % Verificar comandos especiales de continuidad
    (manejar_continuidad_es(EntradaLower) ->
        true
    ;
        % Guardar entrada actual
        guardar_entrada(Entrada),

        % Verificar expresiones comunes
        (expresion(EntradaLower, Traduccion) ->
            capitalizar(Traduccion, TraduccionCapital),
            format('TransLogEI: ~w~n', [TraduccionCapital]),
            guardar_traduccion(TraduccionCapital)
        ;
            % Intentar traducción
            (traducir_espanol_ingles(Entrada, Traduccion) ->
                format('TransLogEI: ~w~n', [Traduccion]),
                guardar_traduccion(Traduccion)
            ;
                % Mensaje conversacional de error
                respuesta_no_entiendo_es,
                guardar_traduccion('(no traducido)')
            )
        )
    ).

% Manejar comandos de continuidad
manejar_continuidad_es(Entrada) :-
    (member(Entrada, [repite, repitelo, 'otra vez', 'de nuevo', 'no entendi', 'que dijiste']) ->
        (ultima_traduccion(Trad) ->
            format('TransLogEI: ~w~n', [Trad])
        ;
            writeln('TransLogEI: No hay traducción previa que repetir.')
        )
    ; fail
    ).

% Respuestas conversacionales cuando no entiende
respuesta_no_entiendo_es :-
    random_member(Respuesta, [
        'TransLogEI: No entendí esa oración. ¿Podrías reformularla?',
        'TransLogEI: Disculpa, no pude traducir eso. ¿Me lo repites de otra forma?',
        'TransLogEI: No reconozco esa estructura. Intenta con oraciones más simples.',
        'TransLogEI: Sorry, I could not understand that sentence. Could you rephrase it?'
    ]),
    writeln(Respuesta).

% ----------------------------------------------------------------------
% INTERFAZ TRANSLOGIE (Inglés -> Español)
% ----------------------------------------------------------------------

translogie :-
    writeln('=============================================='),
    writeln('    TransLogIE - Traductor Inglés a Español'),
    writeln('=============================================='),
    writeln('Escriba oraciones en inglés para traducir.'),
    writeln('Para salir, escriba: exit'),
    writeln('=============================================='),
    nl,
    ciclo_translogie.

ciclo_translogie :-
    write('Usuario: '),
    read_line_to_string(user_input, Input),
    atom_string(InputAtom, Input),
    (InputAtom == exit ->
        writeln('Goodbye!')
    ;
        procesar_entrada_en_es(InputAtom),
        nl,
        ciclo_translogie
    ).

procesar_entrada_en_es(Entrada) :-
    downcase_atom(Entrada, EntradaLower),

    % Verificar comandos especiales de continuidad
    (manejar_continuidad_en(EntradaLower) ->
        true
    ;
        % Guardar entrada actual
        guardar_entrada(Entrada),

        % Verificar expresiones comunes
        (expresion(Traduccion, EntradaLower) ->
            capitalizar(Traduccion, TraduccionCapital),
            format('TransLogIE: ~w~n', [TraduccionCapital]),
            guardar_traduccion(TraduccionCapital)
        ;
            % Intentar traducción
            (traducir_ingles_espanol(Entrada, Traduccion) ->
                format('TransLogIE: ~w~n', [Traduccion]),
                guardar_traduccion(Traduccion)
            ;
                % Mensaje conversacional de error
                respuesta_no_entiendo_en,
                guardar_traduccion('(not translated)')
            )
        )
    ).

% Manejar comandos de continuidad en inglés
manejar_continuidad_en(Entrada) :-
    (member(Entrada, [repeat, 'say it again', 'one more time', 'i did not understand', 'what did you say']) ->
        (ultima_traduccion(Trad) ->
            format('TransLogIE: ~w~n', [Trad])
        ;
            writeln('TransLogIE: There is no previous translation to repeat.')
        )
    ; fail
    ).

% Respuestas conversacionales cuando no entiende (inglés)
respuesta_no_entiendo_en :-
    random_member(Respuesta, [
        'TransLogIE: I did not understand that sentence. Could you rephrase it?',
        'TransLogIE: Sorry, I could not translate that. Could you say it differently?',
        'TransLogIE: I do not recognize that structure. Try simpler sentences.',
        'TransLogIE: Disculpa, no pude entender esa oración. ¿Podrías reformularla?'
    ]),
    writeln(Respuesta).

% ----------------------------------------------------------------------
% INTERFAZ TRANSLOG (Detección automática)
% ----------------------------------------------------------------------

translog :-
    writeln('=============================================='),
    writeln('         TransLog - Traductor Bilingüe'),
    writeln('=============================================='),
    writeln('Escriba oraciones en español o inglés.'),
    writeln('El sistema detectará el idioma automáticamente.'),
    writeln(''),
    writeln('Comandos especiales:'),
    writeln('  - "repite" / "repeat": repetir última traducción'),
    writeln('  - "salir" / "exit": salir del programa'),
    writeln('=============================================='),
    nl,
    ciclo_translog.

ciclo_translog :-
    write('Usuario: '),
    read_line_to_string(user_input, Input),
    atom_string(InputAtom, Input),
    ((InputAtom == salir ; InputAtom == exit) ->
        writeln('¡Hasta luego! / Goodbye!')
    ;
        procesar_entrada_auto(InputAtom),
        nl,
        ciclo_translog
    ).

procesar_entrada_auto(Entrada) :-
    downcase_atom(Entrada, EntradaLower),

    % Verificar comandos de continuidad
    (manejar_continuidad_auto(EntradaLower) ->
        true
    ;
        % Detectar idioma y procesar
        (detectar_idioma(Entrada, espanol) ->
            procesar_entrada_es_en(Entrada)
        ;
            procesar_entrada_en_es(Entrada)
        )
    ).

% Manejar continuidad en modo automático
manejar_continuidad_auto(Entrada) :-
    (member(Entrada, [repite, repitelo, repeat, 'otra vez', 'again']) ->
        (ultima_traduccion(Trad) ->
            format('TransLog: ~w~n', [Trad])
        ;
            writeln('TransLog: No hay traducción previa. / No previous translation.')
        )
    ; fail
    ).

% Detectar idioma
detectar_idioma(Entrada, Idioma) :-
    normalizar_texto(Entrada, TextoNorm),
    dividir_en_palabras(TextoNorm, Palabras),
    contar_palabras_idioma(Palabras, CountES, CountEN),
    (CountES >= CountEN ->
        Idioma = espanol
    ;
        Idioma = ingles
    ).

contar_palabras_idioma([], 0, 0).
contar_palabras_idioma([P|Resto], CountES, CountEN) :-
    contar_palabras_idioma(Resto, RestCountES, RestCountEN),
    (traducir_palabra(P, _) ->
        CountES is RestCountES + 1,
        CountEN = RestCountEN
    ; traducir_palabra_inv(P, _) ->
        CountEN is RestCountEN + 1,
        CountES = RestCountES
    ;
        CountES = RestCountES,
        CountEN = RestCountEN
    ).

% ----------------------------------------------------------------------
% UTILIDADES DE TESTING
% ----------------------------------------------------------------------

test_es_en(Texto) :-
    writeln('--- Test Español -> Inglés ---'),
    format('Entrada: ~w~n', [Texto]),
    (traducir_espanol_ingles(Texto, Traduccion) ->
        format('Salida:  ~w~n', [Traduccion])
    ;
        writeln('Error: No se pudo traducir.')
    ).

test_en_es(Texto) :-
    writeln('--- Test Inglés -> Español ---'),
    format('Entrada: ~w~n', [Texto]),
    (traducir_ingles_espanol(Texto, Traduccion) ->
        format('Salida:  ~w~n', [Traduccion])
    ;
        writeln('Error: No se pudo traducir.')
    ).

ejecutar_pruebas :-
    writeln('=============================================='),
    writeln('       Batería de Pruebas - TransLog'),
    writeln('=============================================='),
    nl,

    test_es_en('Hola'),
    nl,
    test_es_en('El gato es grande'),
    nl,
    test_es_en('El carro es rojo'),
    nl,
    test_es_en('Yo soy viejo'),
    nl,
    test_es_en('Yo no soy viejo'),
    nl,
    test_es_en('El esta feliz'),
    nl,
    test_es_en('El no esta feliz'),
    nl,

    test_en_es('Hello'),
    nl,
    test_en_es('The big cat'),
    nl,
    test_en_es('I am old'),
    nl,
    test_en_es('I am not old'),
    nl,
    test_en_es('The car is red'),
    nl,

    writeln('=============================================='),
    writeln('       Pruebas Completadas'),
    writeln('==============================================').

% ----------------------------------------------------------------------
% AYUDA
% ----------------------------------------------------------------------

ayuda :-
    writeln('=============================================='),
    writeln('           Comandos TransLog'),
    writeln('=============================================='),
    writeln('translogei.          - Iniciar traductor ES->EN'),
    writeln('translogie.          - Iniciar traductor EN->ES'),
    writeln('translog.            - Traductor con detección auto'),
    writeln(''),
    writeln('Durante la conversación:'),
    writeln('  repite/repeat      - Repetir última traducción'),
    writeln('  otra vez/again     - Repetir última traducción'),
    writeln('  salir/exit         - Salir del programa'),
    writeln(''),
    writeln('Testing:'),
    writeln('ejecutar_pruebas.    - Ejecutar tests'),
    writeln('test_es_en(Texto).   - Probar traducción ES->EN'),
    writeln('test_en_es(Texto).   - Probar traducción EN->ES'),
    writeln('ayuda.               - Mostrar esta ayuda'),
    writeln('==============================================').

% Mensaje de bienvenida
:- writeln('=============================================='),
   writeln('     Sistema TransLog cargado exitosamente'),
   writeln('=============================================='),
   writeln('Para comenzar, escriba: translog.'),
   writeln('Para ver comandos: ayuda.'),
   writeln('=============================================='),
   nl.

