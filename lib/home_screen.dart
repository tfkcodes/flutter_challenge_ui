import 'package:flutter/material.dart';
import 'package:flutter_challenge_ui/chat_ui/colors.dart';
import 'package:flutter_challenge_ui/risit_screen/risit_screen.dart';

import 'chat_ui/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UiCard> uiList = [];

  @override
  void initState() {
    super.initState();
    uiList = [
      UiCard(
        img: "assets/ui/risit.jpeg",
        title: "Risit Screen",
        route: "risit",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RisitScreen()),
          );
        },
      ),
      UiCard(
        img: "assets/ui/chat.jpeg",
        title: "Chat Screen",
        route: "chat",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Navigation()),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        title: Text("30 Flutter Challenges", style: TextStyle(color: light)),
      ),
      body: GridView.builder(
        itemCount: uiList.length,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final UiCard ui = uiList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: UICard(onTap: ui.onTap, title: ui.title, img: ui.img),
          );
        },
      ),
    );
  }
}

class UICard extends StatelessWidget {
  final String img, title;
  final VoidCallback onTap;

  const UICard({
    super.key,
    required this.onTap,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 3, color: blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 40,
              width: double.infinity,
              color: blue.withOpacity(0.9),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: light, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UiCard {
  final String img, title, route;
  final VoidCallback onTap;

  UiCard({
    required this.img,
    required this.title,
    required this.route,
    required this.onTap,
  });
}
