class PokemonDetailModel {
  List<Stats> stats;
  List<Type> types;
  int? height;
  int? weight;

  PokemonDetailModel({
    required this.stats,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) {
    return PokemonDetailModel(
      stats: List<Stats>.from(json["stats"].map((x) => Stats.fromJson(x))),
      types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
      height: json["height"] ?? 0,
      weight: json["weight"] ?? 0
    );
  }

  Map<String, dynamic> toJson() => {
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
    "height": height,
    "weight": weight,
  };
}

class Stats {
  int baseStat;
  int effort;
  Stat stat;

  Stats({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: Stat.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}

class Stat {
  String name;
  String url;

  Stat({
    required this.name,
    required this.url,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class Type {
  int slot;
  Stat type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    slot: json["slot"],
    type: Stat.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}
