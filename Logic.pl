% ======================================================================
% Logic.pl - VERSIÓN CON ANÁLISIS ESTRUCTURAL COMPLETO Y SIGNOS DE INTERROGACIÓN
% ======================================================================

:- consult('BD.pl').

% ----------------------------------------------------------------------
% TRADUCCIÓN PALABRA POR PALABRA CON CONTEXTO
% ----------------------------------------------------------------------

% Traducción normal para la mayoría de palabras
traducir_palabra_es_en(Palabra, Traduccion) :-
    atom(Palabra),
    (sustantivo(Palabra, Traduccion, _, _)
    ; pronombre(Palabra, Traduccion, _, _)
    ; verbo(Palabra, Traduccion, _, _, _)
    ; adjetivo(Palabra, Traduccion)
    ; articulo(Palabra, Traduccion, _, _)
    ; preposicion(Palabra, Traduccion)
    ; conjuncion(Palabra, Traduccion)
    ; adverbio(Palabra, Traduccion)
    ; interrogativo(Palabra, Traduccion)
    ; auxiliar(Palabra, Traduccion, _, _)
    ; expresion(Palabra, Traduccion)
    ; Traduccion = Palabra
    ), !.

traducir_palabra_en_es(Palabra, Traduccion) :-
    atom(Palabra),
    (sustantivo(Traduccion, Palabra, _, _)
    ; pronombre(Traduccion, Palabra, _, _)
    ; verbo(Traduccion, Palabra, _, _, _)
    ; adjetivo(Traduccion, Palabra)
    ; articulo(Traduccion, Palabra, _, _)
    ; preposicion(Traduccion, Palabra)
    ; conjuncion(Traduccion, Palabra)
    ; adverbio(Traduccion, Palabra)
    ; interrogativo(Traduccion, Palabra)
    ; auxiliar(Traduccion, Palabra, _, _)
    ; expresion(Traduccion, Palabra)
    ; Traduccion = Palabra
    ), !.

% ----------------------------------------------------------------------
% FUNCIONES PRINCIPALES CON ANÁLISIS ESTRUCTURAL Y SIGNOS DE INTERROGACIÓN
% ----------------------------------------------------------------------

traducir_espanol_ingles(TextoES, TextoEN) :-
    atom(TextoES),
    % Preservar si es pregunta desde el inicio
    (es_pregunta(TextoES) -> 
        normalizar_texto_con_pregunta(TextoES, Norm, '?')
    ;
        normalizar_texto(TextoES, Norm)
    ),
    
    (expresion(Norm, Direct) -> 
        capitalizar(Direct, TextoBase),
        (es_pregunta(TextoES) -> 
            atom_concat(TextoBase, '?', TextoEN)
        ;
            TextoEN = TextoBase
        )
    ;
        dividir_en_palabras(Norm, Palabras),
        expandir_contracciones_es(Palabras, PalabrasExpandidas),
        
        % USAR ANÁLISIS ESTRUCTURAL DCG
        (oracion_estructura_es(Estructura, PalabrasExpandidas, []) ->
            traducir_estructura_es_en(Estructura, EstructuraEN),
            generar_texto_en(EstructuraEN, TempEN),
            corregir_errores_finales(TempEN, TempCorregido),
            capitalizar(TempCorregido, TextoBase),
            (es_pregunta(TextoES) -> 
                atom_concat(TextoBase, '?', TextoEN)
            ;
                agregar_puntuacion_final(TextoBase, TextoEN)
            )
        ;
            % Fallback a traducción palabra por palabra
            traducir_lista_con_contexto_es_en(PalabrasExpandidas, PalabrasEN),
            atomic_list_concat(PalabrasEN, ' ', TempEN),
            corregir_errores_finales(TempEN, TempCorregido),
            capitalizar(TempCorregido, TextoBase),
            (es_pregunta(TextoES) -> 
                atom_concat(TextoBase, '?', TextoEN)
            ;
                agregar_puntuacion_final(TextoBase, TextoEN)
            )
        )
    ).

