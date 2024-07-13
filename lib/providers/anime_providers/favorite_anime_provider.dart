import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anilist/models/anime_model.dart';

class FavoriteAnimeNofifier extends StateNotifier<List<AnimeDetailsModel>> {
  FavoriteAnimeNofifier() : super([]);

  bool toggleFavoriteAnimeStatus(AnimeDetailsModel anime) {
    final isFavorite = state.contains(anime);

    if (isFavorite) {
      state = state.where((ani) => anime.id != ani.id).toList();
      return false;
    } else {
      state = [...state, anime];
      return true;
    }
  }
}

final favoriteAnimeProvider =
    StateNotifierProvider<FavoriteAnimeNofifier, List<AnimeDetailsModel>>(
        (ref) {
  return FavoriteAnimeNofifier();
});
