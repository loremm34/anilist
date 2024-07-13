import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anilist/widgets/anime_details/anime_details_info_widget.dart';
import 'package:anilist/providers/anime_providers/favorite_anime_provider.dart';
import 'package:anilist/providers/anime_providers/anime_details_provider.dart';

class AnimeDetails extends ConsumerWidget {
  const AnimeDetails({super.key, required this.animeID});

  final int animeID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeDetailsAsyncValue = ref.watch(animeDetailsProvider(animeID));
    final favoriteAnime = ref.watch(favoriteAnimeProvider);

    final isFavorite = animeDetailsAsyncValue.when(
      data: (anime) => favoriteAnime.any((favorite) => favorite.id == anime.id),
      loading: () => false,
      error: (_, __) => false,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 12, 19),
      appBar: AppBar(
        title: const Text(""),
        actions: [
          animeDetailsAsyncValue.when(
            data: (anime) {
              return IconButton(
                onPressed: () {
                  ref
                      .read(favoriteAnimeProvider.notifier)
                      .toggleFavoriteAnimeStatus(anime);
                },
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => const Icon(Icons.error),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: animeDetailsAsyncValue.when(
          data: (anime) => AnimeDetailsInfoWidget(anime: anime),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
