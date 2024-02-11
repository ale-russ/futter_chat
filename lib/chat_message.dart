import 'package:flutter/material.dart';

import 'random_avatar.dart';

class ChatMessage extends StatefulWidget {
  final String message;
  final bool isSentByMe;
  final String? userName;
  final int timeStamp;
  final String profileUrl;
  final bool isActive;

  const ChatMessage(this.message,
      {super.key,
      required this.isSentByMe,
      this.userName,
      this.isActive = false,
      required this.timeStamp,
      required this.profileUrl});

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  String formatTimestamp(int timestampMillis) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: widget.isSentByMe ? Alignment.topRight : Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: widget.isSentByMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            widget.isSentByMe
                ? Text(
                    formatTimestamp(widget.timeStamp),
                    style: const TextStyle(color: Colors.grey),
                  )
                : const SizedBox.shrink(),
            !widget.isSentByMe
                ? Container(
                    height: 70,
                    padding: const EdgeInsets.only(left: 8),
                    alignment: Alignment.topLeft,
                    child: RandomAvatar(
                        initials: 'AB', profileUrl: widget.profileUrl))
                : const SizedBox.shrink(),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
                minWidth: 80,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              decoration: BoxDecoration(
                gradient: !widget.isSentByMe
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0XFF1A1A1A),
                          Color(0XFF1A1A1A) // End color (bottom right)
                        ],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0XFFFF006B),
                          Color(0XFFFF4593), // End color (bottom right)
                        ],
                      ),
                color: widget.isSentByMe
                    ? const Color(0xFFFF4593)
                    : const Color(0XFF1A1A1A),
                borderRadius: widget.isSentByMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !widget.isSentByMe
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.userName ?? '',
                                style: const TextStyle(
                                    fontSize: 16.0, color: Color(0XFFADADAD))),
                                    const SizedBox(width: 8),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.isActive
                                      ? const Color(0XFF46F9F5)
                                      : const Color(0XFF101010)),
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  Text(
                    widget.message,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            !widget.isSentByMe
                ? Text(
                    formatTimestamp(widget.timeStamp),
                    style: const TextStyle(color: Colors.grey),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
