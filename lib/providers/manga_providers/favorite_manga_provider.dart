import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anilist/models/manga_model.dart';

class FavoriteMangaProvider extends StateNotifier<List<MangaDetailsModel>> {
  FavoriteMangaProvider() : super([]);

  bool toggleFavoriteManga(MangaDetailsModel manga) {
    final isFavorite = state.contains(manga);

    if (isFavorite) {
      state = state.where((m) => manga.id != m.id).toList();
      return false;
    } else {
      state = [...state, manga];
      return true;
    }
  }
}

final favoriteMangaProvider =
    StateNotifierProvider<FavoriteMangaProvider, List<MangaDetailsModel>>(
  (ref) => FavoriteMangaProvider(),
);
