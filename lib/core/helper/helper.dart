
class Helper {

  static String convertStringUrlToPokemonId(String str){
    var regex = RegExp(r'(\d+)/?$');
    var match = regex.firstMatch(str);

    if (match != null) {
      return match.group(1) ?? "0";
    } else {
      return "0";
    }
  }

  static Map<String, dynamic> getHeaders() {
    return {}..removeWhere((key, value) => value == null);
  }

}