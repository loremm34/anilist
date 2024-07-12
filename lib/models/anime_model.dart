class Anime {
  final int id;
  final String title;
  final String coverImage;

  Anime({
    required this.id,
    required this.title,
    required this.coverImage,
  });
}

class Character {
  final String name;
  final String image;
  final String actorName;
  final String actorImage;

  Character({
    required this.name,
    required this.image,
    required this.actorName,
    required this.actorImage,
  });
}

class Relation {
  final String title;
  final String image;
  final String type;

  Relation({
    required this.title,
    required this.image,
    required this.type,
  });
}

class AnimeDetailsModel {
  final int id;
  final String title;
  final String coverImage;
  final String bannerImage;
  final String description;
  final String status;
  final String season;
  final int duration;
  final int episodes;
  final List<Character> characters;
  final List<Relation> relations;
  final List<Staff> staff;

  AnimeDetailsModel({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.bannerImage,
    required this.status,
    required this.season,
    required this.duration,
    required this.episodes,
    required this.description,
    required this.characters,
    required this.relations,
    required this.staff,
  });
}

class Staff {
  final String name;
  final String image;
  final String role;

  Staff({
    required this.name,
    required this.image,
    required this.role,
  });
}