traducir_ingles_espanol(TextoEN, TextoES) :-
    atom(TextoEN),
    % Preservar si es pregunta
    (es_pregunta(TextoEN) -> 
        normalizar_texto_con_pregunta(TextoEN, Norm, '?')
    ;
        normalizar_texto(TextoEN, Norm)
    ),
    
    (expresion(Direct, Norm) -> 
        capitalizar(Direct, TextoBase),
        (es_pregunta(TextoEN) -> 
            atom_concat(TextoBase, '?', TextoES)
        ;
            TextoES = TextoBase
        )
    ;
        dividir_en_palabras(Norm, Palabras),
        expandir_contracciones(Palabras, PalabrasExpandidas),
        
        % USAR ANÁLISIS ESTRUCTURAL DCG
        (oracion_estructura_en(Estructura, PalabrasExpandidas, []) ->
            traducir_estructura_en_es(Estructura, EstructuraES),
            generar_texto_es(EstructuraES, TempES),
            capitalizar(TempES, TextoBase),
            (es_pregunta(TextoEN) -> 
                atom_concat(TextoBase, '?', TextoES)
            ;
                agregar_puntuacion_final(TextoBase, TextoES)
            )
        ;
            % Fallback simple
            traducir_lista_en_es(PalabrasExpandidas, PalabrasES),
            atomic_list_concat(PalabrasES, ' ', TempES),
            capitalizar(TempES, TextoBase),
            (es_pregunta(TextoEN) -> 
                atom_concat(TextoBase, '?', TextoES)
            ;
                agregar_puntuacion_final(TextoBase, TextoES)
            )
        )
    ).

% Detectar si es pregunta
es_pregunta(Texto) :-
    sub_atom(Texto, _, 1, 0, '?').

% Normalizar texto preservando el tipo de pregunta
normalizar_texto_con_pregunta(Texto, TextoNorm, Signo) :-
    downcase_atom(Texto, TextoLower),
    atom_chars(TextoLower, Chars),
    (Chars = [] -> 
        TextoNorm = ''
    ;
        reverse(Chars, [Signo|RevRest]),
        reverse(RevRest, CleanChars),
        atom_chars(TextoNorm, CleanChars)
    ).

% ----------------------------------------------------------------------
% TRADUCCIÓN CON LÓGICA INTELIGENTE PARA "el" vs "él" (solo para fallback)
% ----------------------------------------------------------------------

traducir_lista_con_contexto_es_en([], []).
traducir_lista_con_contexto_es_en([el|Resto], [Traduccion|RestoT]) :-
    % VERSIÓN INFALIBLE: Si la siguiente palabra está en BD como verbo -> "he"
    (Resto = [Siguiente|_], verbo(Siguiente, _, _, _, _) -> 
        Traduccion = he    % "él" es pronombre
    ; 
        Traduccion = the   % "el" es artículo  
    ),
    traducir_lista_con_contexto_es_en(Resto, RestoT).
    
traducir_lista_con_contexto_es_en([P|Resto], [T|RestoT]) :-
    traducir_palabra_es_en(P, T),
    traducir_lista_con_contexto_es_en(Resto, RestoT).

% Traducción de lista normal (para inglés->español - fallback)
traducir_lista_en_es([], []).
traducir_lista_en_es([P|Resto], [T|RestoT]) :-
    traducir_palabra_en_es(P, T),
    traducir_lista_en_es(Resto, RestoT).

% ----------------------------------------------------------------------
% CORRECCIONES FINALES MEJORADAS
% ----------------------------------------------------------------------

corregir_errores_finales(Texto, Corregido) :-
    atomic_list_concat(Palabras, ' ', Texto),
    corregir_lista_errores_mejorada(Palabras, Corregidas),
    atomic_list_concat(Corregidas, ' ', Corregido).

corregir_lista_errores_mejorada([], []).
% Corregir "Am fine" → "I am fine"
corregir_lista_errores_mejorada([am|Resto], [i, am|RestoCorregido]) :- !,
    corregir_lista_errores_mejorada(Resto, RestoCorregido).
% Corregir "go to ir" → "go to go"
corregir_lista_errores_mejorada([go, to, ir|Resto], [go, to, go|RestoCorregido]) :- !,
    corregir_lista_errores_mejorada(Resto, RestoCorregido).
% Corregir "He dog" → "The dog" (por si falla la lógica principal)
corregir_lista_errores_mejorada([he, Sustantivo|Resto], [the, Sustantivo|RestoCorregido]) :-
    sustantivo(Sustantivo, _, _, _), !,
    corregir_lista_errores_mejorada(Resto, RestoCorregido).
corregir_lista_errores_mejorada([P|Resto], [P|RestoCorregido]) :-
    corregir_lista_errores_mejorada(Resto, RestoCorregido).

% ----------------------------------------------------------------------
% TRADUCCIÓN DE ESTRUCTURAS - MEJORADA PARA MANEJAR "el" vs "él"
% ----------------------------------------------------------------------

% ES -> EN
traducir_estructura_es_en(oracion(SN, SV), oracion(SN_EN, SV_EN)) :-
    traducir_sn_es_en(SN, SN_EN),
    traducir_sv_es_en(SV, SV_EN).

traducir_sn_es_en(sn(Art, Sust), sn(Art_EN, Sust_EN)) :-
    traducir_articulo_es_en(Art, Art_EN),
    traducir_sustantivo_es_en(Sust, Sust_EN).

traducir_sn_es_en(sn(Pron), sn(Pron_EN)) :-
    traducir_pronombre_es_en(Pron, Pron_EN).

