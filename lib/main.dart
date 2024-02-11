import 'package:flutter/material.dart';
import 'package:flutter_assignment/custom_chat_page.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

const String appId = "BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF";
const openChannelUrl =
    "sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211";
const apiUrl = "https://api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com";
const String userId = "f93b05ff359245af400aa805bafd2a091a173064";
const accessToken = "f93b05ff359245af400aa805bafd2a091a173064";

GroupChannel? groupChannel;
OpenChannel? openChannel;
UserMessage? userMessage;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {}),
        title: const Text(
          'Gangnam Spot',
          style: TextStyle(color: Color(0XFFFCFCFC)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const CustomChatPage(),
      ),
    );
  }
}
