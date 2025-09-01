import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  final List<TransactionItem> _allTransactions = [
    TransactionItem(
      title: 'Mobile Recharge',
      subtitle: 'Vodafone - 9876543210',
      amount: '-\$25.00',
      date: 'Today, 2:30 PM',
      type: TransactionType.debit,
      category: 'Recharge',
    ),
    TransactionItem(
      title: 'Salary Credited',
      subtitle: 'ABC Company Ltd',
      amount: '+\$2,500.00',
      date: 'Yesterday, 9:00 AM',
      type: TransactionType.credit,
      category: 'Income',
    ),
    TransactionItem(
      title: 'Electricity Bill',
      subtitle: 'State Electricity Board',
      amount: '-\$85.50',
      date: '2 days ago, 3:15 PM',
      type: TransactionType.debit,
      category: 'Bills',
    ),
    TransactionItem(
      title: 'Cashback Received',
      subtitle: 'Shopping Reward',
      amount: '+\$15.00',
      date: '3 days ago, 1:20 PM',
      type: TransactionType.credit,
      category: 'Cashback',
    ),
    TransactionItem(
      title: 'DTH Recharge',
      subtitle: 'Tata Sky',
      amount: '-\$45.00',
      date: '5 days ago, 7:45 PM',
      type: TransactionType.debit,
      category: 'Recharge',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 75 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 75 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: AnimatedOpacity(
          opacity: _isScrolled ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: const Text('History', style: TextStyle(color: Colors.white)),
        ),
        actionsPadding: EdgeInsets.only(right: 16),
        actions: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                '?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Header section that can collapse
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: _isScrolled ? 0 : 80,
            toolbarHeight: 0,

            flexibleSpace: FlexibleSpaceBar(
              background: AnimatedOpacity(
                opacity: _isScrolled ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
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
                            const Icon(
                              Icons.download_outlined,
                              size: 11,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'My Statements',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Pinned search bar
          SliverPersistentHeader(pinned: true, delegate: _SearchBarDelegate()),
          _buildTransactionList(_allTransactions),
        ],
      ),
    );
  }

  Widget _buildTransactionList(List<TransactionItem> transactions) {
    if (transactions.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(Icons.history, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No transactions found',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final transaction = transactions[index];
          return _buildTransactionItem(transaction);
        }, childCount: transactions.length),
      ),
    );
  }

  Widget _buildTransactionItem(TransactionItem transaction) {
    return SizedBox(
      child: Card(
        color: Colors.grey.withValues(alpha: 0.1),
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Icon(
              _getTransactionIcon(transaction.type),
              color: _getTransactionColor(transaction.type),
              size: 20,
            ),
          ),
          title: Text(
            transaction.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                transaction.subtitle,
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                transaction.date,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.amount,
                style: TextStyle(
                  color: _getTransactionColor(transaction.type),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  transaction.category,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTransactionColor(TransactionType type) {
    return type == TransactionType.credit ? Colors.green : Colors.red;
  }

  IconData _getTransactionIcon(TransactionType type) {
    return type == TransactionType.credit
        ? Icons.call_received
        : Icons.call_made;
  }
}

class TransactionItem {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final TransactionType type;
  final String category;

  TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });
}

enum TransactionType { credit, debit }

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search transactions',

            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
