import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:anilist/Theme/app_colors.dart';

class AnimeOverview extends StatelessWidget {
  AnimeOverview({super.key, required this.overview});

  final List<Text> overview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: AppColors.mainDarkBlue,
        child: SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: overview.length,
            itemBuilder: (context, index) {
              final overviewDetails = overview[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: overviewDetails)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
