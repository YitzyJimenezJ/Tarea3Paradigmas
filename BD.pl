% BD.pl - Base de Datos de Palabras
% Base de datos de traduccion espanol-ingles
% Estructura: palabra(Espanol, Ingles, Categoria)

% ========== ARTICULOS ==========
palabra(el, the, articulo).
palabra(la, the, articulo).
palabra(los, the, articulo).
palabra(las, the, articulo).
palabra(un, a, articulo).
palabra(una, a, articulo).
palabra(unos, some, articulo).
palabra(unas, some, articulo).

% ========== PRONOMBRES ==========
palabra(yo, i, pronombre).
palabra(tu, you, pronombre).
palabra(usted, you, pronombre).
palabra(el, he, pronombre).
palabra(ella, she, pronombre).
palabra(nosotros, we, pronombre).
palabra(nosotras, we, pronombre).
palabra(ustedes, you, pronombre).
palabra(ellos, they, pronombre).
palabra(ellas, they, pronombre).
palabra(eso, that, pronombre).
palabra(esto, this, pronombre).

% ========== SUSTANTIVOS COMUNES ==========
palabra(hola, hello, sustantivo).
palabra(casa, house, sustantivo).
palabra(perro, dog, sustantivo).
palabra(gato, cat, sustantivo).
palabra(libro, book, sustantivo).
palabra(libros, books, sustantivo).
palabra(mesa, table, sustantivo).
palabra(silla, chair, sustantivo).
palabra(computadora, computer, sustantivo).
palabra(computadoras, computers, sustantivo).
palabra(telefono, phone, sustantivo).
palabra(coche, car, sustantivo).
palabra(agua, water, sustantivo).
palabra(comida, food, sustantivo).
palabra(tiempo, time, sustantivo).
palabra(dia, day, sustantivo).
palabra(dias, days, sustantivo).
palabra(noche, night, sustantivo).
palabra(persona, person, sustantivo).
palabra(personas, people, sustantivo).
palabra(hombre, man, sustantivo).
palabra(mujer, woman, sustantivo).
palabra(nino, child, sustantivo).
palabra(ninos, children, sustantivo).
palabra(amigo, friend, sustantivo).
palabra(amigos, friends, sustantivo).
palabra(familia, family, sustantivo).
palabra(trabajo, work, sustantivo).
palabra(escuela, school, sustantivo).
palabra(universidad, university, sustantivo).
palabra(ciudad, city, sustantivo).
palabra(pais, country, sustantivo).
palabra(paises, countries, sustantivo).
palabra(mundo, world, sustantivo).
palabra(ano, year, sustantivo).
palabra(anos, years, sustantivo).
palabra(nombre, name, sustantivo).
palabra(parte, part, sustantivo).
palabra(lugar, place, sustantivo).
palabra(caso, case, sustantivo).
palabra(grupo, group, sustantivo).
palabra(problema, problem, sustantivo).
palabra(mano, hand, sustantivo).

% ========== SUSTANTIVOS TECNICOS (PROLOG/IA) ==========
palabra(prolog, prolog, sustantivo).
palabra(lenguaje, language, sustantivo).
palabra(lenguajes, languages, sustantivo).
palabra(programacion, programming, sustantivo).
palabra(programador, programmer, sustantivo).
palabra(programa, program, sustantivo).
palabra(inteligencia, intelligence, sustantivo).
palabra(artificial, artificial, adjetivo).
palabra(sistema, system, sustantivo).
palabra(sistemas, systems, sustantivo).
palabra(experto, expert, sustantivo).
palabra(expertos, experts, sustantivo).
palabra(teorema, theorem, sustantivo).
palabra(teoremas, theorems, sustantivo).
palabra(demostracion, proving, sustantivo).
palabra(prueba, proof, sustantivo).
palabra(patron, pattern, sustantivo).
palabra(patrones, patterns, sustantivo).
palabra(comparacion, matching, sustantivo).
palabra(coincidencia, matching, sustantivo).
palabra(arbol, tree, sustantivo).
palabra(arboles, trees, sustantivo).
palabra(analisis, parse, sustantivo).
palabra(procesamiento, processing, sustantivo).
palabra(natural, natural, adjetivo).
palabra(linguistica, linguistics, sustantivo).
palabra(computacional, computational, adjetivo).
palabra(codigo, code, sustantivo).
palabra(datos, data, sustantivo).
palabra(informacion, information, sustantivo).
palabra(tecnologia, technology, sustantivo).
palabra(algoritmo, algorithm, sustantivo).
palabra(variable, variable, sustantivo).
palabra(funcion, function, sustantivo).
palabra(metodo, method, sustantivo).
palabra(clase, class, sustantivo).
palabra(objeto, object, sustantivo).

