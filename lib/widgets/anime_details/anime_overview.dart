import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:anilist/Theme/app_colors.dart';

class AnimeOverview extends StatelessWidget {
  AnimeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scrollbar(
        child: SizedBox(
          height: 95,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                color: AppColors.mainDarkBlue,
                margin: const EdgeInsets.only(top: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Average Score: 80%',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            'Mean Score: 81%',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

