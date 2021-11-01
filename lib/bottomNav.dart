import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/views/account_view.dart';
import 'package:news_app/views/favorite_view.dart';
import 'package:news_app/views/home_view.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _bottomNavView = [
    HomeView(),
    FavoriteView(),
    AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _bottomNavView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: _navBarList.map(
              (e) => BottomNavigationBarItem(
                icon:  e.icon,                
                activeIcon: e.activeIcon,
                label: e.title,
              ),
            ).toList(),
      ),
    );
  }
}

class NavBarItem {
  final Icon icon;
  final Icon activeIcon;
  final String title;
  NavBarItem({required this.icon, required this.activeIcon, required this.title});
}

List<NavBarItem> _navBarList = [
  NavBarItem(
    icon: Icon(Icons.home,color: Colors.black,size: 24,),
    activeIcon: Icon(Icons.home,color: Colors.blue,size: 24),
    title: "Home",
  ),
  NavBarItem(
    icon: Icon(Icons.favorite,color: Colors.black,size: 24),
    activeIcon: Icon(Icons.favorite,color: Colors.red,size: 24),
    title: "Favorite",
  ),
  NavBarItem(
    icon: Icon(Icons.settings,color: Colors.black,size: 24),
    activeIcon: Icon(Icons.settings,color: Colors.deepPurple,size: 24),
    title: "Account",
  ),
];
