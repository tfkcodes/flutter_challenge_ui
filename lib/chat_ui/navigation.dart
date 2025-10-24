import 'package:flutter/material.dart';
import 'package:flutter_challenge_ui/chat_ui/colors.dart';
import 'package:flutter_challenge_ui/chat_ui/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Center(child: Text("Explore")),
    Center(child: Text("Trends")),
    Center(child: Text("Support")),
    Center(child: Text("Settings")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.1, color: gray)),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: primaryDark,
          selectedItemColor: primary,
          unselectedItemColor: gray.withOpacity(0.6),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    height: 30,
                    width: 30,
                    color: currentIndex == 0 ? primary : gray.withOpacity(0.6),
                  ),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        "21",
                        style: TextStyle(fontSize: 8, color: light),
                      ),
                    ),
                  ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/image.svg",
                height: 30,
                width: 30,
                color: currentIndex == 1 ? primary : gray.withOpacity(0.6),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/binoculars.svg",
                height: 30,
                width: 30,
                color: currentIndex == 2 ? primary : gray.withOpacity(0.6),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/support.svg",
                height: 30,
                width: 30,
                color: currentIndex == 3 ? primary : gray.withOpacity(0.6),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/setting.svg",
                height: 30,
                width: 30,
                color: currentIndex == 4 ? primary : gray.withOpacity(0.6),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
