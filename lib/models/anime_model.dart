import 'package:graphql/client.dart';
import 'package:html_unescape/html_unescape.dart';

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
  final List<Character> characters;
  final List<Relation> relations;
  final List<Staff> staff;

  AnimeDetailsModel({
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

Future<List<Anime>> fetchAnimeList({page = 1, perPage = 20, String searchQuery = ''}) async {
  final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://graphql.anilist.co/'),
  );

  final QueryOptions options = QueryOptions(
    document: gql('''
      query (\$page: Int, \$perPage: Int) {
        Page(page: \$page, perPage:\$perPage) {
          media {
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
    variables: {'page': page, 'perPage': perPage, 'search': searchQuery}
  );

  final QueryResult result = await _client.query(options);

  if (result.hasException) {
    throw Exception('Failed to load anime list');
  }

  final List<dynamic> data = result.data!['Page']['media'];
  return data.map((item) {
    return Anime(
      id: item['id'],
      title: item['title']['romaji'] ??
          item['title']['english'] ??
          'Unknown Title',
      coverImage: item['coverImage']['extraLarge'] ?? '',
    );
  }).toList();
}

Future<AnimeDetailsModel> fetchAnimeDetails(int id) async {
  final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://graphql.anilist.co/'),
  );

  final QueryOptions options = QueryOptions(
    document: gql('''
      query (\$id: Int) {
        Media(id: \$id) {
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
              voiceActors {
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
    throw Exception('Failed to load anime details');
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
    final actorList = char['voiceActors'] as List;
    final hasActor = actorList.isNotEmpty;
    return Character(
      name: char['node']['name']['full'] ?? 'Unknown',
      image: char['node']['image']['large'] ?? '',
      actorName:
          hasActor ? actorList[0]['name']['full'] ?? 'Unknown' : 'Unknown',
      actorImage: hasActor ? actorList[0]['image']['large'] ?? '' : '',
    );
  }).toList();

  return AnimeDetailsModel(
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
