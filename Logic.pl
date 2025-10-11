% Logic.pl - Reglas de Traducción
% Este archivo contiene las reglas para identificar y traducir oraciones

:- consult('BD.pl').

% ========== DETECCIÓN DE IDIOMA ==========
% Detecta si una lista de palabras está en español o inglés
detectar_idioma([], espanol). % Por defecto español si está vacío
detectar_idioma([P|_], espanol) :- 
    palabra(P, _, _), !.
detectar_idioma([P|_], ingles) :- 
    palabra(_, P, _), !.
detectar_idioma([_|Resto], Idioma) :- 
    detectar_idioma(Resto, Idioma).

% ========== REGLAS PARA PREGUNTAS ESPECÍFICAS ==========
% Patrones de preguntas comunes con traducciones directas

% Pregunta "How are you?"
traducir_pregunta_especial([how, are, you], [como, estas]).
traducir_pregunta_especial([how, is, he], [como, esta, el]).
traducir_pregunta_especial([how, is, she], [como, esta, ella]).
traducir_pregunta_especial([how, are, they], [como, estan]).

% Pregunta "What is your name?"
traducir_pregunta_especial([what, is, your, name], [cual, es, tu, nombre]).
traducir_pregunta_especial([what, are, your], [cuales, son, tus]).

% Pregunta "Where are you from?"
traducir_pregunta_especial([where, are, you, from], [de, donde, eres]).

% Pregunta "How old are you?"
traducir_pregunta_especial([how, old, are, you], [cuantos, anos, tienes]).

% Preguntas inversas (Español -> Inglés)
traducir_pregunta_especial([como, estas], [how, are, you]).
traducir_pregunta_especial([cual, es, tu, nombre], [what, is, your, name]).
traducir_pregunta_especial([de, donde, eres], [where, are, you, from]).
traducir_pregunta_especial([cuantos, anos, tienes], [how, old, are, you]).

% ========== DETECCIÓN DE ESTRUCTURA DE PREGUNTAS ==========
es_pregunta_ingles(Lista) :-
    member(Palabra, Lista),
    palabra_interrogativa_ingles(Palabra).

es_pregunta_espanol(Lista) :-
    member(Palabra, Lista),
    palabra_interrogativa_espanol(Palabra).

palabra_interrogativa_ingles(how).
palabra_interrogativa_ingles(what).
palabra_interrogativa_ingles(where).
palabra_interrogativa_ingles(when).
palabra_interrogativa_ingles(who).
palabra_interrogativa_ingles(why).
palabra_interrogativa_ingles(which).

palabra_interrogativa_espanol(como).
palabra_interrogativa_espanol(que).
palabra_interrogativa_espanol(donde).
palabra_interrogativa_espanol(cuando).
palabra_interrogativa_espanol(quien).
palabra_interrogativa_espanol(porque).
palabra_interrogativa_espanol(cual).
palabra_interrogativa_espanol(cuantos).
palabra_interrogativa_espanol(cuantas).

% Determina el tipo específico de pregunta
tipo_pregunta([how|_], como).
tipo_pregunta([what|_], que).
tipo_pregunta([where|_], donde).
tipo_pregunta([como|_], how).
tipo_pregunta([que|_], what).
tipo_pregunta([donde|_], where).

% ========== TRADUCCIÓN DE PREGUNTAS CON CONTEXTO ==========
traducir_pregunta(ListaOrigen, ListaDestino) :-
    traducir_pregunta_especial(ListaOrigen, ListaDestino), !.

traducir_pregunta(ListaOrigen, ListaDestino) :-
    tipo_pregunta(ListaOrigen, Tipo),
    traducir_por_tipo_pregunta(ListaOrigen, Tipo, ListaDestino), !.

traducir_pregunta(ListaOrigen, ListaDestino) :-
    % Traducción palabra por palabra como fallback
    traducir_lista_normal(ListaOrigen, ListaDestino).

% Traducción basada en el tipo de pregunta
traducir_por_tipo_pregunta([how, are, you|_], como, [como, estas]).
traducir_por_tipo_pregunta([how, is, he|_], como, [como, esta, el]).
traducir_por_tipo_pregunta([how, is, she|_], como, [como, esta, ella]).
traducir_por_tipo_pregunta([how, old|Resto], como, [cuantos, anos|RestoT]) :-
    traducir_lista_normal(Resto, RestoT).

