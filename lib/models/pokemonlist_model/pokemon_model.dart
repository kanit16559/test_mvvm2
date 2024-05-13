import '../../core/helper/helper.dart';

class PokemonModel {
  String? id;
  String name;
  String url;
  String imageUrl;

  PokemonModel({
    required this.id,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    String strUrl = json["url"];
    String strId = Helper.convertStringUrlToPokemonId(strUrl);
    String strImageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$strId.png';
    return PokemonModel(
      id: strId,
      name: json["name"],
      url: strUrl,
      imageUrl: strImageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "imageUrl": imageUrl,
  };
}