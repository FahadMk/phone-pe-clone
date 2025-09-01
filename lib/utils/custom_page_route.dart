import 'package:flutter/material.dart';

class IOSStylePageRoute<T> extends MaterialPageRoute<T> {
  IOSStylePageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const curve = Curves.easeInOut;

    // Current screen (child) slides in from right
    final slideInAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: animation, curve: curve));

    return Stack(
      children: [
        // Parent screen slides out and fades (handled by secondaryAnimation)
        if (secondaryAnimation.status != AnimationStatus.dismissed)
          SlideTransition(
            position:
                Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-0.3, 0.0),
                ).animate(
                  CurvedAnimation(parent: secondaryAnimation, curve: curve),
                ),
            child: FadeTransition(
              opacity: Tween<double>(begin: 1.0, end: 0.8).animate(
                CurvedAnimation(parent: secondaryAnimation, curve: curve),
              ),
              child:
                  const SizedBox(), // This will be replaced by the actual parent
            ),
          ),

        // Current screen slides in from right with shadow
        SlideTransition(
          position: slideInAnimation,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(-5, 0),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
