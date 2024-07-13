import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anilist/anilist_api/anime_api.dart';
import 'package:anilist/models/anime_model.dart';

final animeDetailsProvider =
    FutureProvider.family<AnimeDetailsModel, int>((ref, animeID) async {
  return fetchAnimeDetails(animeID);
});