traducir_por_tipo_pregunta([what, is|Resto], que, [que, es|RestoT]) :-
    traducir_lista_normal(Resto, RestoT).
traducir_por_tipo_pregunta([what, are|Resto], que, [que, son|RestoT]) :-
    traducir_lista_normal(Resto, RestoT).

traducir_por_tipo_pregunta([where, is|Resto], donde, [donde, esta|RestoT]) :-
    traducir_lista_normal(Resto, RestoT).
traducir_por_tipo_pregunta([where, are|Resto], donde, [donde, estan|RestoT]) :-
    traducir_lista_normal(Resto, RestoT).

% Traducción normal de lista (para usar en las reglas anteriores)
traducir_lista_normal([], []).
traducir_lista_normal([Palabra|Resto], [Traduccion|RestoT]) :-
    traducir_palabra_normal(Palabra, Traduccion),
    traducir_lista_normal(Resto, RestoT).

traducir_palabra_normal(Palabra, Traduccion) :-
    (palabra(Traduccion, Palabra, _) ; palabra(Palabra, Traduccion, _)), !.
traducir_palabra_normal(Palabra, Palabra).

% ========== TRADUCCION DE PALABRAS CON CONTEXTO ==========
% Traduce una palabra de español a inglés considerando contexto
traducir_esp_ing_contexto(Palabra, Contexto, Traduccion) :-
    % Reglas especificas para palabras ambiguas
    resolver_ambiguedad_esp(Palabra, Contexto, Traduccion), !.

traducir_esp_ing_contexto(Palabra, _, Traduccion) :-
    % Si no hay ambiguedad, traduccion normal
    palabra(Palabra, Traduccion, _), !.

traducir_esp_ing_contexto(Palabra, _, Palabra).

% Resuelve ambiguedades en español
resolver_ambiguedad_esp(como, Contexto, how) :-
    es_pregunta(Contexto), !.
resolver_ambiguedad_esp(como, Contexto, as) :-
    member(Palabra, Contexto),
    (Palabra = y ; Palabra = pero ; Palabra = porque), !.
resolver_ambiguedad_esp(como, _, eat).

resolver_ambiguedad_esp(que, Contexto, what) :-
    es_pregunta(Contexto), !.
resolver_ambiguedad_esp(que, _, that).

resolver_ambiguedad_esp(si, Contexto, yes) :-
    es_respuesta_afirmativa(Contexto), !.
resolver_ambiguedad_esp(si, _, if).

resolver_ambiguedad_esp(bajo, Contexto, under) :-
    (member(el, Contexto) ; member(la, Contexto)),
    (member(mesa, Contexto) ; member(puente, Contexto)), !.
resolver_ambiguedad_esp(bajo, Contexto, short) :-
    (member(es, Contexto) ; member(muy, Contexto)), !.
resolver_ambiguedad_esp(bajo, _, low).

resolver_ambiguedad_esp(sobre, Contexto, on) :-
    (member(el, Contexto) ; member(la, Contexto)),
    (member(mesa, Contexto) ; member(escritorio, Contexto)), !.
resolver_ambiguedad_esp(sobre, Contexto, about) :-
    (member(hablar, Contexto) ; member(escribir, Contexto) ; member(pensar, Contexto)), !.
resolver_ambiguedad_esp(sobre, _, envelope).

resolver_ambiguedad_esp(para, Contexto, for) :-
    (member(es, Contexto) ; member(esto, Contexto)), !.
resolver_ambiguedad_esp(para, _, stop).

resolver_ambiguedad_esp(este, Contexto, this) :-
    (member(es, Contexto) ; member(libro, Contexto) ; member(casa, Contexto)), !.
resolver_ambiguedad_esp(este, _, east).

resolver_ambiguedad_esp(bien, Contexto, well) :-
    (member(muy, Contexto) ; member(esta, Contexto) ; member(estoy, Contexto)), !.
resolver_ambiguedad_esp(bien, _, good).

resolver_ambiguedad_esp(banco, Contexto, bank) :-
    (member(dinero, Contexto) ; member(cuenta, Contexto) ; member(financiero, Contexto)), !.
