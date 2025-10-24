import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_ui/chat_ui/colors.dart';
import 'package:flutter_challenge_ui/chat_ui/home.dart';

class ChatScreen extends StatefulWidget {
  final Chatting chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new, color: light),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: light,
                        child: Center(child: Text(widget.chat.usn)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${widget.chat.title}",
                            style: TextStyle(color: light),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Typing...",
                        style: TextStyle(color: four, fontSize: 10),
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.search, color: light),
                      SizedBox(width: 20),
                      Icon(Icons.more_vert, color: light),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/darkBg.jpeg"),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [primaryDark, primaryDark],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: ListView.builder(
                      itemCount: widget.chat.messages.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ChatMessages chat = widget.chat.messages[index];
                        return reactionMessage(
                          ChattingTile(chat: chat),
                          chat: chat,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: primaryDark,
          border: Border(top: BorderSide(width: 0.1, color: gray)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: MediaQuery.of(context).viewInsets,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Transform.rotate(
                      angle: 45,
                      child: Icon(Icons.attach_file_outlined, size: 30),
                    ),
                    fillColor: input.withOpacity(0.1),
                    filled: true,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: primary,
              child: Icon(CupertinoIcons.mic, color: light),
            ),
          ],
        ),
      ),
    );
  }

  Widget reactionMessage(Widget child, {required ChatMessages chat}) {
    return CupertinoContextMenu(
      actions: [
        Container(
          constraints: BoxConstraints(maxHeight: 80),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2133),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('💙', style: TextStyle(fontSize: 24)),
              Text('🤩', style: TextStyle(fontSize: 24)),
              Text('👍', style: TextStyle(fontSize: 24)),
              Text('🙌', style: TextStyle(fontSize: 24)),
              Text('🙏', style: TextStyle(fontSize: 24)),
              Icon(CupertinoIcons.add_circled, color: Colors.white54),
            ],
          ),
        ),
        const Divider(color: Colors.white24, height: 1),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          trailingIcon: CupertinoIcons.pencil,
          child: const Text("Edit"),
        ),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          trailingIcon: CupertinoIcons.reply,
          child: const Text("Reply"),
        ),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          trailingIcon: CupertinoIcons.star,
          child: const Text("Star"),
        ),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          trailingIcon: CupertinoIcons.arrowshape_turn_up_right,
          child: const Text("Forward"),
        ),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          trailingIcon: CupertinoIcons.doc_on_doc,
          child: const Text("Copy"),
        ),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          trailingIcon: CupertinoIcons.delete,
          child: const Text("Delete"),
        ),
      ],
      child: child,
    );
  }
}

class ChattingTile extends StatefulWidget {
  final ChatMessages chat;
  const ChattingTile({super.key, required this.chat});

  @override
  State<ChattingTile> createState() => _ChattingTileState();
}

class _ChattingTileState extends State<ChattingTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            color: !widget.chat.sender ? primary : input,
            borderRadius: BorderRadius.only(
              topRight: !widget.chat.sender
                  ? Radius.circular(0)
                  : Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topLeft: !widget.chat.sender
                  ? Radius.circular(30)
                  : Radius.circular(0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(widget.chat.content, style: TextStyle(color: light)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: !widget.chat.sender
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.check, color: primary, size: 16),
                    Icon(Icons.check, color: primary, size: 16),
                    Text(
                      widget.chat.time,
                      style: TextStyle(color: gray, fontSize: 10),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      widget.chat.time,
                      style: TextStyle(color: gray, fontSize: 10),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
