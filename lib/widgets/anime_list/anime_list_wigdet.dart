import 'package:flutter/material.dart';
import 'package:anilist/Theme/app_colors.dart';
import 'package:anilist/anilist_api/anime_api.dart';
import 'package:anilist/models/anime_model.dart';

class AnimeListWidget extends StatefulWidget {
  AnimeListWidget({Key? key}) : super(key: key);

  @override
  State<AnimeListWidget> createState() => _AnimeListWidgetState();
}

class _AnimeListWidgetState extends State<AnimeListWidget> {
  final List<Anime> _animeList = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String _searchQuery = '';
  var searchController = TextEditingController();

  void _onAnimeTap(BuildContext context, int id) {
    Navigator.of(context)
        .pushNamed("/main_screen/anime_details", arguments: id);
  }

  @override
  void initState() {
    super.initState();
    _loadMoreAnime();
  }

  Future<void> _loadMoreAnime() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newAnime =
          await fetchAnimeList(page: _currentPage, searchQuery: _searchQuery);
      setState(() {
        _animeList.addAll(newAnime);
        _currentPage++;
        if (newAnime.length < 20) {
          _hasMore = false;
        }
      });
    } catch (e) {
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchAnime() async {
    setState(() {
      _animeList.clear();
      _currentPage = 1;
      _hasMore = true;
    });
    await _loadMoreAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!_isLoading &&
                _hasMore &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _loadMoreAnime();
            }
            return true;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: _animeList.length + (_hasMore ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == _animeList.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final anime = _animeList[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.mainDarkBlue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: InkWell(
                  onTap: () => _onAnimeTap(context, anime.id),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              filled: true,
              hintText: "Search...",
              fillColor: AppColors.inputColor.withAlpha(230),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(
                    () {
                      _searchQuery = searchController.text;
                    },
                  );
                  _searchAnime();
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
