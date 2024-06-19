import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool shimmer;

  // constructor
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.shimmer,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> pastelSunsetColors = [
      const Color(0xff264653),
      const Color(0xff2A9D8F),
      const Color(0xffE9C46A),
      const Color(0xffF4A261),
      const Color(0xffE76F51),
      const Color(0xffF4A261),
      const Color(0xffE9C46A),
      const Color(0xff2A9D8F),
    ];

    final Gradient pastelSunsetGradient = LinearGradient(
      colors: pastelSunsetColors,
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    );

    const Gradient white = LinearGradient(
      colors: [Colors.white, Colors.grey],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    );

    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Shimmer(
        gradient: shimmer == false ? white : pastelSunsetGradient,
        direction: ShimmerDirection.rtl,
        period: const Duration(seconds: 3),
        loop: 0,
        enabled: shimmer,
        child: TextField(
          controller: controller,
          keyboardAppearance: Brightness.dark,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                // fontFamily: GoogleFonts.inter().fontFamily,
                color: Colors.grey.shade300,
              )),
          obscureText: obscureText,
          textInputAction: TextInputAction.next,
          autocorrect: false,
        ),
      ),
    );
  }
}
