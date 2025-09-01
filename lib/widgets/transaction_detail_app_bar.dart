import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/history_screen.dart'; // For TransactionType enum

class TransactionDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final TransactionType transactionType;
  final String amount;
  final List<Widget>? actions;

  const TransactionDetailAppBar({
    super.key,
    required this.title,
    required this.transactionType,
    required this.amount,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _getBackgroundColor(),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      actions:
          actions ??
          [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {
                // Handle share transaction details
              },
            ),
            IconButton(
              icon: const Icon(Icons.download, color: Colors.white),
              onPressed: () {
                // Handle download receipt
              },
            ),
          ],
      // Status bar color override
      systemOverlayStyle: _getSystemOverlayStyle(),
    );
  }

  Color _getBackgroundColor() {
    switch (transactionType) {
      case TransactionType.credit:
        return Colors.green.shade700;
      case TransactionType.debit:
        return Colors.red.shade700;
      case TransactionType.mobile:
        return Colors.blue.shade700;
      case TransactionType.bank:
        return Colors.purple.shade700;
      case TransactionType.bill:
        return Colors.orange.shade700;
    }
  }

  SystemUiOverlayStyle _getSystemOverlayStyle() {
    return SystemUiOverlayStyle(
      statusBarColor: _getBackgroundColor().withValues(alpha: 0.8),
      statusBarIconBrightness: Brightness.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Gradient version for more visual appeal
class TransactionDetailGradientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final TransactionType transactionType;
  final String amount;
  final List<Widget>? actions;

  const TransactionDetailGradientAppBar({
    super.key,
    required this.title,
    required this.transactionType,
    required this.amount,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getGradientColors().first,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: _getGradientColors(),
        // ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: actions,
        systemOverlayStyle: _getSystemOverlayStyle(),
      ),
    );
  }

  List<Color> _getGradientColors() {
    switch (transactionType) {
      case TransactionType.credit:
        return [Colors.green.shade600, Colors.green.shade800];
      case TransactionType.debit:
        return [Colors.red.shade600, Colors.red.shade800];
      case TransactionType.mobile:
        return [Colors.blue.shade600, Colors.blue.shade800];
      case TransactionType.bank:
        return [Colors.purple.shade600, Colors.purple.shade800];
      case TransactionType.bill:
        return [Colors.orange.shade600, Colors.orange.shade800];
    }
  }

  SystemUiOverlayStyle _getSystemOverlayStyle() {
    final primaryColor = _getGradientColors().first;
    return SystemUiOverlayStyle(
      statusBarColor: primaryColor.withValues(alpha: 0.8),
      statusBarIconBrightness: Brightness.light,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
