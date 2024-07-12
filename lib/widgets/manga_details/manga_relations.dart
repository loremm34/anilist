import 'package:flutter/material.dart';
import 'package:anilist/Theme/app_colors.dart';
import 'package:anilist/models/manga_model.dart';

class MangaRelations extends StatelessWidget {
  const MangaRelations({super.key, required this.relations});

  final List<Relation> relations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: const Text("Relations"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scrollbar(
            child: SizedBox(
              height: 115,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relations.length,
                itemBuilder: (context, index) {
                  final relation = relations[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      color: AppColors.mainDarkBlue,
                      child: Row(
                        children: [
                          Image.network(relation.image),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 60, left: 10, top: 5, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  relation.type,
                                  maxLines: 1,
                                ),
                                Text(
                                  relation.title,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
