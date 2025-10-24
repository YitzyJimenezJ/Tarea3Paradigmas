% ======================================================================
% BD.pl - Base de Datos de Vocabulario Bilingue (Espanol-Ingles)
% VERSIÓN MEJORADA CON SINÓNIMOS
% ======================================================================

% ----------------------------------------------------------------------
% SUSTANTIVOS (Nouns)
% Formato: sustantivo(Espanol, Ingles, Genero, Numero)
% ----------------------------------------------------------------------

:- discontiguous verbo/5.
:- discontiguous adverbio/2.
:- discontiguous expresion/2.
:- discontiguous pronombre/4.

sustantivo(hombre, man, masculino, singular).
sustantivo(mujer, woman, femenino, singular).
sustantivo(nino, boy, masculino, singular).
sustantivo(nina, girl, femenino, singular).
sustantivo(perro, dog, masculino, singular).
sustantivo(can, dog, masculino, singular).
sustantivo(gato, cat, masculino, singular).
sustantivo(felino, cat, masculino, singular).
sustantivo(libro, book, masculino, singular).
sustantivo(texto, book, masculino, singular).
sustantivo(casa, house, femenino, singular).
sustantivo(hogar, house, femenino, singular).
sustantivo(carro, car, masculino, singular).
sustantivo(auto, car, masculino, singular).
sustantivo(automovil, car, masculino, singular).
sustantivo(vehiculo, car, masculino, singular).
sustantivo(ano, year, masculino, singular).
sustantivo(anos, years, masculino, plural).
sustantivo(dia, day, masculino, singular).
sustantivo(lenguaje, language, masculino, singular).
sustantivo(lenguajes, languages, masculino, plural).
sustantivo(programacion, programming, femenino, singular).
sustantivo(inteligencia, intelligence, femenino, singular).
sustantivo(sistema, system, masculino, singular).
sustantivo(sistemas, systems, masculino, plural).
sustantivo(teorema, theorem, masculino, singular).
sustantivo(teoremas, theorems, masculino, plural).
sustantivo(patron, pattern, masculino, singular).
sustantivo(patrones, patterns, masculino, plural).
sustantivo(arbol, tree, masculino, singular).
sustantivo(arboles, trees, masculino, plural).
sustantivo(analisis, analysis, masculino, singular).
sustantivo(procesamiento, processing, masculino, singular).
sustantivo(computadora, computer, femenino, singular).
sustantivo(linguistica, linguistics, femenino, singular).
sustantivo(comparacion, matching, femenino, singular).
sustantivo(demostracion, proving, femenino, singular).
sustantivo(prolog, prolog, masculino, singular).
sustantivo(uno, one, masculino, singular).
sustantivo(una, one, femenino, singular).
sustantivo(parque, park, masculino, singular).
sustantivo(color, color, masculino, singular).
sustantivo(colores, colors, masculino, plural).
sustantivo(edad, age, femenino, singular).
sustantivo(nombre, name, masculino, singular).

% NUEVOS - Familia
sustantivo(hermano, brother, masculino, singular).
sustantivo(hermana, sister, femenino, singular).
sustantivo(madre, mother, femenino, singular).
sustantivo(padre, father, masculino, singular).
sustantivo(hijo, son, masculino, singular).
sustantivo(hija, daughter, femenino, singular).

% Verbos adicionales
verbo(corre, runs, correr, tercera, singular).
verbo(corren, run, correr, tercera, plural).
verbo(voy, go, ir, primera, singular).
verbo(vas, go, ir, segunda, singular).
verbo(va, goes, ir, tercera, singular).
verbo(vamos, go, ir, primera, plural).
verbo(van, go, ir, tercera, plural).

% Adverbios de negacion
adverbio(no, not).

% ----------------------------------------------------------------------
% PRONOMBRES (Pronouns)
% Formato: pronombre(Espanol, Ingles, Persona, Numero)
% ----------------------------------------------------------------------
pronombre(yo, i, primera, singular).
pronombre(tu, you, segunda, singular).
pronombre(usted, you, segunda, singular).
pronombre(el, he, tercera, singular).
pronombre(ella, she, tercera, singular).
pronombre(nosotros, we, primera, plural).
pronombre(ustedes, you, segunda, plural).
pronombre(ellos, they, tercera, plural).
pronombre(ellas, they, tercera, plural).

