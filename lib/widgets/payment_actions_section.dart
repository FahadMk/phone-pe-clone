import 'package:flutter/material.dart';

class PaymentActionsSection extends StatelessWidget {
  const PaymentActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          /**
           * NOTE: Using IntrinsicHeight to make the two cards in the first row equal height
           * is not the right approach for production apps due to performance concerns.
           * A better approach would be to calculate the height/width based on available width.
           */
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PaymentActionCard(
                  title: 'Loans',
                  subtitle: 'Personal, Gold and More',
                ),
                const SizedBox(width: 20),
                PaymentActionCard(
                  title: 'Insurance',
                  subtitle: '',
                  showBanner: true,
                  bannerText: 'Offer',
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          IntrinsicHeight(
            child: Row(
              children: [
                // LEFT: two small cards (about 45% width)
                Expanded(
                  flex: 11, // tweak 10–12 to taste
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        // makes the two tiles share the column height equally
                        child: _ClickableCard(
                          title: 'Digital Gold',
                          subtitle: 'Buy, Sell & Gift Gold',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _ClickableCard(
                          title: 'Mutual Fund',
                          subtitle: 'Invest & Earn Returns',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                // RIGHT: big card (about 55% width)
                Expanded(
                  flex: 11, // tweak 14–16 to taste
                  child: _ClickableCard(
                    title: 'Travel & Transit',
                    subtitle: 'Flight, Train, Bus & More',
                    showBanner: true,
                    bannerText: 'Sale',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClickableCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool showBanner;
  final String? bannerText;

  const _ClickableCard({
    required this.title,
    required this.subtitle,
    this.showBanner = false,
    this.bannerText,
  });

  @override
  State<_ClickableCard> createState() => _ClickableCardState();
}

class _ClickableCardState extends State<_ClickableCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        // Add your onTap logic here
      },
      child: AnimatedScale(
        duration: Duration(milliseconds: 100),
        scale: _isPressed ? 0.95 : 1.0,
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
            color: _isPressed
                ? Colors.black
                : Colors.white.withValues(alpha: 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                if (widget.subtitle.isNotEmpty)
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                if (widget.showBanner) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.bannerText ?? 'Offer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentActionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? bannerText;
  final bool showBanner;

  const PaymentActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.bannerText,
    this.showBanner = false,
  });

  @override
  State<PaymentActionCard> createState() => _PaymentActionCardState();
}

class _PaymentActionCardState extends State<PaymentActionCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          // Add your onTap logic here
        },
        child: AnimatedScale(
          duration: Duration(milliseconds: 100),
          scale: _isPressed ? 0.95 : 1.0,
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
              color: _isPressed
                  ? Colors.black
                  : Colors.white.withValues(alpha: 0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (widget.subtitle.isNotEmpty)
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white60,
                      ),
                    ),

                  if (widget.showBanner) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.bannerText ?? 'Offer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
