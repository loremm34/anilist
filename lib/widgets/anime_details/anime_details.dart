import 'package:flutter/material.dart';
import 'package:anilist/widgets/anime_details/anime_details_info_widget.dart';

class AnimeDetails extends StatefulWidget {
  const AnimeDetails({super.key, required this.animeID});

  final int animeID;

  @override
  State<AnimeDetails> createState() => _AnimeDetailsState();
}

class _AnimeDetailsState extends State<AnimeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 12, 19),
      appBar: AppBar(
        title: Text(""),
      ),
      body: ListView(
        children: [
          AnimeDetailsInfoWidget(),
        ],
      ),
    );
  }
}