resolver_ambiguedad_esp(banco, _, bench).

resolver_ambiguedad_esp(derecho, Contexto, right) :-
    (member(tengo, Contexto) ; member(tiene, Contexto) ; member(derecho, Contexto)), !.
resolver_ambiguedad_esp(derecho, _, straight).

resolver_ambiguedad_esp(derecha, _, right).
resolver_ambiguedad_esp(izquierda, _, left).

% Detecta si es una pregunta
es_pregunta(Contexto) :-
    (member(como, Contexto) ; 
     member(que, Contexto) ; 
     member(donde, Contexto) ;
     member(cuando, Contexto) ;
     member(quien, Contexto) ;
     member(cuanto, Contexto) ;
     member(cuantos, Contexto)).

% Detecta si es respuesta afirmativa
es_respuesta_afirmativa(Contexto) :-
    length(Contexto, Len),
    Len =< 3,
    member(si, Contexto).

% Traduce una palabra de español a inglés
traducir_esp_ing(Palabra, Traduccion) :-
    palabra(Palabra, Traduccion, _), !.
traducir_esp_ing(Palabra, Palabra).

% Traduce una palabra de inglés a español
traducir_ing_esp_contexto(Palabra, Contexto, Traduccion) :-
    % Reglas especificas para palabras ambiguas en ingles
    resolver_ambiguedad_ing(Palabra, Contexto, Traduccion), !.

traducir_ing_esp_contexto(Palabra, _, Traduccion) :-
    % Si no hay ambiguedad, traduccion normal
    palabra(Traduccion, Palabra, _), !.

traducir_ing_esp_contexto(Palabra, _, Palabra).

% Resuelve ambiguedades en ingles
resolver_ambiguedad_ing(can, Contexto, puedo) :-
    member(i, Contexto), !.
resolver_ambiguedad_ing(can, Contexto, puedes) :-
    member(you, Contexto), !.
resolver_ambiguedad_ing(can, Contexto, puede) :-
    (member(he, Contexto) ; member(she, Contexto) ; member(it, Contexto)), !.
resolver_ambiguedad_ing(can, _, lata).

resolver_ambiguedad_ing(are, Contexto, eres) :-
    member(you, Contexto),
    es_pregunta_ingles(Contexto), !.
resolver_ambiguedad_ing(are, Contexto, estas) :-
    member(you, Contexto), !.
resolver_ambiguedad_ing(are, Contexto, son) :-
    member(they, Contexto), !.
resolver_ambiguedad_ing(are, _, are).

resolver_ambiguedad_ing(right, Contexto, derecho) :-
    (member(have, Contexto) ; member(has, Contexto)), !.
resolver_ambiguedad_ing(right, Contexto, derecha) :-
    (member(the, Contexto) ; member(to, Contexto)), !.
resolver_ambiguedad_ing(right, _, correcto).

resolver_ambiguedad_ing(left, Contexto, izquierda) :-
    (member(the, Contexto) ; member(to, Contexto)), !.
resolver_ambiguedad_ing(left, _, dejo).

resolver_ambiguedad_ing(bank, Contexto, banco) :-
    (member(money, Contexto) ; member(account, Contexto)), !.
resolver_ambiguedad_ing(bank, _, banco).

resolver_ambiguedad_ing(order, Contexto, orden) :-
    (member(the, Contexto) ; member(in, Contexto)), !.
resolver_ambiguedad_ing(order, _, orden).

% Detecta si es pregunta en ingles
es_pregunta_ingles(Contexto) :-
    (member(how, Contexto) ; 
     member(what, Contexto) ; 
     member(where, Contexto) ;
     member(when, Contexto) ;
     member(who, Contexto)).

% Traduce una palabra de inglés a español
traducir_ing_esp(Palabra, Traduccion) :-
    palabra(Traduccion, Palabra, _), !.
traducir_ing_esp(Palabra, Palabra).

% ========== TRADUCCION DE LISTAS DE PALABRAS CON CONTEXTO ==========
% Traduce una lista de palabras de español a inglés
traducir_lista_esp_ing([], []).
traducir_lista_esp_ing(ListaCompleta, ListaTraducida) :-
    traducir_lista_esp_ing_ctx(ListaCompleta, ListaCompleta, ListaTraducida).

