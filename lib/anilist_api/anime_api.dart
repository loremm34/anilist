import 'package:html_unescape/html_unescape.dart';
import 'package:anilist/models/anime_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<List<Anime>> fetchAnimeList(
    {page = 1, perPage = 20, String searchQuery = ''}) async {
  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('https://graphql.anilist.co/'),
  );

  final QueryOptions options = QueryOptions(document: gql('''
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
    '''), variables: {'page': page, 'perPage': perPage, 'search': searchQuery});

  final QueryResult result = await client.query(options);

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
  final GraphQLClient client = GraphQLClient(
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
          season
          status
          duration
          episodes
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

  final QueryResult result = await client.query(options);

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
    status: data['status'] ?? 'Unknown',
    season: data['season'] ?? 'Unknown',
    duration: data['duration'] ?? 'Unknown',
    episodes: data['episodes'] ?? 'Unknown',
    characters: characters,
    relations: relations,
    staff: staff,
  );
}
