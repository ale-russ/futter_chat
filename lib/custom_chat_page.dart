import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

import 'chat_message.dart';
import 'main.dart';

class CustomChatPage extends StatefulWidget {
  const CustomChatPage({super.key});

  @override
  State<CustomChatPage> createState() => _CustomChatPageState();
}

class _CustomChatPageState extends State<CustomChatPage> {
  TextEditingController? inputController = TextEditingController();
  // final messageId = int.parse(Get.parameters['message_id']!);

  List<BaseMessage> _messages = [];
  OpenChannel? channel;
  late PreviousMessageListQuery query;
  int? participantCount;

  String title = '';
  bool hasPrevious = false;
  Color _textColor = Colors.grey;
  bool isSelected = false;

  void setup() async {
    try {
      await SendbirdChat.init(appId: appId);
      await SendbirdChat.connect(userId, accessToken: accessToken);

      openChannel = await OpenChannel.getChannel(openChannelUrl);
      openChannel!.enter();

      _initialize();
    } catch (err) {
      log("ERROR: $err");
    }
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  void _initialize() {
    OpenChannel.getChannel(openChannelUrl).then((openChannel) {
      query = PreviousMessageListQuery(
        channelType: ChannelType.open,
        channelUrl: openChannelUrl,
      )..next().then((messages) {
          setState(() {
            _messages
              ..clear()
              ..addAll(messages);
            title = '${openChannel.name} (${_messages.length})';
            hasPrevious = query.hasNext;
            participantCount = openChannel.participantCount;
          });
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: ((context, index) {
                  return ChatMessage(
                    _messages[index].message,
                    isSentByMe: _messages[index].sender!.isCurrentUser,
                    userName: _messages[index].sender?.nickname,
                    timeStamp: _messages[index].createdAt,
                    profileUrl: _messages[index].sender!.profileUrl,
                  );
                }),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height, minHeight: 80),
              // height: 80,
              color: const Color(0XFF131313),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.add,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      maxLines: null,
                      style: const TextStyle(color: Color(0xFFFCFCFC)),
                      onChanged: (text) {
                        setState(() {
                          isSelected = text.isNotEmpty;
                          _textColor =
                              text.isEmpty ? Colors.grey : Colors.black;
                        });
                      },
                      controller: inputController,
                      decoration: InputDecoration(
                        hintText: 'Hello',
                        hintStyle: const TextStyle(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              if (inputController!.value.text.isEmpty) {
                                return;
                              }

                              try {
                                final message = openChannel!.sendUserMessage(
                                    UserMessageCreateParams(
                                        message: inputController!.value.text),
                                    handler: (message, err) {
                                  if (err != null) {
                                    log('err: $err');
                                  } else {}
                                });
                                setState(() {
                                  _messages.add(message);
                                });
                              } catch (e) {
                                log('error: $e');
                              }
                            },
                            icon: Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                color: !isSelected
                                    ? const Color(0XFF3A3A3A)
                                    : const Color(0XFFFF006A),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                              ),
                              child: const Icon(
                                // Icons.arrow_upward,
                                CupertinoIcons.arrow_up,
                                color: Color(0XFF1A1A1A),
                              ),
                            )),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF323232)),
                          borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF323232)),
                          borderRadius: BorderRadius.all(Radius.circular(28.0)),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