% NUEVOS - Posesivos
pronombre(mi, my, primera, singular).
pronombre(tu, your, segunda, singular).
pronombre(su, his, tercera, singular).
pronombre(su, her, tercera, singular).
pronombre(nuestro, our, primera, plural).

% ----------------------------------------------------------------------
% VERBOS (Verbs) - Presente Simple
% Formato: verbo(Espanol, Ingles, Tipo, Persona, Numero)
% ----------------------------------------------------------------------
% Verbo SER/ESTAR
verbo(soy, am, ser, primera, singular).
verbo(eres, are, ser, segunda, singular).
verbo(es, is, ser, tercera, singular).
verbo(somos, are, ser, primera, plural).
verbo(son, are, ser, tercera, plural).

% Verbo TENER
verbo(tengo, have, tener, primera, singular).
verbo(tienes, have, tener, segunda, singular).
verbo(tiene, has, tener, tercera, singular).
verbo(tenemos, have, tener, primera, plural).
verbo(tienen, have, tener, tercera, plural).

% Verbo ESTAR (location/state)
verbo(estoy, am, estar, primera, singular).
verbo(estas, are, estar, segunda, singular).
verbo(esta, is, estar, tercera, singular).
verbo(estamos, are, estar, primera, plural).
verbo(estan, are, estar, tercera, plural).

% Otros verbos comunes - Con sinónimos
verbo(hablo, speak, hablar, primera, singular).
verbo(hablas, speak, hablar, segunda, singular).
verbo(habla, speaks, hablar, tercera, singular).
verbo(hablamos, speak, hablar, primera, plural).
verbo(hablan, speak, hablar, tercera, plural).
verbo(converso, speak, conversar, primera, singular).
verbo(conversa, speaks, conversar, tercera, singular).

verbo(como, eat, comer, primera, singular).
verbo(comes, eat, comer, segunda, singular).
verbo(come, eats, comer, tercera, singular).
verbo(comemos, eat, comer, primera, plural).
verbo(comen, eat, comer, tercera, plural).
verbo(devora, eats, devorar, tercera, singular).

verbo(vivo, live, vivir, primera, singular).
verbo(vives, live, vivir, segunda, singular).
verbo(vive, lives, vivir, tercera, singular).
verbo(vivimos, live, vivir, primera, plural).
verbo(viven, live, vivir, tercera, plural).
verbo(habita, lives, habitar, tercera, singular).
verbo(reside, lives, residir, tercera, singular).

verbo(juega, plays, jugar, tercera, singular).
verbo(juegan, play, jugar, tercera, plural).

verbo(utiliza, uses, utilizar, tercera, singular).
verbo(utilizan, use, utilizar, tercera, plural).

verbo(permanece, remains, permanecer, tercera, singular).
verbo(permanecen, remain, permanecer, tercera, plural).

verbo(sigue, continues, seguir, tercera, singular).
verbo(siguen, continue, seguir, tercera, plural).
verbo(asociado, associated, asociar, participio, singular).
verbo(asociada, associated, asociar, participio, singular).
verbo(asociados, associated, asociar, participio, plural).
verbo(siendo, being, ser, gerundio, singular).
verbo(utiliza, used, utilizar, participio, singular).
verbo(utilizan, used, utilizar, participio, plural).

% Verbo LLAMARSE
verbo(llamo, call, llamar, primera, singular).
verbo(llamas, call, llamar, segunda, singular).
verbo(llama, call, llamar, tercera, singular).
verbo(llamamos, call, llamar, primera, plural).
verbo(llaman, call, llamar, tercera, plural).

