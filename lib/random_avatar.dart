import 'dart:math';
import 'package:flutter/material.dart';

class RandomAvatar extends StatelessWidget {
  // final String initials;
  final String profileUrl;

  const RandomAvatar({
    Key? key,
    // required this.initials,
    required this.profileUrl,
  }) : super(key: key);

  Color _randomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double avatarSize = size.width * 0.1;

    return Container(
      width: avatarSize,
      height: avatarSize,
      
      decoration: BoxDecoration(
        border: Border.all(
          color: _randomColor(),
          width: 1,
        ), // Random border color
        shape: BoxShape.circle,
      ),
      child: Center(
        child: profileUrl.isEmpty
            ? Text(
                '👻',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: avatarSize * 0.5,
                ),
              )
            : ClipOval(
                child: Image.network(
                  profileUrl,
                  fit: BoxFit.cover,
                  height: avatarSize,
                  width: avatarSize,
                ),
              ),
      ),
    );
  }
}
