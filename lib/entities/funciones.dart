class Funcion {
  String funcion;
  String imagenUrl;
  String descripcion;
  
  Funcion({
    required this.funcion,
    required this.imagenUrl,
    required this.descripcion,
  });
}

List<Funcion> funciones = [
  Funcion(
    funcion: "función cuadratica",
    imagenUrl:
        'https://content.nroc.org/Algebra1/COURSE_TEXT_RESOURCE/U10_L1_T1_text_final_files_es/image007.png',
    descripcion:
        'En otras palabras, un término en la ecuación tendrá un exponente a la potencia de 2. Una ecuación como f ( x ) = x 2 + 4 x − 1 sería un ejemplo de función cuadrática porque tiene x elevado a la segunda potencia como su término más alto.',
  ),
  Funcion(
    funcion: "función seno",
    imagenUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Sine.svg/500px-Sine.svg.png',
    descripcion:
        'La función seno de un ángulo en un triángulo rectángulo se define como la relación entre la longitud del cateto opuesto al ángulo y la longitud de la hipotenusa',
  ),
  Funcion(
    funcion: "función homográfica",
    imagenUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPhnEEhE8Ys9GAVgLkAKu1TzFgpshAB_H1FQ&s',
    descripcion:
        'Define una función homográfica como una función cuya razón es el cociente de dos polinomios de primer grado. Presenta un ejemplo de función homográfica f(x)=(6x-18)/(3x-6) y estudia sus propiedades como su dominio, raíz, corte con el eje y, asíntotas y signo.',
  ),
  Funcion(
    funcion: "función lineal",
    imagenUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/FuncionLineal03.svg/300px-FuncionLineal03.svg.png',
    descripcion:
        'Una función lineal es una función que representa una línea recta en el plano de coordenadas. Por ejemplo, y = 3x - 2 representa una línea recta en un plano de coordenadas',
  ),
  Funcion(
    funcion: "función logaritmica",
    imagenUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbBdmxbmyvbh_hq4EwEw8mwBNqnxDEUx6Fxw&s',
    descripcion:
        'El logaritmo en base 5 de 625 es 4, ya que 625 es igual a 5 a la potencia 4: 5 x 5 x 5 x 5 = 625. Dado un número (el argumento), la función logaritmo se encarga de asignarle un exponente (la potencia) al cual otro número fijo (la base) debe elevarse para obtener el argumento.',
  ),
  Funcion(
    funcion: "función exponencial",
    imagenUrl:
        'https://content.nroc.org/DevelopmentalMath/TEXTGROUP-15-19_RESOURCE/U18_L1_T1_text_final_files_es/image001.png',
    descripcion:
        'Una función exponencial representa la relación entre una entrada y una salida, donde usamos multiplicaciones repetidas en un valor inicial para obtener la salida para cualquier entrada dada. Las funciones exponenciales pueden crecer o decaer muy rápidamente.',
  ),
  Funcion(
    funcion: "función módulo",
    imagenUrl:
        'https://www.geogebra.org/resource/WYFQE9qJ/zSbEKDrQt64Hs4dl/material-WYFQE9qJ.png',
    descripcion:
        'La función módulo se utiliza a menudo en matemáticas y física para expresar cantidades que deben ser no negativas, como la distancia o la magnitud.',
  ),
];
