
class SpecialDates{
  String tituloData;
  String descricaoData;
  String imageData;

  SpecialDates( this.tituloData, this.descricaoData,this.imageData);

  SpecialDates.fromJson(Map<String, dynamic> json) {
    tituloData = json['titulo_data'];
    descricaoData = json['descricao_data'];
    imageData = json['imagem_data'];

  }
}