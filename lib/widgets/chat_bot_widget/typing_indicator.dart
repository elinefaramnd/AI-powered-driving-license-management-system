import 'package:flutter/material.dart';
import 'chat_bot_avatars.dart';

class ChatTypingIndicator extends StatelessWidget {
  final Size size;
  final bool isTyping;
  const ChatTypingIndicator({
    super.key,
    required this.size,
    required this.isTyping,
  });
  @override
  Widget build(BuildContext context) {
    if (!isTyping) {
      return const SizedBox.shrink();
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.04,
          right: size.width * 0.04,
          bottom: size.height * 0.012,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ChatBotAvatar(size: size),
            SizedBox(width: size.width * 0.018),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.014,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.width * 0.04),
                  topRight: Radius.circular(size.width * 0.04),
                  bottomRight: Radius.circular(size.width * 0.04),
                  bottomLeft: const Radius.circular(6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const TypingDots(),
            ),
          ],
        ),
      ),
    );
  }
}

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});
  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            double opacity = ((value + delay) % 1.0);
            opacity = opacity < 0.5 ? opacity * 2 : (1 - opacity) * 2;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3 + (opacity * 0.7)),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
