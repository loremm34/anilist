import 'package:anilist/widgets/anime_details/anime_details.dart';
import 'package:anilist/widgets/main_screen/main_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:anilist/widgets/auth/auth_widget.dart';
import 'package:anilist/widgets/auth/registration_widget.dart';
import 'package:anilist/Theme/app_colors.dart';
import 'package:anilist/widgets/manga_details/manga_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.mainDarkBlue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/auth': (context) => AuthWidget(),
        '/main_screen': (context) => const MainScreenWidget(),
        '/registration_widget': (context) => RegistrationWidget(),
        '/main_screen/manga_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MangaDetails(mangaID: arguments);
          } else {
            return const MangaDetails(
              mangaID: 0,
            );
          }
        },
        '/main_screen/anime_details': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return AnimeDetails(animeID: arguments);
          } else {
            return const AnimeDetails(
              animeID: 0,
            );
          }
        }
      },
      title: 'Flutter Demo',
      initialRoute: '/main_screen',
      themeMode: ThemeMode.system,
    );
  }
}
