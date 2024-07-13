import 'package:anilist/providers/manga_providers/manga_details_provider.dart';
import 'package:anilist/providers/manga_providers/favorite_manga_provider.dart';
import 'package:flutter/material.dart';
import 'package:anilist/widgets/manga_details/manga_details_info_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MangaDetails extends ConsumerWidget {
  MangaDetails({super.key, required this.mangaID});

  final int mangaID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaDetailsValue = ref.watch(mangaDetailsProvider(mangaID));
    final favoriteManga = ref.watch(favoriteMangaProvider);

    final isFavorite = mangaDetailsValue.when(
      data: (manga) {
        return favoriteManga.any((favorite) => favorite.id == manga.id);
      },
      error: (_, __) => false,
      loading: () => false,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 12, 19),
      appBar: AppBar(
        title: const Text(""),
        actions: [
          mangaDetailsValue.when(
            data: (manga) {
              return IconButton(
                onPressed: () {
                  ref
                      .read(favoriteMangaProvider.notifier)
                      .toggleFavoriteManga(manga);
                },
                icon: Icon(isFavorite != null && isFavorite
                    ? Icons.star
                    : Icons.star_border),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => const Icon(Icons.error),
          ),
        ],
      ),
      body: ListView(
        children: [
          mangaDetailsValue.when(
            data: (manga) => MangaDetailsInfoWidget(manga: manga),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}