% ========== VERBOS (PRESENTE) ==========
% Verbo SER
palabra(soy, am, verbo).
palabra(eres, are, verbo).
palabra(es, is, verbo).
palabra(somos, are, verbo).
palabra(son, are, verbo).

% Verbo ESTAR
palabra(estoy, am, verbo).
palabra(estas, are, verbo).
palabra(esta, is, verbo).
palabra(estamos, are, verbo).
palabra(estan, are, verbo).

% Verbo TENER
palabra(tengo, have, verbo).
palabra(tienes, have, verbo).
palabra(tiene, has, verbo).
palabra(tenemos, have, verbo).
palabra(tienen, have, verbo).

% Verbo HACER
palabra(hago, do, verbo).
palabra(haces, do, verbo).
palabra(hace, does, verbo).
palabra(hacemos, do, verbo).
palabra(hacen, do, verbo).

% Verbo IR
palabra(voy, go, verbo).
palabra(vas, go, verbo).
palabra(va, goes, verbo).
palabra(vamos, go, verbo).
palabra(van, go, verbo).

% Verbo COMER
palabra(como, eat, verbo).
palabra(comes, eat, verbo).
palabra(come, eats, verbo).
palabra(comemos, eat, verbo).
palabra(comen, eat, verbo).

% Verbo VER
palabra(veo, see, verbo).
palabra(ves, see, verbo).
palabra(ve, sees, verbo).
palabra(vemos, see, verbo).
palabra(ven, see, verbo).

% Verbo DECIR
palabra(digo, say, verbo).
palabra(dices, say, verbo).
palabra(dice, says, verbo).
palabra(decimos, say, verbo).
palabra(dicen, say, verbo).

% Verbo PODER
palabra(puedo, can, verbo).
palabra(puedes, can, verbo).
palabra(puede, can, verbo).
palabra(podemos, can, verbo).
palabra(pueden, can, verbo).

% Verbo QUERER
palabra(quiero, want, verbo).
palabra(quieres, want, verbo).
palabra(quiere, wants, verbo).
palabra(queremos, want, verbo).
palabra(quieren, want, verbo).

% Verbo DAR
palabra(doy, give, verbo).
palabra(das, give, verbo).
palabra(da, gives, verbo).
palabra(damos, give, verbo).
palabra(dan, give, verbo).

% Verbo SABER
palabra(se, know, verbo).
palabra(sabes, know, verbo).
palabra(sabe, knows, verbo).
palabra(sabemos, know, verbo).
palabra(saben, know, verbo).

% Verbo LLEGAR
palabra(llego, arrive, verbo).
palabra(llegas, arrive, verbo).
palabra(llega, arrives, verbo).
palabra(llegamos, arrive, verbo).
palabra(llegan, arrive, verbo).

% Verbo LLEVAR
palabra(llevo, carry, verbo).
palabra(llevas, carry, verbo).
palabra(lleva, carries, verbo).
palabra(llevamos, carry, verbo).
palabra(llevan, carry, verbo).

% Verbo SEGUIR
palabra(sigo, follow, verbo).
palabra(sigues, follow, verbo).
palabra(sigue, remains, verbo).
palabra(seguimos, follow, verbo).
palabra(siguen, follow, verbo).

% Verbo UTILIZAR/USAR
palabra(utilizo, use, verbo).
palabra(utilizas, use, verbo).
palabra(utiliza, uses, verbo).
palabra(utilizamos, use, verbo).
palabra(utilizan, use, verbo).
palabra(uso, use, verbo).
palabra(usas, use, verbo).
palabra(usa, uses, verbo).
palabra(usamos, use, verbo).
palabra(usan, use, verbo).

