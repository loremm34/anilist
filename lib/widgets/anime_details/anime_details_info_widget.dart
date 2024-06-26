import 'package:flutter/material.dart';
import 'package:anilist/models/anime_model.dart';
import 'package:anilist/widgets/anime_details/anime_overview.dart';
import 'package:anilist/widgets/anime_details/anime_description.dart';
import 'package:anilist/widgets/anime_details/anime_characters.dart';
import 'package:anilist/widgets/anime_details/anime_relations.dart';
import 'package:anilist/widgets/anime_details/anime_staff.dart';

class AnimeDetailsInfoWidget extends StatefulWidget {
  const AnimeDetailsInfoWidget({super.key});

  @override
  _AnimeDetailsInfoWidgetState createState() => _AnimeDetailsInfoWidgetState();
}

class _AnimeDetailsInfoWidgetState extends State<AnimeDetailsInfoWidget> {
  late Future<AnimeDetailsModel> _animeDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int animeId = ModalRoute.of(context)!.settings.arguments as int;
    _animeDetails = fetchAnimeDetails(animeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AnimeDetailsModel>(
      future: _animeDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No anime details found'));
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
              SizedBox(
                height: 10,
              ),
              AnimeOverview(),
              AnimeDescription(
                description: anime.description,
              ),
              AnimeRelations(
                relations: anime.relations,
              ),
              AnimeCharacters(
                characters: anime.characters,
              ),
              AnimeStaff(
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
          padding: EdgeInsets.only(top: 130, left: 20),
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
      padding: EdgeInsets.only(left: 20, top: 50, right: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(
            height: 30,
          ),
          Text("Overview"),
        ],
      ),
    );
  }
}
