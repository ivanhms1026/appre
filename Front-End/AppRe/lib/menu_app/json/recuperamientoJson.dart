class recuperamientoHombro {
  String titulo;
  String informacionBasicaDos;
  String imageUrl;
  int item;
  String tituloPatologia;
  String informacionFases;

  recuperamientoHombro({required this.titulo,
    required this.informacionBasicaDos,
    required this.imageUrl,
    required this.item,
    required this.tituloPatologia,
    required this.informacionFases});
}

List<recuperamientoHombro> recuperamientoListHombro = [
  recuperamientoHombro(
      titulo: "Hombro",
      informacionBasicaDos: "Transforma tu hombro con ejercicios diarios y recupera tu fuerza.",
      imageUrl: 'assets/deporte3.jpg',
      item: 0,
      tituloPatologia: "Manguito Rotador",
      informacionFases:
      "Tres fases, una meta, recupera tu hombro y mejora tu desempeño ocupacinal con las actividades de la vida diaria"),
  recuperamientoHombro(
      titulo: "Codo",
      informacionBasicaDos: "Transforma tu codo débil en uno fuerte y saludable con ejercicios diarios.",
      imageUrl: 'assets/deporte4.jpg',
      item: 1,
      tituloPatologia: "Epicondilitis",
      informacionFases:
      "Tres fases, una meta, recupera tu codo y mejora tu desempeño ocupacinal con las actividades de la vida diaria"),
  recuperamientoHombro(
      titulo: "Muñeca",
      informacionBasicaDos: "Fortalece tu muñeca con ejercicios diarios para dejar atrás el dolor y la debilidad. ",
      imageUrl: 'assets/deporte6.PNG',
      item: 2,
      tituloPatologia: "Tendinitis de Quervain",
      informacionFases:
      "Tres fases, una meta, recupera tu muñeca y mejora tu desempeño ocupacinal con las actividades de la vida diaria"),
  recuperamientoHombro(
      titulo: "Mano",
      informacionBasicaDos:
      "Recupera la destreza de tu mano mediante ejercicios diarios, logrando una fuerza y una mejor precisión.",
      imageUrl: 'assets/deporte5.jpg',
      item: 3,
      tituloPatologia: "Túnel del Carpo",
      informacionFases:
      "Tres fases, una meta, recupera tu mano y mejora tu desempeño ocupacinal con las actividades de la vida diaria"),
];
