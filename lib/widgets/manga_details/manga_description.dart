import "package:flutter/material.dart";
import 'package:anilist/Theme/app_colors.dart';
import 'package:flutter/widgets.dart';

class MangaDescription extends StatelessWidget {
  const MangaDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Description"),
          const SizedBox(
            height: 8,
          ),
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Container(
              color: AppColors.mainDarkBlue,
              child: SizedBox(
                height: 200,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        description),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