% Verbo ASOCIAR
palabra(asocio, associate, verbo).
palabra(asocias, associate, verbo).
palabra(asocia, associates, verbo).
palabra(asociamos, associate, verbo).
palabra(asocian, associate, verbo).

% Verbo PERMANECER/QUEDAR
palabra(permanezco, remain, verbo).
palabra(permaneces, remain, verbo).
palabra(permanece, remains, verbo).
palabra(permanecemos, remain, verbo).
palabra(permanecen, remain, verbo).
palabra(quedo, remain, verbo).
palabra(quedas, remain, verbo).
palabra(queda, remains, verbo).
palabra(quedamos, remain, verbo).
palabra(quedan, remain, verbo).

% Verbo TRABAJAR
palabra(trabajo, work, verbo).
palabra(trabajas, work, verbo).
palabra(trabaja, works, verbo).
palabra(trabajamos, work, verbo).
palabra(trabajan, work, verbo).

% Verbo CREAR/HACER
palabra(creo, create, verbo).
palabra(creas, create, verbo).
palabra(crea, creates, verbo).
palabra(creamos, create, verbo).
palabra(crean, create, verbo).

% Verbo ESCRIBIR
palabra(escribo, write, verbo).
palabra(escribes, write, verbo).
palabra(escribe, writes, verbo).
palabra(escribimos, write, verbo).
palabra(escriben, write, verbo).

% Verbo LEER
palabra(leo, read, verbo).
palabra(lees, read, verbo).
palabra(lee, reads, verbo).
palabra(leemos, read, verbo).
palabra(leen, read, verbo).

% Verbo HABLAR
palabra(hablo, speak, verbo).
palabra(hablas, speak, verbo).
palabra(habla, speaks, verbo).
palabra(hablamos, speak, verbo).
palabra(hablan, speak, verbo).

% Verbo JUGAR
palabra(juego, play, verbo).
palabra(juegas, play, verbo).
palabra(juega, plays, verbo).
palabra(jugamos, play, verbo).
palabra(juegan, play, verbo).

% ========== PARTICIPIOS Y FORMAS VERBALES ==========
palabra(siendo, being, verbo).
palabra(popular, popular, adjetivo).
palabra(asociado, associated, verbo).
palabra(asociada, associated, verbo).
palabra(usado, used, verbo).
palabra(usada, used, verbo).
palabra(utilizado, used, verbo).
palabra(utilizada, used, verbo).

% ========== ADJETIVOS ==========
palabra(bueno, good, adjetivo).
palabra(buena, good, adjetivo).
palabra(malo, bad, adjetivo).
palabra(mala, bad, adjetivo).
palabra(grande, big, adjetivo).
palabra(grandes, big, adjetivo).
palabra(pequeno, small, adjetivo).
palabra(pequena, small, adjetivo).
palabra(nuevo, new, adjetivo).
palabra(nueva, new, adjetivo).
palabra(viejo, old, adjetivo).
palabra(vieja, old, adjetivo).
palabra(feliz, happy, adjetivo).
palabra(triste, sad, adjetivo).
palabra(bonito, beautiful, adjetivo).
palabra(bonita, beautiful, adjetivo).
palabra(feo, ugly, adjetivo).
palabra(fea, ugly, adjetivo).
palabra(rapido, fast, adjetivo).
palabra(rapida, fast, adjetivo).
palabra(lento, slow, adjetivo).
palabra(lenta, slow, adjetivo).
palabra(alto, tall, adjetivo).
palabra(alta, tall, adjetivo).
palabra(bajo, short, adjetivo).
palabra(baja, short, adjetivo).
palabra(caliente, hot, adjetivo).
palabra(frio, cold, adjetivo).
palabra(fria, cold, adjetivo).
palabra(logico, logic, adjetivo).
palabra(logica, logic, adjetivo).
palabra(logicos, logic, adjetivo).
palabra(primero, first, adjetivo).
palabra(primera, first, adjetivo).
palabra(primeros, first, adjetivo).
palabra(primeras, first, adjetivo).
palabra(ultimo, last, adjetivo).
palabra(ultima, last, adjetivo).
palabra(comun, common, adjetivo).
palabra(comunes, common, adjetivo).
palabra(importante, important, adjetivo).
palabra(diferentes, different, adjetivo).
palabra(diferente, different, adjetivo).
palabra(mismo, same, adjetivo).
palabra(misma, same, adjetivo).
palabra(otro, other, adjetivo).
palabra(otra, other, adjetivo).
palabra(otros, others, adjetivo).
palabra(otras, others, adjetivo).