% ----------------------------------------------------------------------
% ADJETIVOS (Adjectives)
% Formato: adjetivo(Espanol, Ingles)
% ----------------------------------------------------------------------
adjetivo(grande, big).
adjetivo(pequeno, small).
adjetivo(bueno, good).
adjetivo(malo, bad).
adjetivo(feliz, happy).
adjetivo(triste, sad).
adjetivo(rapido, fast).
adjetivo(lento, slow).
adjetivo(viejo, old).
adjetivo(vieja, old).
adjetivo(joven, young).
adjetivo(nuevo, new).
adjetivo(popular, popular).
adjetivo(primero, first).
adjetivo(primeros, first).
adjetivo(logico, logic).
adjetivo(logica, logic).
adjetivo(computacional, computational).
adjetivo(artificial, artificial).
adjetivo(natural, natural).
adjetivo(experto, expert).
adjetivo(expertos, expert).
adjetivo(pequeno, small).
adjetivo(pequena, small).
adjetivo(bien, fine).
adjetivo(fino, fine).

% COLORES - Con sinónimos
adjetivo(rojo, red).
adjetivo(roja, red).
adjetivo(rojos, red).
adjetivo(rojas, red).
adjetivo(colorado, red).
adjetivo(colorada, red).

adjetivo(azul, blue).
adjetivo(azules, blue).

adjetivo(verde, green).
adjetivo(verdes, green).

adjetivo(amarillo, yellow).
adjetivo(amarilla, yellow).
adjetivo(amarillos, yellow).
adjetivo(amarillas, yellow).

adjetivo(negro, black).
adjetivo(negra, black).
adjetivo(negros, black).
adjetivo(negras, black).

adjetivo(blanco, white).
adjetivo(blanca, white).
adjetivo(blancos, white).
adjetivo(blancas, white).

% Más adjetivos con sinónimos
adjetivo(grande, big).
adjetivo(enorme, big).
adjetivo(gigante, big).

adjetivo(pequeno, small).
adjetivo(pequena, small).
adjetivo(chico, small).
adjetivo(chica, small).
adjetivo(diminuto, small).

adjetivo(feliz, happy).
adjetivo(contento, happy).
adjetivo(alegre, happy).

adjetivo(triste, sad).
adjetivo(deprimido, sad).
adjetivo(melancólico, sad).

% ----------------------------------------------------------------------
% ARTICULOS (Articles)
% Formato: articulo(Espanol, Ingles, Genero, Numero)
% ----------------------------------------------------------------------
articulo(el, the, masculino, singular).
articulo(la, the, femenino, singular).
articulo(los, the, masculino, plural).
articulo(las, the, femenino, plural).
articulo(un, a, masculino, singular).
articulo(una, a, femenino, singular).
articulo(unos, some, masculino, plural).
articulo(unas, some, femenino, plural).

% ----------------------------------------------------------------------
% PREPOSICIONES (Prepositions)
% Formato: preposicion(Espanol, Ingles)
% ----------------------------------------------------------------------
preposicion(en, in).
preposicion(con, with).
preposicion(de, of).
preposicion(a, to).
preposicion(por, by).
preposicion(para, for).
preposicion(sobre, about).
preposicion(desde, from).
preposicion(durante, during).
preposicion(sin, without).

% ----------------------------------------------------------------------
% CONJUNCIONES (Conjunctions)
% Formato: conjuncion(Espanol, Ingles)
% ----------------------------------------------------------------------
conjuncion(y, and).
conjuncion(o, or).
conjuncion(pero, but).
conjuncion(porque, because).
conjuncion(si, if).
conjuncion(que, that).
conjuncion(como, as).
conjuncion(cuando, when).

% ----------------------------------------------------------------------
% ADVERBIOS (Adverbs)
% Formato: adverbio(Espanol, Ingles)
% ----------------------------------------------------------------------
adverbio(muy, very).
adverbio(bien, well).
adverbio(mal, badly).
adverbio(aqui, here).
adverbio(alli, there).
adverbio(ahora, now).
adverbio(entonces, then).
adverbio(siempre, always).
adverbio(nunca, never).
adverbio(hoy, today).
adverbio(manana, tomorrow).
adverbio(ayer, yesterday).
adverbio(comunmente, commonly).
adverbio(no, not).
adverbio(tampoco, neither).
adverbio(tambien, also).