traducir_lista_esp_ing_ctx(_, [], []).
traducir_lista_esp_ing_ctx(Contexto, [P|Resto], [T|RestoT]) :-
    traducir_esp_ing_contexto(P, Contexto, T),
    traducir_lista_esp_ing_ctx(Contexto, Resto, RestoT).

% Traduce una lista de palabras de inglés a español
traducir_lista_ing_esp([], []).
traducir_lista_ing_esp(ListaCompleta, ListaTraducida) :-
    traducir_lista_ing_esp_ctx(ListaCompleta, ListaCompleta, ListaTraducida).

traducir_lista_ing_esp_ctx(_, [], []).
traducir_lista_ing_esp_ctx(Contexto, [P|Resto], [T|RestoT]) :-
    traducir_ing_esp_contexto(P, Contexto, T),
    traducir_lista_ing_esp_ctx(Contexto, Resto, RestoT).

% ========== NORMALIZACIÓN DE TEXTO ==========
% Convierte texto a minúsculas y elimina signos de puntuación
normalizar_palabra(Palabra, Normalizada) :-
    atom(Palabra),
    downcase_atom(Palabra, Minuscula),
    atom_chars(Minuscula, Chars),
    eliminar_puntuacion(Chars, CharsLimpios),
    atom_chars(Normalizada, CharsLimpios).

% Elimina signos de puntuación de una lista de caracteres
eliminar_puntuacion([], []).
eliminar_puntuacion([C|Resto], [C|RestoLimpio]) :-
    char_type(C, alpha), !,
    eliminar_puntuacion(Resto, RestoLimpio).
eliminar_puntuacion([C|Resto], [C|RestoLimpio]) :-
    char_type(C, space), !,
    eliminar_puntuacion(Resto, RestoLimpio).
eliminar_puntuacion([_|Resto], RestoLimpio) :-
    eliminar_puntuacion(Resto, RestoLimpio).

% ========== PROCESAMIENTO DE ORACIONES ==========
% Convierte una oración (átomo) en lista de palabras
oracion_a_lista(Oracion, Lista) :-
    atom(Oracion),
    atomic_list_concat(Palabras, ' ', Oracion),
    maplist(normalizar_palabra, Palabras, Lista).

% Convierte una lista de palabras en oración (átomo)
lista_a_oracion([], '').
lista_a_oracion([P], P) :- !.
lista_a_oracion([P|Resto], Oracion) :-
    lista_a_oracion(Resto, RestoOracion),
    atomic_list_concat([P, RestoOracion], ' ', Oracion).

% ========== CAPITALIZACIÓN ==========
% Capitaliza la primera letra de una oración
capitalizar_oracion(Oracion, OracionCap) :-
    atom_chars(Oracion, [Primer|Resto]),
    upcase_atom(Primer, PrimerMay),
    atom_chars(PrimerMay, [PrimerChar]),
    atom_chars(OracionCap, [PrimerChar|Resto]).

% ========== AJUSTES GRAMATICALES ==========
% Ajusta el orden de palabras según el idioma destino
% En inglés, los adjetivos van antes del sustantivo
% En español, los adjetivos van después del sustantivo

ajustar_orden_ingles(Lista, ListaAjustada) :-
    ajustar_adjetivos_ingles(Lista, ListaAjustada).

ajustar_adjetivos_ingles([], []).
ajustar_adjetivos_ingles([P1, P2|Resto], [P2, P1|RestoAjustado]) :-
    palabra(_, P1, sustantivo),
    palabra(_, P2, adjetivo), !,
    ajustar_adjetivos_ingles(Resto, RestoAjustado).
ajustar_adjetivos_ingles([P|Resto], [P|RestoAjustado]) :-
    ajustar_adjetivos_ingles(Resto, RestoAjustado).

ajustar_orden_espanol(Lista, ListaAjustada) :-
    ajustar_adjetivos_espanol(Lista, ListaAjustada).

ajustar_adjetivos_espanol([], []).
ajustar_adjetivos_espanol([P1, P2|Resto], [P2, P1|RestoAjustado]) :-
    palabra(P2, _, sustantivo),
    palabra(P1, _, adjetivo), !,
    ajustar_adjetivos_espanol(Resto, RestoAjustado).