traducir_sv_es_en(sv(Verbo), sv(Verbo_EN)) :-
    traducir_verbo_es_en(Verbo, Verbo_EN).

traducir_sv_es_en(sv(Verbo, SN), sv(Verbo_EN, SN_EN)) :-
    traducir_verbo_es_en(Verbo, Verbo_EN),
    traducir_sn_es_en(SN, SN_EN).

% Componentes individuales MEJORADOS para "el" vs "él"
traducir_articulo_es_en(art(el, _, _), art(the)) :- !.  % "el" artículo -> "the"
traducir_articulo_es_en(art(A, _, _), art(ArtEN)) :-
    traducir_palabra_es_en(A, ArtEN).

traducir_sustantivo_es_en(sust(S, _, _), sust(SustEN)) :-
    traducir_palabra_es_en(S, SustEN).

traducir_verbo_es_en(verbo(V, _, _, _), verbo(VerboEN)) :-
    traducir_palabra_es_en(V, VerboEN).

traducir_pronombre_es_en(pron(el, _, _), pron(he)) :- !.  % "él" pronombre -> "he"
traducir_pronombre_es_en(pron(P, _, _), pron(PronEN)) :-
    traducir_palabra_es_en(P, PronEN).

% EN -> ES
traducir_estructura_en_es(oracion(SN, SV), oracion(SN_ES, SV_ES)) :-
    traducir_sn_en_es(SN, SN_ES),
    traducir_sv_en_es(SV, SV_ES).

traducir_sn_en_es(sn(Art, Sust), sn(Art_ES, Sust_ES)) :-
    traducir_articulo_en_es(Art, Art_ES),
    traducir_sustantivo_en_es(Sust, Sust_ES).

traducir_sn_en_es(sn(Pron), sn(Pron_ES)) :-
    traducir_pronombre_en_es(Pron, Pron_ES).

traducir_sv_en_es(sv(Verbo), sv(Verbo_ES)) :-
    traducir_verbo_en_es(Verbo, Verbo_ES).

traducir_sv_en_es(sv(Verbo, SN), sv(Verbo_ES, SN_ES)) :-
    traducir_verbo_en_es(Verbo, Verbo_ES),
    traducir_sn_en_es(SN, SN_ES).

% Componentes individuales inversos
traducir_articulo_en_es(art(A), art(ArtES, G, N)) :-
    (articulo(ArtES, A, G, N) -> true; ArtES = el, G = masculino, N = singular).

traducir_sustantivo_en_es(sust(S), sust(SustES, G, N)) :-
    (sustantivo(SustES, S, G, N) -> true; SustES = S, G = masculino, N = singular).

traducir_verbo_en_es(verbo(V), verbo(VerboES, T, P, N)) :-
    (verbo(VerboES, V, T, P, N) -> true; VerboES = V, T = presente, P = tercera, N = singular).

traducir_pronombre_en_es(pron(P), pron(PronES, Pers, N)) :-
    (pronombre(PronES, P, Pers, N) -> true; PronES = el, Pers = tercera, N = singular).

% ----------------------------------------------------------------------
% GENERACIÓN DE TEXTO
% ----------------------------------------------------------------------

generar_texto_en(oracion(SN, SV), Texto) :-
    generar_sn_en(SN, TextoSN),
    generar_sv_en(SV, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Texto).

generar_sn_en(sn(art(A), sust(S)), Texto) :-
    atomic_list_concat([A, S], ' ', Texto).
generar_sn_en(sn(pron(P)), P).
generar_sn_en(sn(sust(S)), S).

generar_sv_en(sv(verbo(V)), V).
generar_sv_en(sv(verbo(V), SN), Texto) :-
    generar_sn_en(SN, TextoSN),
    atomic_list_concat([V, TextoSN], ' ', Texto).

generar_texto_es(oracion(SN, SV), Texto) :-
    generar_sn_es(SN, TextoSN),
    generar_sv_es(SV, TextoSV),
    atomic_list_concat([TextoSN, TextoSV], ' ', Texto).

generar_sn_es(sn(art(A, _, _), sust(S, _, _)), Texto) :-
    atomic_list_concat([A, S], ' ', Texto).
generar_sn_es(sn(pron(P, _, _)), P).
generar_sn_es(sn(sust(S, _, _)), S).

generar_sv_es(sv(verbo(V, _, _, _)), V).
generar_sv_es(sv(verbo(V, _, _, _), SN), Texto) :-
    generar_sn_es(SN, TextoSN),
    atomic_list_concat([V, TextoSN], ' ', Texto).

% ----------------------------------------------------------------------
% GRAMÁTICAS DCG - COMPLETAS Y MEJORADAS
% ----------------------------------------------------------------------

