import 'package:flutter/material.dart';
import 'package:anilist/anilist_api/manga_api.dart';
import 'package:anilist/widgets/manga_details/manga_overview.dart';
import 'package:anilist/widgets/manga_details/manga_description.dart';
import 'package:anilist/widgets/manga_details/manga_characters.dart';
import 'package:anilist/widgets/manga_details/manga_relations.dart';
import 'package:anilist/widgets/manga_details/manga_staff.dart';
import 'package:anilist/models/manga_model.dart';

class MangaDetailsInfoWidget extends StatefulWidget {
  const MangaDetailsInfoWidget({super.key, required this.manga});

  final MangaDetailsModel manga;

  @override
  _MangaDetailsInfoWidgetState createState() => _MangaDetailsInfoWidgetState();
}

class _MangaDetailsInfoWidgetState extends State<MangaDetailsInfoWidget> {
  late Future<MangaDetailsModel> _mangaDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null && route.settings.arguments != null) {
      final int mangaID = route.settings.arguments as int;
      _mangaDetails = fetchMangaDetails(mangaID);
    } else {
      setState(() {
        _mangaDetails = Future.error('No manga ID provided');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MangaDetailsModel>(
      future: _mangaDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No anime details found'));
        } else {
          final anime = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AnimePostersWidget(
                coverImage: anime.bannerImage,
                subImage: anime.coverImage,
              ),
              _AnimeNameWidget(title: anime.title),
              const SizedBox(
                height: 10,
              ),
              // MangaOverview(),
              MangaDescription(
                description: anime.description,
              ),
              MangaRelations(
                relations: anime.relations,
              ),
              MangaCharacters(
                characters: anime.characters,
              ),
              MangaStaff(
                staff: anime.staff,
              )
            ],
          );
        }
      },
    );
  }
}

class _AnimePostersWidget extends StatelessWidget {
  final String coverImage;
  final String subImage;

  const _AnimePostersWidget(
      {required this.coverImage, required this.subImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          coverImage,
          width: double.infinity,
          height: 230,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 130, left: 20),
          child: Image.network(
            subImage,
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _AnimeNameWidget extends StatelessWidget {
  final String title;

  const _AnimeNameWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 50, right: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(
            height: 30,
          ),
          const Text("Overview"),
        ],
      ),
    );
  }
}
