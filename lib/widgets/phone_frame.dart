import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// On wide viewports (Chrome desktop), renders the child inside a centered
/// 390x844 phone-shaped frame so the iOS prototype looks faithful.
/// On narrow viewports (mobile, small browser windows) returns the child
/// unchanged.
class PhoneFrame extends StatelessWidget {
  static const deviceWidth = 390.0;
  static const deviceHeight = 844.0;

  final Widget child;
  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shouldFrame = kIsWeb && size.width >= 500;
    if (!shouldFrame) return child;

    return Container(
      color: const Color(0xFFF0EEE9),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(44),
        child: SizedBox(
          width: deviceWidth,
          height: deviceHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 60,
                  offset: Offset(0, 20),
                ),
              ],
              borderRadius: BorderRadius.circular(44),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
