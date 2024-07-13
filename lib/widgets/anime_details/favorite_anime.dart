import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anilist/models/anime_model.dart';
import 'package:anilist/providers/anime_providers/favorite_anime_provider.dart';
import 'package:anilist/Theme/app_colors.dart';

class FavoriteAnimeWidget extends ConsumerWidget {
  const FavoriteAnimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAnime = ref.watch(favoriteAnimeProvider);

    if (favoriteAnime.isEmpty) {
      return const Center(
        child: Text(
          'Нет избранных аниме',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: favoriteAnime.length,
      itemBuilder: (BuildContext context, int index) {
        final anime = favoriteAnime[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.mainDarkBlue,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                "/main_screen/anime_details",
                arguments: anime.id,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        anime.coverImage,
                        width: 160,
                        height: 260,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 6),
                    child: Text(
                      anime.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