% ========== ADVERBIOS ==========
palabra(hoy, today, adverbio).
palabra(ayer, yesterday, adverbio).
palabra(manana, tomorrow, adverbio).
palabra(ahora, now, adverbio).
palabra(aqui, here, adverbio).
palabra(alli, there, adverbio).
palabra(alla, there, adverbio).
palabra(siempre, always, adverbio).
palabra(nunca, never, adverbio).
palabra(bien, well, adverbio).
palabra(mal, badly, adverbio).
palabra(muy, very, adverbio).
palabra(mucho, much, adverbio).
palabra(mucha, much, adverbio).
palabra(poco, little, adverbio).
palabra(poca, little, adverbio).
palabra(mas, more, adverbio).
palabra(menos, less, adverbio).
palabra(tambien, also, adverbio).
palabra(tampoco, neither, adverbio).
palabra(solo, only, adverbio).
palabra(solamente, only, adverbio).
palabra(comunmente, commonly, adverbio).
palabra(generalmente, generally, adverbio).
palabra(normalmente, normally, adverbio).
palabra(realmente, really, adverbio).
palabra(actualmente, currently, adverbio).

% ========== PREPOSICIONES ==========
palabra(en, in, preposicion).
palabra(de, of, preposicion).
palabra(a, to, preposicion).
palabra(con, with, preposicion).
palabra(sin, without, preposicion).
palabra(por, for, preposicion).
palabra(para, for, preposicion).
palabra(sobre, about, preposicion).
palabra(bajo, under, preposicion).
palabra(entre, between, preposicion).
palabra(desde, from, preposicion).
palabra(hasta, until, preposicion).
palabra(durante, during, preposicion).
palabra(contra, against, preposicion).
palabra(segun, according, preposicion).

% ========== CONJUNCIONES ==========
palabra(y, and, conjuncion).
palabra(e, and, conjuncion).
palabra(o, or, conjuncion).
palabra(u, or, conjuncion).
palabra(pero, but, conjuncion).
palabra(porque, because, conjuncion).
palabra(cuando, when, conjuncion).
palabra(aunque, although, conjuncion).
palabra(mientras, while, conjuncion).

% ========== INTERROGATIVOS ==========
palabra(que, what, interrogativo).
palabra(quien, who, interrogativo).
palabra(quienes, who, interrogativo).
palabra(donde, where, interrogativo).
palabra(cuando, when, interrogativo).
palabra(cuanto, how, interrogativo).
palabra(cuanta, how, interrogativo).
palabra(cuantos, how, interrogativo).
palabra(cuantas, how, interrogativo).
palabra(cual, which, interrogativo).
palabra(cuales, which, interrogativo).
palabra(por_que, why, interrogativo).

% ========== PALABRAS ESPECIALES (contexto dependiente) ==========
% COMO - puede ser verbo o interrogativo
palabra(como, eat, verbo).      % yo como (I eat)
palabra(como, how, interrogativo).  % como estas (how are you)
palabra(como, as, conjuncion).      % como te dije (as I told you)

% QUE - puede ser pronombre relativo o interrogativo
palabra(que, that, pronombre_relativo).  % el libro que lei (the book that I read)
palabra(que, what, interrogativo).       % que quieres (what do you want)

% SI - puede ser conjuncion o adverbio
palabra(si, if, conjuncion).    % si vienes (if you come)
palabra(si, yes, adverbio).     % si, acepto (yes, I accept)

% ========== NUMERALES ==========
palabra(uno, one, numeral).
palabra(una, one, numeral).
palabra(dos, two, numeral).
palabra(tres, three, numeral).
palabra(cuatro, four, numeral).
palabra(cinco, five, numeral).
palabra(seis, six, numeral).
palabra(siete, seven, numeral).
palabra(ocho, eight, numeral).
palabra(nueve, nine, numeral).
palabra(diez, ten, numeral).

