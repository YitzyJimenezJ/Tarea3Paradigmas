% BNF.pl - Gramatica Libre de Contexto (DCG) e Interfaz de Usuario
% Este archivo define la gramatica DCG y proporciona la interfaz interactiva

:- consult('Logic.pl').

% ===============================================
% GRAMATICA LIBRE DE CONTEXTO (DCG)
% ===============================================
% Define las reglas gramaticales en formato DCG
% Estas reglas se usan para el analisis sintactico

% Oracion: puede ser SN + SV, solo SV, o una interjeccion
oracion(oracion(SN, SV)) --> sintagma_nominal(SN), sintagma_verbal(SV).
oracion(oracion(vacio, SV)) --> sintagma_verbal(SV).
oracion(interjeccion(hola)) --> [hola].
oracion(interjeccion(hello)) --> [hello].

% Sintagma Nominal: determinante + nombre, con o sin adjetivo, o solo pronombre
sintagma_nominal(sn([det(Det), nom(Nom)])) --> 
    determinante(Det), nombre(Nom).

sintagma_nominal(sn([det(Det), adj(Adj), nom(Nom)])) --> 
    determinante(Det), adjetivo(Adj), nombre(Nom).

sintagma_nominal(sn([nom(Nom)])) --> 
    nombre(Nom).

sintagma_nominal(sn([pron(Pron)])) --> 
    pronombre(Pron).

% Sintagma Verbal: verbo con diferentes complementos
sintagma_verbal(sv([v(V)])) --> 
    verbo(V).

sintagma_verbal(sv([v(V), SN])) --> 
    verbo(V), sintagma_nominal(SN).

sintagma_verbal(sv([v(V), SP])) --> 
    verbo(V), sintagma_preposicional(SP).

sintagma_verbal(sv([v(V), adj(Adj)])) --> 
    verbo(V), adjetivo(Adj).

sintagma_verbal(sv([v(V), adv(Adv)])) --> 
    verbo(V), adverbio(Adv).

% Sintagma Preposicional: preposicion + sintagma nominal
sintagma_preposicional(sp([prep(Prep), SN])) --> 
    preposicion(Prep), sintagma_nominal(SN).

sintagma_preposicional(sp([prep(Prep), nom(Nom)])) --> 
    preposicion(Prep), nombre(Nom).

% ===============================================
% COMPONENTES LEXICOS (Terminales)
% ===============================================
% Definen las categorias gramaticales basicas

% Determinante: articulos definidos e indefinidos
determinante(X) --> [X], {palabra(X, _, articulo)}.
determinante(X) --> [X], {palabra(_, X, articulo)}.

% Nombre: sustantivos
nombre(X) --> [X], {palabra(X, _, sustantivo)}.
nombre(X) --> [X], {palabra(_, X, sustantivo)}.

% Verbo: verbos en tiempo presente
verbo(X) --> [X], {palabra(X, _, verbo)}.
verbo(X) --> [X], {palabra(_, X, verbo)}.

% Adjetivo: calificativos
adjetivo(X) --> [X], {palabra(X, _, adjetivo)}.
adjetivo(X) --> [X], {palabra(_, X, adjetivo)}.

% Adverbio: modificadores de verbo
adverbio(X) --> [X], {palabra(X, _, adverbio)}.
adverbio(X) --> [X], {palabra(_, X, adverbio)}.

% Pronombre: yo, tu, el, ella, etc.
pronombre(X) --> [X], {palabra(X, _, pronombre)}.
pronombre(X) --> [X], {palabra(_, X, pronombre)}.

% Preposicion: en, de, con, etc.
preposicion(X) --> [X], {palabra(X, _, preposicion)}.
preposicion(X) --> [X], {palabra(_, X, preposicion)}.

% ===============================================
% PREDICADOS DE VALIDACION DCG
% ===============================================

% Valida si una lista de palabras es una oracion valida segun la gramatica
es_oracion_valida(Lista) :-
    oracion(_, Lista, []).

% Valida y retorna la estructura
validar_y_parsear(Lista, Estructura) :-
    oracion(Estructura, Lista, []).

% ===============================================
% INTERFAZ DE USUARIO - TransLogEI
% ===============================================
% Traductor Espanol -> Ingles

translog_ei :-
    writeln(''),
    writeln('==========================================='),
    writeln('   TransLogEI - Traductor Espanol-Ingles   '),
    writeln('==========================================='),
    writeln(''),
    writeln('Sistema Experto de Traduccion'),
    writeln('Usando analisis sintactico con DCG'),
    writeln(''),
    writeln('Escribe oraciones en espanol.'),
    writeln('(escribe "salir" para terminar)'),
    writeln(''),
    ciclo_traduccion_ei.

% Ciclo de traduccion Espanol -> Ingles
ciclo_traduccion_ei :-
    write('Usuario: '),
    read_line_to_string(user_input, Entrada),
    (   (Entrada = "salir" ; Entrada = "exit")
    ->  writeln('Hasta luego!')
    ;   (   atom_string(EntradaAtom, Entrada),
            traducir_esp_a_ing(EntradaAtom, Salida),
            format('TransLogEI: ~w~n~n', [Salida]),
            ciclo_traduccion_ei
        )
    ).

