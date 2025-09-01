import 'package:flutter/material.dart';

enum AppBarType { regular, sliver, conditional }

enum ActionType { help, text, custom, iconText }

class AppBarAction {
  final ActionType type;
  final String? text;
  final VoidCallback? onPressed;
  final Widget? customWidget;
  final Color? textColor;
  final IconData? icon;

  AppBarAction.help({this.onPressed})
      : type = ActionType.help,
        text = null,
        customWidget = null,
        textColor = null,
        icon = null;

  AppBarAction.text({
    required this.text,
    this.onPressed,
    this.textColor = Colors.purple,
  })  : type = ActionType.text,
        customWidget = null,
        icon = null;

  AppBarAction.iconText({
    required this.text,
    required this.icon,
    this.onPressed,
    this.textColor = Colors.white,
  })  : type = ActionType.iconText,
        customWidget = null;

  AppBarAction.custom({required this.customWidget})
      : type = ActionType.custom,
        text = null,
        onPressed = null,
        textColor = null,
        icon = null;
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<AppBarAction>? actions;
  final bool showTitle;
  final double? titleOpacity;
  final AppBarType type;
  final bool? condition; // For conditional AppBar
  
  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showTitle = true,
    this.titleOpacity = 1.0,
    this.type = AppBarType.regular,
    this.condition,
  });

  @override
  Widget build(BuildContext context) {
    // Handle conditional AppBar (like SearchScreen)
    if (type == AppBarType.conditional && condition == false) {
      return const SizedBox.shrink();
    }

    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: showTitle
          ? AnimatedOpacity(
              opacity: titleOpacity ?? 1.0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            )
          : null,
      actionsPadding: const EdgeInsets.only(right: 16),
      actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    if (actions == null) return [];
    
    return actions!.map((action) {
      switch (action.type) {
        case ActionType.help:
          return Container(
            height: 25,
            width: 25,
            margin: const EdgeInsets.only(right: 0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.black,
            ),
            child: InkWell(
              onTap: action.onPressed,
              borderRadius: BorderRadius.circular(12.5),
              child: const Center(
                child: Text(
                  '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        
        case ActionType.text:
          return TextButton(
            onPressed: action.onPressed,
            child: Text(
              action.text ?? '',
              style: TextStyle(color: action.textColor),
            ),
          );
        
        case ActionType.iconText:
          return GestureDetector(
            onTap: action.onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    action.icon,
                    size: 11,
                    color: action.textColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    action.text ?? '',
                    style: TextStyle(
                      color: action.textColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        
        case ActionType.custom:
          return action.customWidget ?? const SizedBox.shrink();
      }
    }).toList();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CommonSliverAppBar extends StatelessWidget {
  final String title;
  final double expandedHeight;
  final double toolbarHeight;
  final Widget? flexibleSpace;
  final List<AppBarAction>? actions;
  final bool showTitle;
  final double? titleOpacity;
  final String? backgroundImagePath;
  final BoxFit? imageFit;

  const CommonSliverAppBar({
    super.key,
    required this.title,
    this.expandedHeight = 80,
    this.toolbarHeight = 0,
    this.flexibleSpace,
    this.actions,
    this.showTitle = false,
    this.titleOpacity = 0.0,
    this.backgroundImagePath,
    this.imageFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: expandedHeight,
      toolbarHeight: toolbarHeight,
      flexibleSpace: flexibleSpace ??
          FlexibleSpaceBar(
            background: backgroundImagePath != null
                ? Image.asset(
                    backgroundImagePath!,
                    fit: imageFit,
                  )
                : AnimatedOpacity(
                    opacity: titleOpacity ?? 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (actions != null) ..._buildSliverActions(),
                        ],
                      ),
                    ),
                  ),
          ),
    );
  }

  List<Widget> _buildSliverActions() {
    if (actions == null) return [];
    
    return actions!.map((action) {
      switch (action.type) {
        case ActionType.help:
          return Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.black,
            ),
            child: InkWell(
              onTap: action.onPressed,
              borderRadius: BorderRadius.circular(15),
              child: const Center(
                child: Icon(
                  Icons.question_mark_sharp,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          );
        
        case ActionType.text:
          return TextButton(
            onPressed: action.onPressed,
            child: Text(
              action.text ?? '',
              style: TextStyle(color: action.textColor),
            ),
          );
        
        case ActionType.iconText:
          return GestureDetector(
            onTap: action.onPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    action.icon,
                    size: 11,
                    color: action.textColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    action.text ?? '',
                    style: TextStyle(
                      color: action.textColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        
        case ActionType.custom:
          return action.customWidget ?? const SizedBox.shrink();
      }
    }).toList();
  }
}