% ========== OTROS ==========
palabra(no, no, adverbio).
palabra(not, no, adverbio).
palabra(yes, si, adverbio).

% ========== PALABRAS AMBIGUAS EN INGLES ==========
% ARE - puede ser verbo ser/estar
palabra(eres, are, verbo).
palabra(estas, are, verbo).
palabra(somos, are, verbo).
palabra(estan, are, verbo).
palabra(son, are, verbo).

% CAN - puede ser verbo poder o sustantivo lata
palabra(puedo, can, verbo).
palabra(puedes, can, verbo).
palabra(puede, can, verbo).
palabra(podemos, can, verbo).
palabra(pueden, can, verbo).
palabra(lata, can, sustantivo).

% ========== PALABRAS ADICIONALES PARA PROLOG ==========
palabra(continua, continues, verbo).
palabra(sigue, continues, verbo).
palabra(mantiene, maintains, verbo).
palabra(conserva, remains, verbo).
palabra(ensenanza, teaching, sustantivo).
palabra(aprendizaje, learning, sustantivo).
palabra(conocimiento, knowledge, sustantivo).
palabra(razonamiento, reasoning, sustantivo).
palabra(logico, logical, adjetivo).
palabra(declarativo, declarative, adjetivo).
palabra(procedural, procedural, adjetivo).

% ========== PALABRAS AMBIGUAS ADICIONALES ==========
% BAJO - puede ser preposicion, adjetivo o verbo
palabra(bajo, under, preposicion).  % bajo la mesa (under the table)
palabra(bajo, short, adjetivo).     % el es bajo (he is short)
palabra(bajo, low, adjetivo).       % volumen bajo (low volume)

% SOBRE - puede ser preposicion o sustantivo
palabra(sobre, about, preposicion).  % hablar sobre algo (talk about)
palabra(sobre, on, preposicion).     % sobre la mesa (on the table)
palabra(sobre, envelope, sustantivo). % un sobre (an envelope)

% LIBRO - sustantivo
palabra(libro, book, sustantivo).
palabra(libro, free, verbo).        % yo libro (I free - less common)

% PARA - preposicion
palabra(para, for, preposicion).
palabra(para, to, preposicion).
palabra(para, stop, verbo).         % el auto para (the car stops)

% ESTE - puede ser pronombre demostrativo o punto cardinal
palabra(este, this, pronombre).     % este libro (this book)
palabra(este, east, sustantivo).    % el este (the east)

% BIEN - adverbio o sustantivo
palabra(bien, well, adverbio).      % muy bien (very well)
palabra(bien, good, sustantivo).    % el bien comun (the common good)

% MEDIA - puede ser sustantivo o adjetivo
palabra(media, half, sustantivo).   % media hora (half hour)
palabra(media, average, sustantivo). % la media (the average)
palabra(media, stocking, sustantivo). % una media (a stocking)

% BANCO - sustantivo con multiples significados
palabra(banco, bank, sustantivo).   % banco financiero (financial bank)
palabra(banco, bench, sustantivo).  % banco de plaza (park bench)

% CAPITAL - sustantivo
palabra(capital, capital, sustantivo). % ciudad capital o dinero

% DERECHO/DERECHA - adjetivo/sustantivo
palabra(derecho, right, sustantivo).  % el derecho (the right/law)
palabra(derecho, straight, adjetivo). % en linea derecho (straight line)
palabra(derecha, right, sustantivo).  % a la derecha (to the right)

% IZQUIERDO/IZQUIERDA
palabra(izquierdo, left, adjetivo).
palabra(izquierda, left, sustantivo).

% ORDEN - puede ser masculino o femenino con diferente significado
palabra(orden, order, sustantivo).  % el orden (sequence) / la orden (command)

% Regla auxiliar para buscar traduccion bidireccionalmente
traducir_palabra(Espanol, Ingles, Cat) :- 
    palabra(Espanol, Ingles, Cat).

traducir_palabra(Ingles, Espanol, Cat) :- 
    palabra(Espanol, Ingles, Cat).