ajustar_adjetivos_espanol([P|Resto], [P|RestoAjustado]) :-
    ajustar_adjetivos_espanol(Resto, RestoAjustado).

% ========== MANEJO DE CONTRACCIONES Y CASOS ESPECIALES ==========
% Maneja casos especiales como "¿" y "?"
limpiar_interrogacion(Palabra, Limpia) :-
    atom_chars(Palabra, Chars),
    delete(Chars, '¿', Chars1),
    delete(Chars1, '?', CharsLimpios),
    atom_chars(Limpia, CharsLimpios).

% ========== FUNCIÓN PRINCIPAL DE TRADUCCIÓN MEJORADA ==========
% Traduce de español a inglés
traducir_esp_a_ing(OracionEsp, OracionIng) :-
    oracion_a_lista(OracionEsp, ListaEsp),
    (   es_pregunta_espanol(ListaEsp)
    ->  traducir_pregunta(ListaEsp, ListaIng)
    ;   traducir_lista_esp_ing(ListaEsp, ListaIng)
    ),
    lista_a_oracion(ListaIng, OracionIngTemp),
    capitalizar_oracion(OracionIngTemp, OracionIng).

% Traduce de inglés a español
traducir_ing_a_esp(OracionIng, OracionEsp) :-
    oracion_a_lista(OracionIng, ListaIng),
    (   es_pregunta_ingles(ListaIng)
    ->  traducir_pregunta(ListaIng, ListaEsp)
    ;   traducir_lista_ing_esp(ListaIng, ListaEsp)
    ),
    lista_a_oracion(ListaEsp, OracionEspTemp),
    capitalizar_oracion(OracionEspTemp, OracionEsp).

% Traducción automática (detecta el idioma)
traducir_auto(Entrada, Salida) :-
    oracion_a_lista(Entrada, Lista),
    detectar_idioma(Lista, Idioma),
    (   Idioma = espanol
    ->  traducir_esp_a_ing(Entrada, Salida)
    ;   traducir_ing_a_esp(Entrada, Salida)
    ).

% ========== ANÁLISIS SINTÁCTICO BÁSICO ==========
% Identifica sintagmas nominales (artículo + sustantivo)
sintagma_nominal([Art, Sust], [Art, Sust]) :-
    palabra(Art, _, articulo),
    palabra(Sust, _, sustantivo).

sintagma_nominal([Art, Adj, Sust], [Art, Adj, Sust]) :-
    palabra(Art, _, articulo),
    palabra(Adj, _, adjetivo),
    palabra(Sust, _, sustantivo).

% Identifica sintagmas verbales (verbo + complemento)
sintagma_verbal([Verbo], [Verbo]) :-
    palabra(Verbo, _, verbo).

sintagma_verbal([Verbo|Complemento], [Verbo|Complemento]) :-
    palabra(Verbo, _, verbo),
    Complemento \= [].

% Descompone una oración en sintagma nominal y sintagma verbal
descomponer_oracion(Oracion, SN, SV) :-
    oracion_a_lista(Oracion, Lista),
    append(SN, SV, Lista),
    sintagma_nominal(SN, _),
    sintagma_verbal(SV, _).

% ========== PREDICADOS DE PRUEBA PARA PREGUNTAS ==========
probar_preguntas :-
    writeln('=== PRUEBAS DE PREGUNTAS ==='),
    probar_traduccion_ie('how are you?'),
    probar_traduccion_ie('what is your name?'),
    probar_traduccion_ie('where are you from?'),
    probar_traduccion_ie('how old are you?'),
    probar_traduccion_ei('como estas?'),
    probar_traduccion_ei('cual es tu nombre?'),
    probar_traduccion_ei('de donde eres?').

% Predicados auxiliares para pruebas
probar_traduccion_ei(Oracion) :-
    write('Entrada (ES): '), writeln(Oracion),
    traducir_esp_a_ing(Oracion, Traduccion),
    write('Salida (EN): '), writeln(Traduccion).

probar_traduccion_ie(Oracion) :-
    write('Entrada (EN): '), writeln(Oracion),
    traducir_ing_a_esp(Oracion, Traduccion),
    write('Salida (ES): '), writeln(Traduccion).