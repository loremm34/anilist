
import 'package:flutter/material.dart';
import 'package:anilist/Theme/app_colors.dart';
import 'package:anilist/models/manga_model.dart';


class MangaStaff extends StatelessWidget {
  const MangaStaff({super.key, required this.staff});

  final List<Staff> staff;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Staff"),
          const SizedBox(height: 8),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: staff.length,
              itemBuilder: (context, index) {

                final mangaStaff = staff[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  color: AppColors.mainDarkBlue,
                  height: 82.3,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 82.3,
                        child: Image.network(mangaStaff.image)
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mangaStaff.name),
                          Text(mangaStaff.role),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
