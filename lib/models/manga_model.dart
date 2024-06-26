import 'package:graphql/client.dart';
import 'package:html_unescape/html_unescape.dart';

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

Future<List<Manga>> fetchMangaList() async {
  final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://graphql.anilist.co/'),
  );

  final QueryOptions options = QueryOptions(
    document: gql('''
      query {
        Page(page: 1, perPage: 50) {
          media(type: MANGA) {
            id
            title {
              romaji
              english
            }
            coverImage {
              extraLarge
            }
          }
        }
      }
    '''),
  );

  final QueryResult result = await _client.query(options);

  if (result.hasException) {
    print(result.exception.toString());
    throw Exception('Failed to load manga list');
  }

  final List<dynamic> data = result.data!['Page']['media'];
  return data.map((item) {
    return Manga(
      id: item['id'],
      title: item['title']['romaji'] ??
          item['title']['english'] ??
          'Unknown Title',
      coverImage: item['coverImage']['extraLarge'] ?? '',
    );
  }).toList();
}

Future<MangaDetailsModel> fetchMangaDetails(int id) async {
  final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://graphql.anilist.co/'),
  );

  final QueryOptions options = QueryOptions(
    document: gql('''
      query (\$id: Int) {
        Media(id: \$id, type: MANGA) {
          id
          title {
            romaji
            english
          }
          coverImage {
            large
          }
          bannerImage
          description
          characters {
            edges {
              node {
                name {
                  full
                }
                image {
                  large
                }
              }
            }
          }
          relations {
            edges {
              node {
                title {
                  romaji
                  english
                }
                coverImage {
                  large
                }
              }
              relationType
            }
          }
          staff {
            edges {
              node {
                name {
                  full
                }
                image {
                  large
                }
              }
              role
            }
          }
        }
      }
    '''),
    variables: {'id': id},
  );

  final QueryResult result = await _client.query(options);

  if (result.hasException) {
    print(result.exception.toString());
    if (result.exception!.graphqlErrors.isNotEmpty) {
      for (var error in result.exception!.graphqlErrors) {
        print('GraphQL Error: ${error.message}');
      }
    }
    if (result.exception!.linkException != null) {
      print('Link Exception: ${result.exception!.linkException.toString()}');
    }
    throw Exception('Failed to load manga details');
  }

  final data = result.data!['Media'];
  final unescape = HtmlUnescape();
  final cleanDescription = unescape.convert(data['description'] ?? '');

  final List<Staff> staff = (data['staff']['edges'] as List).map((staff) {
    return Staff(
      name: staff['node']['name']['full'] ?? 'Unknown',
      image: staff['node']['image']['large'] ?? '',
      role: staff['role'] ?? 'Unknown',
    );
  }).toList();

  final List<Relation> relations =
      (data['relations']['edges'] as List).map((rel) {
    return Relation(
      title: rel['node']['title']['romaji'] ??
          rel['node']['title']['english'] ??
          'Unknown Title',
      image: rel['node']['coverImage']['large'] ?? '',
      type: rel['relationType'] ?? 'Unknown',
    );
  }).toList();

  final List<Character> characters =
      (data['characters']['edges'] as List).map((char) {
    return Character(
      name: char['node']['name']['full'] ?? 'Unknown',
      image: char['node']['image']['large'] ?? '',
    );
  }).toList();

  return MangaDetailsModel(
    id: data['id'],
    title:
        data['title']['romaji'] ?? data['title']['english'] ?? 'Unknown Title',
    coverImage: data['coverImage']['large'] ?? '',
    bannerImage: data['bannerImage'] ?? '',
    description: cleanDescription,
    characters: characters,
    relations: relations,
    staff: staff,
  );
}
