import 'package:flutter/material.dart';
import 'package:anilist/Theme/app_colors.dart';
import 'package:anilist/models/manga_model.dart';

class MangaCharacters extends StatelessWidget {
  const MangaCharacters({super.key, required this.characters});

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Characters"),
          const SizedBox(height: 8),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                final character = characters[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  color: AppColors.mainDarkBlue,
                  height: 82.3,
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      SizedBox(
                          height: 82.3, child: Image.network(character.image)),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(character.name),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
