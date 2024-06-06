import 'package:anilist/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:anilist/models/manga_model.dart';


class MangaListWidget extends StatefulWidget {
  MangaListWidget({Key? key}) : super(key: key);

  @override
  State<MangaListWidget> createState() => _MangaListWidgetState();
}

class _MangaListWidgetState extends State<MangaListWidget> {

  late Future<List<Manga>> _mangaList;

  @override
  void initState() {
    super.initState();
    _mangaList = fetchMangaList();  
    }

  void _onMangaTap(BuildContext context,int id) {
    Navigator.of(context).pushNamed("/main_screen/manga_details", arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: FutureBuilder<List<Manga>>(
            future: _mangaList,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if(snapshot.hasError) {
                return Container();
              } else {
                return GridView.builder(
                
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(top: 55),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final manga = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainDarkBlue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      _onMangaTap(context, manga.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              manga.coverImage
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7, bottom: 12),
                            child: Text(
                              manga.title,
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
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: AppColors.inputColor.withAlpha(235),
              hintText: "Search..",
            ),
          ),
        ),
      ],
    );
  }
}


            