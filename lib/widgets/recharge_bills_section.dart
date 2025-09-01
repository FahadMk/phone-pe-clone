import 'package:flutter/material.dart';

class RechargeBillsSection extends StatelessWidget {
  const RechargeBillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withValues(alpha: 0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Recharge & Bills',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const Spacer(),
                  Text('View All', style: TextStyle(color: Colors.purple)),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BillActionItem(
                  icon: Icons.phone,
                  text: 'Mobile Recharge',
                  color: Colors.purple.shade200,
                ),
                BillActionItem(
                  icon: Icons.tv,
                  text: 'DTH Recharge',
                  color: Colors.red.shade200,
                ),
                BillActionItem(
                  icon: Icons.wifi,
                  text: 'Broadband Recharge',
                  color: Colors.yellow.shade200,
                ),
                BillActionItem(
                  icon: Icons.tv,
                  text: 'Cable Recharge',
                  color: Colors.pink.shade200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BillActionItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const BillActionItem({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1,
                ),
                color: Colors.black,
              ),
              child: Center(child: Icon(icon, color: color)),
            ),
            const SizedBox(height: 6),
            Text(
              text,
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
