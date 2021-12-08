 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.

 resource(img_principal, image, image('img_principal.jpg')).
 resource(portada, image, image('portada.jpg')).
 resource(gambusia_Affinis, image, image('inf_gambusia.jpg')).
 resource(luchadores_de_Siam, image, image('inf_siam.jpg')).
 resource(perca_Trepadora, image, image('inf_perca.jpg')).
 resource(pez_Joya, image, image('inf_joya.jpg')).
 resource(gambusia_Punctata, image, image('inf_punctata.jpg')).
 resource(lo_siento_la_clasificación_no_fue_encontrada, image, image('desconocido.jpg')).
 resource(boca_pequeña, image, image('boca_pequeña.jpg')).
 resource(dientes_puntiagudos, image, image('dientes_puntiagudos.jpg')).
 resource(america_sur, image, image('america_sur.jpg')).
 resource(diferencia, image, image('diferencia_tam.jpg')).
 resource(manchas, image, image('manchas_cuerpo.jpg')).
 resource(siete_cm, image, image('7cm.jpg')).
 resource(perca_trepadora,image, image('perca_trepadora.jpg')).
 resource(africa, image, image('africa.jpg')).
 resource(asia, image, image('asia.jpg')).
 resource(canales_laberinto, image, image('canales_laberinto.jpg')).
 resource(cola_redonda, image, image('cola_redonda.jpg')).
 resource(color_azul, image, image('color_azul.jpg')).
 resource(color_gris, image, image('color_gris.jpg')).
 resource(color_rojo, image, image('color_rojo.jpg')).
 resource(manchas_negras, image, image('manchas_negras.gif')).
 resource(rayas_rojas, image, image('pez_siam.jpg')).
 resource(r_verdes, image, image('r_verdes.jpg')).
 resource(mundo, image, image('todo_mundo.jpg')).


 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
  mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
  imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
  botones:-borrado,
                send(@boton, free),
                send(@btntratamiento,free),
                mostrar_diagnostico(Enfermedad),
                send(@texto, selection('La clasificación a partir de los datos es:')),
                send(@resp1, selection(Enfermedad)),
                new(@boton, button('Iniciar consulta',
                message(@prolog, botones)
                )),

                new(@btntratamiento,button('Detalles e Información',
                message(@prolog, mostrar_tratamiento,Enfermedad)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btntratamiento,point(138,450)).



  mostrar_tratamiento(X):-new(@tratam, dialog('Información')),
                          send(@tratam, append, label(nombre, 'Explicacion: ')),
                          send(@tratam, display,@lblExp1,point(70,51)),
                          send(@tratam, display,@lblExp2,point(50,80)),
                          tratamiento(X),
                          send(@tratam, transient_for, @main),
                          send(@tratam, open_centered).

tratamiento(X):- send(@lblExp1,selection('De Acuerdo a La Clasificación Los Detalles e Informaciones son:')),
                 mostrar_imagen_tratamiento(@tratam,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   preguntar(Preg,Resp):-new(Di,dialog('Colsultar Datos:')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  interfaz_principal:-new(@main,dialog('Sistema Experto en la Clasificación de Peces',
        size(1000,1000))),
        new(@texto, label(nombre,'El Diagnostico a partir de los datos es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),
        new(@boton, button('Iniciar consulta',message(@prolog, botones))),

        new(@btntratamiento,button('Â¿Tratamiento?')),

        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        send(@main, display,@texto,point(20,350)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(20,380)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  crea_interfaz_inicio:- new(@interfaz,dialog('Bienvenido al Sistema Experto en la clasificación de Peces',
  size(1000,1000))),

  mostrar_imagen(@interfaz, portada),

  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIR',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.

/* BASE DE CONOCIMIENTOS: para clasificar los peces 640x480 300x300
*/

conocimiento('gambusia_Affinis',
['el pez tiene la boca pequeña', 'el pez tiene los dientes puntiagudos',
'el pez vive en América del Sur','el pez macho mide 2-3 cm. y la hembra mide 3-5 cm.','el pez tiene manchas por todo el cuerpo']).

conocimiento('luchadores_de_Siam',
['el pez tiene los dientes puntiagudos', 'el pez tiene canales de laberintos para respirar fuera del agua', 'el pez vive en Asia','el pez es de 7cm.', 'el pez es de color azul', 'el pez tiene rayas rojas']).

conocimiento('pez_Joya',['el pez tiene cola redonda', 'el pez tiene la boca pequeña', 'el pez tiene los dientes puntiagudos', 'el pez vive en África', 'el pez es de color rojo', 'el pez tiene manchas negras']).

conocimiento('perca_Trepadora',
['el pez tiene una estatura de 25cm.', 'el pez tiene canales de laberintos para respirar fuera del agua', 'el pez vive por todos los rios del Mundo']).

conocimiento('gambusia_Punctata',
['el pez tiene los dientes puntiagudos','el pez tiene la boca pequeña','el pez vive en América del Sur','el pez macho mide 2-3 cm. y la hembra mide 3-5 cm.','el pez es de color gris','el pez tiene rayas verdes']).

id_imagen_preg('el pez tiene la boca pequeña','boca_pequeña').
id_imagen_preg('el pez tiene los dientes puntiagudos','dientes_puntiagudos').
id_imagen_preg('el pez tiene manchas por todo el cuerpo','manchas').
id_imagen_preg('el pez tiene rayas verdes','r_verdes').
id_imagen_preg('el pez tiene cola redonda','cola_redonda').
id_imagen_preg('el pez tiene manchas negras','manchas_negras').
id_imagen_preg('el pez tiene canales de laberintos para respirar fuera del agua','canales_laberinto').
id_imagen_preg('el pez tiene rayas rojas','rayas_rojas').
id_imagen_preg('el pez vive en América del Sur','america_sur').
id_imagen_preg('el pez vive en África','africa').
id_imagen_preg('el pez vive en Asia','asia').
id_imagen_preg('el pez vive por todos los rios del Mundo','mundo').
id_imagen_preg('el pez macho mide 2-3 cm. y la hembra mide 3-5 cm.','diferencia').
id_imagen_preg('el pez es de 7cm.','siete_cm').
id_imagen_preg('el pez tiene una estatura de 25cm.','perca_trepadora').
id_imagen_preg('el pez es de color azul','color_azul').
id_imagen_preg('el pez es de color gris','color_gris').
id_imagen_preg('el pez es de color rojo','color_rojo').


 /* MOTOR DE INFERENCIA: */
:- dynamic conocido/1.

  mostrar_diagnostico(X):-haz_diagnostico(X),clean_scratchpad.
  mostrar_diagnostico(lo_siento_la_clasificación_no_fue_encontrada):-clean_scratchpad .

  haz_diagnostico(Diagnosis):-
                            obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
                            prueba_presencia_de(Diagnosis, ListaDeSintomas).


obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
                            conocimiento(Diagnosis, ListaDeSintomas).


prueba_presencia_de(Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head | Tail]):- prueba_verdad_de(Diagnosis, Head),
                                              prueba_presencia_de(Diagnosis, Tail).


prueba_verdad_de(Diagnosis, Sintoma):- conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(Diagnosis, Sintoma, Reply), Reply = 'si'.


pregunta_sobre(Diagnosis, Sintoma, Reply):- preguntar(Sintoma,Respuesta),
                          process(Diagnosis, Sintoma, Respuesta, Reply).


process(Diagnosis, Sintoma, si, si):- asserta(conocido(Sintoma)).
process(Diagnosis, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))).


clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).