% ----------------------------------------------------------------------
% INTERROGATIVOS (Question Words)
% Formato: interrogativo(Espanol, Ingles)
% ----------------------------------------------------------------------
interrogativo(que, what).
interrogativo(quien, who).
interrogativo(donde, where).
interrogativo(cuando, when).
interrogativo(por_que, why).
interrogativo(como, how).
interrogativo(cual, which).
interrogativo(cuanto, how_much).
interrogativo(cuantos, how_many).
interrogativo(cuantas, how_many).

% ----------------------------------------------------------------------
% PALABRAS ESPECIALES Y EXPRESIONES COMUNES
% Formato: expresion(Espanol, Ingles)
% ----------------------------------------------------------------------
expresion(hola, hello).
expresion('hola!', 'hello!').
expresion(adios, goodbye).
expresion('adios!', 'goodbye!').
expresion(gracias, 'thank you').
expresion('por favor', please).
expresion('de nada', 'you are welcome').
expresion('buenos dias', 'good morning').
expresion('buenas tardes', 'good afternoon').
expresion('buenas noches', 'good night').

% Expresiones interrogativas completas
expresion('como estas', 'how are you').
expresion('cuantos anos tienes', 'how old are you').
expresion('como te llamas', 'what is your name').
expresion('donde esta', 'where is it').
expresion('cuando es', 'when is it').
expresion('cual es', 'which is it').
expresion('cuanto es', 'how much is it').
expresion('cuanto cuesta', 'how much does it cost').

% Expresiones de continuidad
expresion('no entendi', 'i did not understand').
expresion('repite', 'repeat').
expresion('repitelo', 'repeat it').
expresion('otra vez', 'again').
expresion('que dijiste', 'what did you say').

% ----------------------------------------------------------------------
% VERBOS AUXILIARES
% Formato: auxiliar(Espanol, Ingles, Persona, Numero)
% ----------------------------------------------------------------------
auxiliar(se, is, tercera, singular).
auxiliar(se, are, tercera, plural).

% ----------------------------------------------------------------------
% PREDICADOS DE BUSQUEDA Y CONVERSION
% ----------------------------------------------------------------------

% Convertir palabra de espanol a ingles
traducir_palabra(Palabra, Traduccion) :-
    (sustantivo(Palabra, Traduccion, _, _);
     pronombre(Palabra, Traduccion, _, _);
     verbo(Palabra, Traduccion, _, _, _);
     adjetivo(Palabra, Traduccion);
     articulo(Palabra, Traduccion, _, _);
     preposicion(Palabra, Traduccion);
     conjuncion(Palabra, Traduccion);
     adverbio(Palabra, Traduccion);
     interrogativo(Palabra, Traduccion);
     expresion(Palabra, Traduccion);
     auxiliar(Palabra, Traduccion, _, _)).

% Convertir palabra de ingles a espanol
traducir_palabra_inv(Palabra, Traduccion) :-
    (sustantivo(Traduccion, Palabra, _, _);
     pronombre(Traduccion, Palabra, _, _);
     verbo(Traduccion, Palabra, _, _, _);
     adjetivo(Traduccion, Palabra);
     articulo(Traduccion, Palabra, _, _);
     preposicion(Traduccion, Palabra);
     conjuncion(Traduccion, Palabra);
     adverbio(Traduccion, Palabra);
     interrogativo(Traduccion, Palabra);
     expresion(Traduccion, Palabra);
     auxiliar(Traduccion, Palabra, _, _)).

% Obtener categoria de una palabra
categoria_palabra(Palabra, sustantivo) :- sustantivo(Palabra, _, _, _).
categoria_palabra(Palabra, pronombre) :- pronombre(Palabra, _, _, _).
categoria_palabra(Palabra, verbo) :- verbo(Palabra, _, _, _, _).
categoria_palabra(Palabra, adjetivo) :- adjetivo(Palabra, _).
categoria_palabra(Palabra, articulo) :- articulo(Palabra, _, _, _).
categoria_palabra(Palabra, preposicion) :- preposicion(Palabra, _).
categoria_palabra(Palabra, conjuncion) :- conjuncion(Palabra, _).
categoria_palabra(Palabra, adverbio) :- adverbio(Palabra, _).
categoria_palabra(Palabra, interrogativo) :- interrogativo(Palabra, _).
categoria_palabra(Palabra, expresion) :- expresion(Palabra, _).


