import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class OpenChatHandler extends OpenChannelHandler {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // TODO: implement onMessageReceived
    void onMessageReceived(BaseChannel channel, BaseMessage message) {
      // Received a new message.
      log('Received messages ${message.message}');
    }
  }
}
