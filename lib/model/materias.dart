class Materia{
  final int id;
  String nomeMateria;
  String dataEscolhida;
  String anotacoes;
  String pathImg;
  String pathPdf;

  Materia({this.id, this.nomeMateria, this.dataEscolhida, this.anotacoes,
      this.pathImg, this.pathPdf});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome_materia': nomeMateria,
      'data_escolhida': dataEscolhida,
      'anotacoes': anotacoes,
      'path_pdf': pathImg,
      'path_img': pathPdf,
    };
  }
}
