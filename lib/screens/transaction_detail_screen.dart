import 'package:flutter/material.dart';
import '../widgets/transaction_detail_app_bar.dart';
import '../screens/history_screen.dart'; // For TransactionItem and TransactionType

class TransactionDetailScreen extends StatelessWidget {
  final TransactionItem transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: TransactionDetailGradientAppBar(
        title: transaction.title,
        transactionType: transaction.type,
        amount: transaction.amount,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Status Card
              _buildStatusCard(),
              const SizedBox(height: 20),

              // Transaction Details Card
              _buildDetailsCard(),
              const SizedBox(height: 20),

              // Payment Method Card
              _buildPaymentMethodCard(),
              const SizedBox(height: 20),

              // Actions
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getTransactionColor().withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getTransactionColor().withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTransactionIcon(),
              color: _getTransactionColor(),
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _getStatusText(),
            style: TextStyle(
              color: _getTransactionColor(),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            transaction.amount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            transaction.date,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Transaction Details',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildDetailRow(
            'Transaction ID',
            'TXN${DateTime.now().millisecondsSinceEpoch}',
          ),
          _buildDetailRow('Type', transaction.title),
          _buildDetailRow('Description', transaction.subtitle),
          _buildDetailRow('Category', transaction.category),
          _buildDetailRow('Status', _getStatusText()),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: const Icon(Icons.account_balance, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SBI Bank Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '****1234',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle repeat transaction
            },
            icon: const Icon(Icons.repeat),
            label: const Text('Repeat Transaction'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Handle get help
            },
            icon: const Icon(Icons.help_outline),
            label: const Text('Get Help'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getTransactionColor() {
    switch (transaction.type) {
      case TransactionType.credit:
        return Colors.green;
      case TransactionType.debit:
        return Colors.red;
      case TransactionType.mobile:
        return Colors.blue;
      case TransactionType.bank:
        return Colors.purple;
      case TransactionType.bill:
        return Colors.orange;
    }
  }

  IconData _getTransactionIcon() {
    switch (transaction.type) {
      case TransactionType.credit:
        return Icons.call_received;
      case TransactionType.debit:
        return Icons.call_made;
      case TransactionType.mobile:
        return Icons.phone_android;
      case TransactionType.bank:
        return Icons.account_balance;
      case TransactionType.bill:
        return Icons.receipt;
    }
  }

  String _getStatusText() {
    switch (transaction.type) {
      case TransactionType.credit:
        return 'Money Received';
      case TransactionType.debit:
        return 'Payment Successful';
      case TransactionType.mobile:
        return 'Recharge Successful';
      case TransactionType.bank:
        return 'Transfer Successful';
      case TransactionType.bill:
        return 'Bill Paid';
    }
  }
}
