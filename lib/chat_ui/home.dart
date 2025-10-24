import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challenge_ui/chat_ui/chat_screen.dart';
import 'package:flutter_challenge_ui/chat_ui/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<Chatting> chats = [
  Chatting(
    title: "Maria Fernanda",
    content:
        "Ok let me check this out for a moment, thank you for your patience",
    time: "11:32 AM",
    count: "3",
    usn: 'MF',
    bg: one,
    countBg: primary,
    read: false,
    messages: [
      ChatMessages(
        title: "Maria Fernanda",
        content:
            "Hi there! i would be happy to help you with that. Could you please provide me with your order number so I can look into it for you",
        time: "11:32 AM",
        count: "3",
        usn: 'MF',
        bg: one,
        countBg: primary,
        sender: true,
      ),
      ChatMessages(
        title: "Maria Fernanda",
        content: "Sure my order number is #23478374",
        time: "11:33 AM",
        count: "3",
        usn: 'MF',
        bg: one,
        countBg: primary,
        sender: false,
      ),
      ChatMessages(
        title: "Maria Fernanda",
        content:
            "Thank you for providing that. let me check on you order's status. It may take a moment",
        time: "11:33 AM",
        count: "3",
        usn: 'MF',
        bg: one,
        countBg: primary,
        sender: true,
      ),
    ],
  ),
  Chatting(
    title: "Mike James",
    content:
        "Trying to connect my account to a new device and could use a hand",
    time: "11:32 AM",
    count: "3",
    usn: 'MJ',
    bg: two,
    countBg: primary,
    read: false,
    messages: [
      ChatMessages(
        title: "Mike James",
        content:
            "Trying to connect my account to a new device and could use a hand",
        time: "11:32 AM",
        count: "3",
        usn: 'MJ',
        bg: two,
        countBg: primary,
        sender: false,
      ),
      ChatMessages(
        title: "Mike James",
        content:
            "Trying to connect my account to a new device and could use a hand",
        time: "11:32 AM",
        count: "3",
        usn: 'MJ',
        bg: two,
        countBg: primary,
        sender: true,
      ),
    ],
  ),
  Chatting(
    title: "David Romano",
    content:
        "Everything was working great until today - now the screen won`t loading",
    time: "11:32 AM",
    count: "3",
    usn: 'DR',
    bg: three,
    countBg: primary,
    read: false,
    messages: [
      ChatMessages(
        title: "David Romano",
        content:
            "Everything was working great until today - now the screen won`t loading",
        time: "11:32 AM",
        count: "3",
        usn: 'DR',
        bg: three,
        countBg: primary,
        sender: false,
      ),
      ChatMessages(
        title: "David Romano",
        content:
            "Everything was working great until today - now the screen won`t loading",
        time: "11:32 AM",
        count: "3",
        usn: 'DR',
        bg: three,
        countBg: primary,
        sender: true,
      ),
    ],
  ),
  Chatting(
    title: "Shay Levy",
    content:
        "Looking to update my settings but no sure where to find the right option in the app",
    time: "11:32 AM",
    usn: 'SL',
    bg: four,
    read: true,
    countBg: primaryDark,
    messages: [
      ChatMessages(
        title: "Shay Levy",
        content:
            "Looking to update my settings but no sure where to find the right option in the app",
        time: "11:32 AM",
        usn: 'SL',
        bg: four,
        sender: true,
        countBg: primaryDark,
      ),
      ChatMessages(
        title: "Shay Levy",
        content:
            "Looking to update my settings but no sure where to find the right option in the app",
        time: "11:32 AM",
        usn: 'SL',
        bg: four,
        sender: false,
        countBg: primaryDark,
      ),
    ],
  ),
  Chatting(
    title: "Greg McDonald",
    content:
        "Loving the platform so far, just need help sorting out one small technical thing",
    time: "11:32 AM",
    usn: 'GM',
    bg: five,
    read: true,
    countBg: primaryDark,
    messages: [
      ChatMessages(
        title: "Greg McDonald",
        content:
            "Loving the platform so far, just need help sorting out one small technical thing",
        time: "11:32 AM",
        usn: 'GM',
        bg: five,
        sender: true,
        countBg: primaryDark,
      ),
      ChatMessages(
        title: "Greg McDonald",
        content:
            "Loving the platform so far, just need help sorting out one small technical thing",
        time: "11:32 AM",
        usn: 'GM',
        bg: five,
        sender: false,
        countBg: primaryDark,
      ),
    ],
  ),
  Chatting(
    title: "Shay levy",
    content:
        "That`s why we created the challenge, so we can access the skills under a time",
    time: "11:32 AM",
    usn: 'SL',
    bg: six,
    read: true,
    countBg: primaryDark,
    messages: [
      ChatMessages(
        title: "Shay levy",
        content:
            "That`s why we created the challenge, so we can access the skills under a time",
        time: "11:32 AM",
        usn: 'SL',
        bg: six,
        sender: true,
        countBg: primaryDark,
      ),
      ChatMessages(
        title: "Shay levy",
        content:
            "That`s why we created the challenge, so we can access the skills under a time",
        time: "11:32 AM",
        usn: 'SL',
        bg: six,
        sender: false,
        countBg: primaryDark,
      ),
    ],
  ),
  Chatting(
    title: "Greg McDonald",
    content:
        "That`s why we created the challenge, so we can access the skills under a time",
    time: "11:32 AM",
    usn: 'GM',
    bg: seven,
    read: true,
    countBg: primaryDark,
    messages: [
      ChatMessages(
        title: "Greg McDonald",
        content:
            "That`s why we created the challenge, so we can access the skills under a time",
        time: "11:32 AM",
        usn: 'GM',
        bg: seven,
        sender: true,
        countBg: primaryDark,
      ),
      ChatMessages(
        title: "Greg McDonald",
        content:
            "That`s why we created the challenge, so we can access the skills under a time",
        time: "11:32 AM",
        usn: 'GM',
        bg: seven,
        sender: false,
        countBg: primaryDark,
      ),
    ],
  ),
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        backgroundColor: primaryDark,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: primaryDark,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        title: Row(
          children: [
            Text("Inbox", style: TextStyle(color: Colors.white)),
            Text("(3)", style: TextStyle(color: primary)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.search, color: light),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_rounded, color: light),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) {
          return Divider(thickness: 0.1, indent: 100);
        },
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen(chat: chat)),
              );
            },
            title: Text(
              chat.title,
              style: TextStyle(
                color: light,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              chat.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: chat.read ? FontWeight.normal : FontWeight.bold,
                color: chat.read ? Colors.grey : light,
              ),
            ),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: chat.bg,
                  child: Text(
                    chat.usn,
                    style: TextStyle(color: light, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 15,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: primaryDark,
                    child: CircleAvatar(radius: 5, backgroundColor: four),
                  ),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat.time),
                SizedBox(height: 10),
                chat.count != ""
                    ? CircleAvatar(
                        radius: 10,
                        backgroundColor: chat.countBg,
                        child: Text(
                          chat.count ?? "",
                          style: TextStyle(color: light, fontSize: 10),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: primary,
        child: Text(
          "+",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: light,
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}

class Chatting {
  final String title, content, time, usn;
  final Color bg;
  final String? count;
  final Color? countBg;
  final bool read;
  final List<ChatMessages> messages;

  Chatting({
    required this.title,
    required this.content,
    required this.time,
    required this.usn,
    required this.read,
    required this.messages,
    this.count,
    required this.bg,
    this.countBg,
  });
}

class ChatMessages {
  final String title, content, time, usn;
  final Color bg;
  final String? count;
  final Color? countBg;
  final bool sender;
  List<String> reactions;

  ChatMessages({
    required this.title,
    required this.content,
    required this.time,
    required this.usn,
    required this.sender,
    this.count,
    required this.bg,
    this.countBg,
    List<String>? reactions,
  }) : reactions = reactions ?? [];
}