% ===============================================
% INTERFAZ DE USUARIO - TransLogIE
% ===============================================
% Traductor Ingles -> Espanol

translog_ie :-
    writeln(''),
    writeln('==========================================='),
    writeln('   TransLogIE - Traductor Ingles-Espanol   '),
    writeln('==========================================='),
    writeln(''),
    writeln('Expert System for Translation'),
    writeln('Using syntactic analysis with DCG'),
    writeln(''),
    writeln('Write sentences in English.'),
    writeln('(type "exit" to quit)'),
    writeln(''),
    ciclo_traduccion_ie.

% Ciclo de traduccion Ingles -> Espanol
ciclo_traduccion_ie :-
    write('User: '),
    read_line_to_string(user_input, Entrada),
    (   (Entrada = "exit" ; Entrada = "salir")
    ->  writeln('Goodbye!')
    ;   (   atom_string(EntradaAtom, Entrada),
            traducir_ing_a_esp(EntradaAtom, Salida),
            format('TransLogIE: ~w~n~n', [Salida]),
            ciclo_traduccion_ie
        )
    ).

% ===============================================
% INTERFAZ DE USUARIO - TransLog
% ===============================================
% Traductor con auto-deteccion de idioma

translog :-
    writeln(''),
    writeln('==========================================='),
    writeln('        TransLog - Traductor Bilingue      '),
    writeln('==========================================='),
    writeln(''),
    writeln('Sistema Experto de Traduccion Bilingue'),
    writeln('Deteccion automatica de idioma'),
    writeln('Analisis sintactico con DCG'),
    writeln(''),
    writeln('Escribe en espanol o ingles.'),
    writeln('(escribe "salir"/"exit" para terminar)'),
    writeln(''),
    ciclo_traduccion_auto.

% Ciclo de traduccion con auto-deteccion
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

% ===============================================
% PREDICADOS DE PRUEBA Y VALIDACION
% ===============================================

% Prueba traduccion Espanol -> Ingles con analisis
probar_traduccion_ei(Oracion) :-
    writeln(''),
    writeln('=== PRUEBA DE TRADUCCION ES->EN ==='),
    format('Entrada (ES): ~w~n', [Oracion]),
    
    % Mostrar analisis sintactico
    oracion_a_lista(Oracion, Lista),
    write('Tokenizacion: '), writeln(Lista),
    
    (analizar_oracion_dcg(Lista, Estructura) ->
        write('Estructura DCG: '), writeln(Estructura),
        writeln('✓ Oracion valida segun gramatica')
    ;
        writeln('✗ Oracion no valida, usando traduccion simple')
    ),
    
    % Traducir
    traducir_esp_a_ing(Oracion, Traduccion),
    format('Salida (EN): ~w~n', [Traduccion]),
    writeln('').

% Prueba traduccion Ingles -> Espanol con analisis
probar_traduccion_ie(Oracion) :-
    writeln(''),
    writeln('=== PRUEBA DE TRADUCCION EN->ES ==='),
    format('Entrada (EN): ~w~n', [Oracion]),
    
    % Mostrar analisis sintactico
    oracion_a_lista(Oracion, Lista),
    write('Tokenizacion: '), writeln(Lista),
    
    (analizar_oracion_dcg(Lista, Estructura) ->
        write('Estructura DCG: '), writeln(Estructura),
        writeln('Oracion valida segun gramatica')
    ;
        writeln('Oracion no valida, usando traduccion simple')
    ),
    
    % Traducir
    traducir_ing_a_esp(Oracion, Traduccion),
    format('Salida (ES): ~w~n', [Traduccion]),
    writeln('').

% ===============================================
% ANALISIS SINTACTICO DETALLADO
% ===============================================

% Analiza la estructura sintactica de una oracion
analizar_oracion(OracionAtom) :-
    writeln(''),
    writeln('=== ANALISIS SINTACTICO ==='),
    oracion_a_lista(OracionAtom, Lista),
    format('Oracion: ~w~n', [OracionAtom]),
    format('Tokens: ~w~n', [Lista]),
    writeln(''),
    
    (validar_y_parsear(Lista, Estructura) ->
        writeln('Oracion valida segun la gramatica DCG'),
        format('Estructura: ~w~n', [Estructura]),
        writeln(''),
        mostrar_componentes_detallados(Estructura)
    ;
        writeln('✗ Oracion no valida segun la gramatica'),
        writeln('La oracion no se ajusta a las reglas DCG definidas')
    ),
    writeln('').

% Muestra los componentes de una estructura de forma detallada
mostrar_componentes_detallados(oracion(SN, SV)) :-
    writeln('Componentes de la oracion:'),
    format('  1. Sintagma Nominal: ~w~n', [SN]),
    format('  2. Sintagma Verbal: ~w~n', [SV]),
    
    % Mostrar palabras del SN
    (SN \= vacio ->
        generar_sn(SN, PalabrasSN),
        format('     Palabras SN: ~w~n', [PalabrasSN])
    ; true),
    
    % Mostrar palabras del SV
    generar_sv(SV, PalabrasSV),
    format('     Palabras SV: ~w~n', [PalabrasSV]).

