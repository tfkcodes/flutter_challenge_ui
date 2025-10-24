import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challenge_ui/chat_ui/colors.dart';
import 'package:flutter_challenge_ui/chat_ui/home.dart';

import 'chat_input.dart';

class ChatScreen extends StatefulWidget {
  final Chatting chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String text) {
    setState(() {
      widget.chat.messages.add(
        ChatMessages(
          content: text,
          title: "Maria Fernanda",
          usn: "MF",
          bg: primary,
          sender: false,
          time: "Now",
          reactions: [],
        ),
      );
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
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
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final chat = widget.chat.messages[index];
                      return ChattingTile(chat: chat);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ChatInput(onSend: _sendMessage),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios_new, color: light),
              ),
              const SizedBox(width: 10),
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
              Text("${widget.chat.title}", style: TextStyle(color: light)),
              const SizedBox(height: 4),
              Text("Typing...", style: TextStyle(color: four, fontSize: 10)),
            ],
          ),
          Row(
            children: [
              Icon(CupertinoIcons.search, color: light),
              const SizedBox(width: 16),
              Icon(Icons.more_vert, color: light),
            ],
          ),
        ],
      ),
    );
  }
}

class ChattingTile extends StatefulWidget {
  final ChatMessages chat;
  const ChattingTile({super.key, required this.chat});

  @override
  State<ChattingTile> createState() => _ChattingTileState();
}

class _ChattingTileState extends State<ChattingTile>
    with SingleTickerProviderStateMixin {
  final List<String> _reactions = ['👍', '❤️', '😂', '😢', '🙏'];
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _hideReactionMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    _animationController.reverse();
  }

  void _showMessageMenu(BuildContext context, Offset tapPosition) {
    _hideReactionMenu(); // Remove reaction picker first

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final messageWidth = renderBox.size.width;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Make transparent for blur effect
      isScrollControlled: true,
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: primaryDark.withOpacity(0.2)),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.1,
            maxChildSize: 0.7,
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: _buildMessageActions(context, position, messageWidth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageActions(
    BuildContext context,
    Offset position,
    double messageWidth,
  ) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 15,
                  children: _reactions
                      .map(
                        (reaction) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _handleReaction(reaction);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              reaction,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                CircleAvatar(
                  backgroundColor: light.withValues(alpha: 0.05),
                  child: Text(
                    "+",
                    style: TextStyle(color: light, fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ChattingTile(chat: widget.chat),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActionTile(
                  icon: Icons.edit,
                  title: 'Edit',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDivider(),
                _buildActionTile(
                  icon: Icons.reply,
                  title: 'Reply',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDivider(),
                _buildActionTile(
                  icon: Icons.star_border,
                  title: 'Star',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDivider(),
                _buildActionTile(
                  icon: CupertinoIcons.reply,
                  rotate: true,
                  angle: 35,
                  title: 'Forward',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildActionTile(
                  icon: Icons.content_copy,
                  title: 'Copy',
                  onTap: () {
                    Navigator.pop(context);
                    _copyToClipboard();
                  },
                ),

                _buildDivider(),
                _buildActionTile(
                  icon: Icons.delete_outline,
                  title: 'Delete',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    _deleteMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool? rotate,
    double angle = 0,
  }) {
    return ListTile(
      trailing: rotate == false
          ? Icon(icon, color: isDestructive ? Colors.red : light, size: 22)
          : Transform.rotate(
              angle: angle,
              child: Icon(
                icon,
                color: isDestructive ? Colors.red : light,
                size: 22,
              ),
            ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : light,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[800], indent: 0);
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.chat.content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Message copied to clipboard',
          style: TextStyle(color: light),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleReaction(String reaction) {
    print('Reacted with: $reaction to message: ${widget.chat.content}');
    setState(() {
      widget.chat.reactions.add(reaction);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reacted with $reaction', style: TextStyle(color: light)),
        backgroundColor: Colors.blue,
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
        width: 200,
      ),
    );
  }

  void _deleteMessage() {
    print('Delete message: ${widget.chat.content}');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Delete Message?', style: TextStyle(color: light)),
        content: Text(
          'Are you sure you want to delete this message?',
          style: TextStyle(color: light.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: light)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Message deleted',
                    style: TextStyle(color: light),
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _hideReactionMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        _showMessageMenu(context, details.globalPosition);
      },
      onLongPressEnd: (_) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (_overlayEntry != null) {
            _hideReactionMenu();
            _showMessageMenu(context, Offset.zero);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: widget.chat.sender
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: widget.chat.sender ? input : primary,
                borderRadius: BorderRadius.only(
                  topRight: widget.chat.sender
                      ? const Radius.circular(30)
                      : Radius.zero,
                  bottomRight: const Radius.circular(30),
                  bottomLeft: const Radius.circular(30),
                  topLeft: widget.chat.sender
                      ? Radius.zero
                      : const Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Text(widget.chat.content, style: TextStyle(color: light)),
            ),
            const SizedBox(height: 4),
            if (widget.chat.reactions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Wrap(
                  spacing: 4,
                  children: widget.chat.reactions
                      .map(
                        (reaction) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(reaction, style: TextStyle(fontSize: 14)),
                        ),
                      )
                      .toList(),
                ),
              ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: widget.chat.sender
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (!widget.chat.sender)
                  const Row(
                    children: [
                      Icon(Icons.check, size: 14, color: Colors.blue),
                      Icon(Icons.check, size: 14, color: Colors.blue),
                    ],
                  ),
                const SizedBox(width: 6),
                Text(
                  widget.chat.time,
                  style: TextStyle(color: gray, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
