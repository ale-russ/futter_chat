// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

// import 'main.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   ChatUser user = ChatUser(
//     id: '1',
//     firstName: 'Alem',
//     lastName: 'Russom',
//   );

//   TextEditingController? inputController = TextEditingController();

//   void setup() async {
//     try {
//       SendbirdChat.init(appId: appId);
//       SendbirdChat.connect(userId)
//           .then((value) => log('value: ${value.isActive}'));
//       openChannel = await OpenChannel.createChannel(OpenChannelCreateParams());
//       final channel = await OpenChannel.getChannel(channelUrl);
//       await channel.enter();
//       userMessage = openChannel!
//           .sendUserMessage(UserMessageCreateParams(message: "MESSAGE"));
//       log('message: ${userMessage!.message}');
//     } catch (err) {
//       log("Error: $err");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     setup();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<ChatMessage> messages = <ChatMessage>[
//       ChatMessage(
//         text: 'Hey!',
//         // text: inputController!.text,
//         user: user,
//         createdAt: DateTime.now(),
//       ),
//     ];

//     return Scaffold(
//       body: Container(
//         color: Colors.black,
//         padding: const EdgeInsets.only(bottom: 16),
//         child: DashChat(
//           currentUser: user,
//           onSend: (ChatMessage m) async {
//             log('channel: ${openChannel!.name}');

//             String messageText = m.text;
//             try {
//               if (openChannel != null) {
//                 final message = await openChannel!.sendUserMessage(
//                     UserMessageCreateParams(message: messageText));
//                 log('Message: ${message.message}');

//                 setState(() {
//                   messages.insert(
//                       0,
//                       // textColor: Color(0xfffbf665),
//                       ChatMessage(
//                         text: messageText,
//                         user: user,
//                         createdAt: DateTime.now(),
//                       ));
//                 });
//               } else {
//                 log("Error: Channel not found");
//               }
//             } catch (err) {
//               log("Error sending message: $err");
//             }
//           },
//           inputOptions: InputOptions(
//             textController: inputController,
//             inputTextStyle: const TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.w300),
//             inputToolbarStyle: const BoxDecoration(color: Color(0XFF131313)),
//             inputToolbarPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             inputDecoration: InputDecoration(
//               // fillColor: const Color(0xff323232),
//               fillColor: Colors.white,
//               hintText: 'Hello',
//               hintStyle: const TextStyle(
//                 // color: Color(0XFF666666),
//                 color: Colors.white,
//                 fontWeight: FontWeight.w400,
//               ),
//               suffixIcon: IconButton(
//                   onPressed: () {},
//                   icon: Container(
//                     height: 26,
//                     width: 26,
//                     decoration: const BoxDecoration(
//                       color: Color(0XFF3A3A3A),
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_upward,
//                       color: Color(0XFF1A1A1A),
//                     ),
//                   )),
//               enabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0XFF323232)),
//                 borderRadius: BorderRadius.all(Radius.circular(28.0)),
//               ),
//               focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Color(0XFF323232)),
//                 borderRadius: BorderRadius.all(Radius.circular(28.0)),
//               ),
//             ),
//             leading: [
//               IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: () {},
//                 color: Colors.white,
//               )
//             ],
//           ),
//           messages: messages,
//           messageOptions: const MessageOptions(
//               // containerColor: Color(0XFF006B),
//               containerColor: Color(0XFF131313),
//               currentUserContainerColor: Color(0xFFFF4593),
//               currentUserTextColor: Colors.white,
//               messagePadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
//               spaceWhenAvatarIsHidden: 6,
//               textColor: Color(0xfffbf665),
//               timePadding: EdgeInsets.only(top: 2),
//               timeTextColor: Color(0XFF9C9CA3)),
//         ),
//       ),
//     );
//   }
// }
