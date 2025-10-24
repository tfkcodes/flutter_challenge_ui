import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'colors.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;
  const ChatInput({super.key, required this.onSend});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;
  bool _isRecording = false;
  int _recordDuration = 0;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });

    _ticker = Ticker((elapsed) {
      setState(() {
        _recordDuration = elapsed.inSeconds;
      });
    });
  }

  void _startRecording() {
    setState(() => _isRecording = true);
    _ticker.start();
    print("Recording started...");
  }

  void _stopRecording() {
    setState(() => _isRecording = false);
    _ticker.stop();
    print("Recording stopped. Duration: $_recordDuration sec");
    _recordDuration = 0;
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 40,
            runSpacing: 16,
            children: [
              _buildAttachmentOption(
                icon: Icons.image,
                title: "Photo",
                onTap: () {
                  Navigator.pop(context);
                  print("Pick Image from Gallery");
                },
              ),
              _buildAttachmentOption(
                icon: Icons.camera_alt,
                title: "Camera",
                onTap: () {
                  Navigator.pop(context);
                  print("Open Camera");
                },
              ),
              _buildAttachmentOption(
                icon: Icons.insert_drive_file,
                title: "Document",
                onTap: () {
                  Navigator.pop(context);
                  print("Pick Document");
                },
              ),
              _buildAttachmentOption(
                icon: CupertinoIcons.location,
                title: "Location",
                onTap: () {
                  Navigator.pop(context);
                  print("Send Location");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[800],
            child: Icon(icon, color: light, size: 28),
          ),
          const SizedBox(height: 6),
          Text(title, style: TextStyle(color: light)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showAttachmentOptions,
            child: Icon(Icons.attach_file, color: Colors.grey[400], size: 26),
          ),
          const SizedBox(width: 8),
          Icon(CupertinoIcons.smiley, color: Colors.grey[400]),
          const SizedBox(width: 8),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150),
              child: Scrollbar(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: _isRecording
                        ? "Recording... $_recordDuration s"
                        : "Type a message",
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  style: TextStyle(color: light),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onLongPressStart: (_) {
              if (!_hasText) _startRecording();
            },
            onLongPressEnd: (_) {
              if (_isRecording) _stopRecording();
            },
            onTap: () {
              if (_hasText) {
                widget.onSend(_controller.text.trim());
                _controller.clear();
              } else {
                print("Mic tapped");
              }
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: primary,
              child: Icon(
                _hasText ? Icons.send : CupertinoIcons.mic,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _ticker.dispose();
    super.dispose();
  }
}