% ESPAÑOL: Oración → Sintagma Nominal + Sintagma Verbal
oracion_estructura_es(oracion(SN, SV)) --> 
    sintagma_nominal_es(SN), 
    sintagma_verbal_es(SV).

% Sintagma Nominal → Artículo + Sustantivo O Pronombre
sintagma_nominal_es(sn(Art, Sust)) --> 
    articulo_es(Art), 
    sustantivo_es(Sust).

sintagma_nominal_es(sn(Pron)) --> 
    pronombre_es(Pron).

% Sintagma Verbal → Verbo O Verbo + Sintagma Nominal
sintagma_verbal_es(sv(Verbo)) --> 
    verbo_es(Verbo).

sintagma_verbal_es(sv(Verbo, SN)) --> 
    verbo_es(Verbo), 
    sintagma_nominal_es(SN).

% Componentes básicos en español
articulo_es(art(A, G, N)) --> [A], {articulo(A, _, G, N)}.
sustantivo_es(sust(S, G, N)) --> [S], {sustantivo(S, _, G, N)}.
verbo_es(verbo(V, T, P, N)) --> [V], {verbo(V, _, T, P, N)}.
pronombre_es(pron(P, Pers, N)) --> [P], {pronombre(P, _, Pers, N)}.

% INGLÉS: Oración → Sintagma Nominal + Sintagma Verbal
oracion_estructura_en(oracion(SN, SV)) --> 
    sintagma_nominal_en(SN), 
    sintagma_verbal_en(SV).

% Sintagma Nominal → Artículo + Sustantivo O Pronombre
sintagma_nominal_en(sn(Art, Sust)) --> 
    articulo_en(Art), 
    sustantivo_en(Sust).

sintagma_nominal_en(sn(Pron)) --> 
    pronombre_en(Pron).

% Sintagma Verbal → Verbo O Verbo + Sintagma Nominal
sintagma_verbal_en(sv(Verbo)) --> 
    verbo_en(Verbo).

sintagma_verbal_en(sv(Verbo, SN)) --> 
    verbo_en(Verbo), 
    sintagma_nominal_en(SN).

% Componentes básicos en inglés
articulo_en(art(A)) --> [A], {articulo(_, A, _, _)}.
sustantivo_en(sust(S)) --> [S], {sustantivo(_, S, _, _)}.
verbo_en(verbo(V)) --> [V], {verbo(_, V, _, _, _)}.
pronombre_en(pron(P)) --> [P], {pronombre(_, P, _, _)}.

% ----------------------------------------------------------------------
% UTILIDADES MEJORADAS CON SIGNOS DE INTERROGACIÓN
% ----------------------------------------------------------------------

normalizar_texto(Texto, TextoNorm) :-
    downcase_atom(Texto, TextoLower),
    atom_chars(TextoLower, Chars),
    (Chars = [] -> 
        TextoNorm = ''
    ;
        % Separar el texto del signo de puntuación final
        (last(Chars, Ultimo), member(Ultimo, ['.', '!', '?']) ->
            append(CleanChars, [Ultimo], Chars),
            atom_chars(TextoClean, CleanChars),
            TextoNorm = TextoClean
        ;
            TextoNorm = TextoLower
        )
    ).

dividir_en_palabras(Texto, Palabras) :-
    atomic_list_concat(Temp, ' ', Texto),
    exclude(=(''), Temp, Palabras).

expandir_contracciones_es([], []).
expandir_contracciones_es([al|R], [a, el|RE]) :- !, expandir_contracciones_es(R, RE).
expandir_contracciones_es([P|R], [P|RE]) :- expandir_contracciones_es(R, RE).

expandir_contracciones([], []).
expandir_contracciones(['i\'m'|R], [i, am|RE]) :- !, expandir_contracciones(R, RE).
expandir_contracciones([P|R], [P|RE]) :- expandir_contracciones(R, RE).

capitalizar(Texto, TextoCap) :-
    atom_chars(Texto, Chars),
    (Chars = [] -> TextoCap = '' ;
     Chars = [P|R],
     upcase_atom(P, PU),
     atom_chars(TextoCap, [PU|R])).

% Función mejorada para agregar puntuación que preserve los signos originales
agregar_puntuacion_final(Texto, TextoConPunto) :-
    % Si el texto original ya tenía puntuación, mantenerla
    (sub_atom(Texto, _, 1, 0, '?') -> TextoConPunto = Texto;
     sub_atom(Texto, _, 1, 0, '!') -> TextoConPunto = Texto;
     sub_atom(Texto, _, 1, 0, '.') -> TextoConPunto = Texto;
     % Si no tenía puntuación, agregar punto
     atom_concat(Texto, '.', TextoConPunto)
    ).

% ======================================================================
% FIN
% ======================================================================