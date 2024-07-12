import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:anilist/models/manga_model.dart';

Future<List<Manga>> fetchMangaList() async {
  final GraphQLClient client = GraphQLClient(
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

  final QueryResult result = await client.query(options);

  if (result.hasException) {
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
  final GraphQLClient client = GraphQLClient(
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

  final QueryResult result = await client.query(options);

  if (result.hasException) {
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
