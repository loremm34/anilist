import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anilist/models/manga_model.dart';
import 'package:anilist/anilist_api/manga_api.dart';

final mangaDetailsProvider = FutureProvider.family<MangaDetailsModel, int>(
  (ref, mangaID) async {
    return fetchMangaDetails(mangaID);
  },
);
