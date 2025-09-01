import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<AlertItem> _alerts = [
    AlertItem(
      title: 'Payment Successful',
      message: 'Your mobile recharge of \$25 was successful',
      time: '2 hours ago',
      type: AlertType.success,
      isRead: false,
    ),
    AlertItem(
      title: 'Bill Reminder',
      message: 'Your electricity bill is due in 2 days',
      time: '1 day ago',
      type: AlertType.warning,
      isRead: false,
    ),
    AlertItem(
      title: 'Security Alert',
      message: 'New login detected from a different device',
      time: '2 days ago',
      type: AlertType.error,
      isRead: true,
    ),
    AlertItem(
      title: 'Cashback Earned',
      message: 'You earned \$5 cashback on your last transaction',
      time: '3 days ago',
      type: AlertType.info,
      isRead: true,
    ),
    AlertItem(
      title: 'Account Update',
      message: 'Your KYC verification is complete',
      time: '1 week ago',
      type: AlertType.success,
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Alerts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var alert in _alerts) {
                  alert.isRead = true;
                }
              });
            },
            child: const Text(
              'Mark All Read',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          final alert = _alerts[index];
          return _buildAlertItem(alert, index);
        },
      ),
    );
  }

  Widget _buildAlertItem(AlertItem alert, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        color: alert.isRead ? Colors.grey.shade900 : Colors.grey.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: alert.isRead ? Colors.transparent : Colors.purple.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getAlertColor(alert.type).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getAlertIcon(alert.type),
              color: _getAlertColor(alert.type),
              size: 20,
            ),
          ),
          title: Text(
            alert.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                alert.message,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                alert.time,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: !alert.isRead
              ? Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
          onTap: () {
            setState(() {
              alert.isRead = true;
            });
          },
        ),
      ),
    );
  }

  Color _getAlertColor(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.error:
        return Colors.red;
      case AlertType.info:
        return Colors.blue;
    }
  }

  IconData _getAlertIcon(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.error:
        return Icons.error;
      case AlertType.info:
        return Icons.info;
    }
  }
}

class AlertItem {
  final String title;
  final String message;
  final String time;
  final AlertType type;
  bool isRead;

  AlertItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
  });
}

enum AlertType { success, warning, error, info }