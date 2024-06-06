import 'package:flutter/material.dart';
import 'package:anilist/widgets/manga_details/manga_details_info_widget.dart';


class MangaDetails extends StatefulWidget {
  const MangaDetails({super.key, required this.mangaID});

  final int mangaID;

  @override
  State<MangaDetails> createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 12, 19),
      appBar: AppBar(
        title: Text("Death Note"),
      ),
      body: ListView(
        children: [
          MangaDetailsInfoWidget(),
        ],
      ),
    );
  }
}