mostrar_componentes_detallados(interjeccion(Palabra)) :-
    format('Tipo: Interjeccion (~w)~n', [Palabra]).

% ===============================================
% VALIDACION DE GRAMATICA
% ===============================================

% Valida si una oracion cumple con la gramatica DCG
validar_gramatica(Oracion) :-
    oracion_a_lista(Oracion, Lista),
    (es_oracion_valida(Lista) ->
        writeln('✓ La oracion es VALIDA segun la gramatica DCG')
    ;
        writeln('✗ La oracion es INVALIDA segun la gramatica DCG')
    ).

% ===============================================
% PRUEBAS DE EJEMPLO
% ===============================================

% Ejecuta una bateria de pruebas de ejemplo
ejecutar_pruebas_ejemplo :-
    writeln(''),
    writeln('==========================================='),
    writeln('        BATERIA DE PRUEBAS DE EJEMPLO     '),
    writeln('==========================================='),
    writeln(''),
    
    % Pruebas Espanol -> Ingles
    writeln('--- TRADUCCIONES ESPANOL -> INGLES ---'),
    writeln(''),
    probar_traduccion_ei('hola'),
    probar_traduccion_ei('el gato come'),
    probar_traduccion_ei('la casa es grande'),
    probar_traduccion_ei('yo como'),
    
    writeln(''),
    writeln('--- TRADUCCIONES INGLES -> ESPANOL ---'),
    writeln(''),
    probar_traduccion_ie('hello'),
    probar_traduccion_ie('the cat eats'),
    probar_traduccion_ie('the house is big'),
    probar_traduccion_ie('i eat'),
    
    writeln(''),
    writeln('==========================================='),
    writeln('        FIN DE PRUEBAS                    '),
    writeln('==========================================='),
    writeln('').

% ===============================================
% SISTEMA DE AYUDA
% ===============================================

mostrar_ayuda :-
    writeln(''),
    writeln('==========================================='),
    writeln('          SISTEMA TRANSLOG - AYUDA        '),
    writeln('==========================================='),
    writeln(''),
    writeln('COMANDOS PRINCIPALES:'),
    writeln('  translog_ei.              - Traductor Espanol->Ingles'),
    writeln('  translog_ie.              - Traductor Ingles->Espanol'),
    writeln('  translog.                 - Traductor con auto-deteccion'),
    writeln(''),
    writeln('COMANDOS DE PRUEBA:'),
    writeln('  probar_traduccion_ei(\'texto\').  - Prueba ES->EN'),
    writeln('  probar_traduccion_ie(\'text\').   - Prueba EN->ES'),
    writeln('  ejecutar_pruebas_ejemplo.       - Ejecuta bateria completa'),
    writeln(''),
    writeln('COMANDOS DE ANALISIS:'),
    writeln('  analizar_oracion(\'texto\').     - Analiza estructura sintactica'),
    writeln('  validar_gramatica(\'texto\').    - Valida contra reglas DCG'),
    writeln('  analizar_y_mostrar(\'texto\').   - Muestra estructura detallada'),
    writeln(''),
    writeln('OTROS:'),
    writeln('  mostrar_ayuda.                 - Muestra esta ayuda'),
    writeln(''),
    writeln('EJEMPLOS DE USO:'),
    writeln('  ?- probar_traduccion_ei(\'el gato come\').'),
    writeln('  ?- probar_traduccion_ie(\'the cat eats\').'),
    writeln('  ?- analizar_oracion(\'la casa es grande\').'),
    writeln(''),
    writeln('ARQUITECTURA DEL SISTEMA:'),
    writeln('  BD.pl    - Base de datos de palabras (hechos)'),
    writeln('  Logic.pl - Reglas de traduccion y estructuras'),
    writeln('  BNF.pl   - Gramatica DCG e interfaz de usuario'),
    writeln(''),
    writeln('El sistema usa:'),
    writeln('  1. Analisis sintactico con DCG'),
    writeln('  2. Estructuras de datos: oracion(SN, SV)'),
    writeln('  3. Traduccion basada en estructura sintactica'),
    writeln('  4. Generacion de oraciones desde estructura'),
    writeln(''),
    writeln('==========================================='),
    writeln('').

% ===============================================
% INICIALIZACION
% ===============================================

% Mensaje de bienvenida al cargar el archivo
:- initialization((
    writeln(''),
    writeln('==========================================='),
    writeln('       TransLog - Sistema Experto          '),
    writeln('      Traduccion Espanol <-> Ingles        '),
    writeln('==========================================='),
    writeln(''),
    writeln('BD.pl cargado - Base de datos de palabras'),
    writeln('Logic.pl cargado - Reglas de traduccion'),
    writeln('BNF.pl cargado - Gramatica e interfaz'),
    writeln(''),
    writeln('Sistema listo. Escribe "mostrar_ayuda." para ver comandos.'),
    writeln('')
)).