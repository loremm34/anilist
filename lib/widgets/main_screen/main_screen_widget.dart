import "package:flutter/material.dart";
import 'package:anilist/widgets/anime_list/anime_list_wigdet.dart';
import 'package:anilist/widgets/manga_list/manga_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MainScreenWidget();
  }
}

class _MainScreenWidget extends State<MainScreenWidget> {
  int _selectedTab = 0;

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    _selectedTab = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AniList"),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          AnimeListWidget(),
          MangaListWidget(),
          Text("Профиль"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: onSelectedTab,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Аниме"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Манга"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
        ],
      ),
    );
  }
}
