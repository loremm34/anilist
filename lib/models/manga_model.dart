class Manga {
  final int id;
  final String title;
  final String coverImage;

  Manga({
    required this.id,
    required this.title,
    required this.coverImage,
  });
}

class Character {
  final String name;
  final String image;

  Character({
    required this.name,
    required this.image,
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

class MangaDetailsModel {
  final int id;
  final String title;
  final String coverImage;
  final String bannerImage;
  final String description;
  final List<Character> characters;
  final List<Relation> relations;
  final List<Staff> staff;

  MangaDetailsModel({
    required this.id,
    required this.title,
    required this.coverImage,
    required this.bannerImage,
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
