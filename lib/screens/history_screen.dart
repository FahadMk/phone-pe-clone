import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/common_app_bar.dart';
import 'transaction_detail_screen.dart';
import '../utils/custom_page_route.dart';

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
      amount: '₹25.00',
      date: '20 Jan 2025',
      type: TransactionType.mobile,
      category: 'Recharge',
    ),
    TransactionItem(
      title: 'Salary Credited',
      subtitle: 'ABC Company Ltd',
      amount: '₹2,500.00',
      date: '18 Jan 2025',
      type: TransactionType.credit,
      category: 'Income',
    ),
    TransactionItem(
      title: 'Electricity Bill',
      subtitle: 'State Electricity Board',
      amount: '₹85.50',
      date: '31 Dec 2024',
      type: TransactionType.debit,
      category: 'Bills',
    ),
    TransactionItem(
      title: 'Cashback Received',
      subtitle: 'Shopping Reward',
      amount: '₹15.00',
      date: '25 Dec 2024',
      type: TransactionType.credit,
      category: 'Cashback',
    ),
    TransactionItem(
      title: 'DTH Recharge',
      subtitle: 'Tata Sky',
      amount: '₹45.00',
      date: '01 Jan 2024',
      type: TransactionType.debit,
      category: 'Recharge',
    ),
    TransactionItem(
      title: 'Payment to',
      subtitle: 'Google',
      amount: '₹2.00',
      date: '25 Dec 2024',
      type: TransactionType.credit,
      category: 'Payment',
    ),
    TransactionItem(
      title: 'Received from',
      subtitle: 'Google Pay',
      amount: '₹45.00',
      date: '01 Jan 2024',
      type: TransactionType.bank,
      category: 'bank',
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
      appBar: CommonAppBar(
        title: 'History',
        titleOpacity: _isScrolled ? 1.0 : 0.0,
        actions: [AppBarAction.help()],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Header section that can collapse
          CommonSliverAppBar(
            title: 'History',
            expandedHeight: _isScrolled ? 0 : 80,
            titleOpacity: _isScrolled ? 0.0 : 1.0,
            actions: [
              AppBarAction.iconText(
                text: 'My Statements',
                icon: Icons.download_outlined,
                onPressed: () {
                  // Handle download statements
                },
              ),
            ],
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          IOSStylePageRoute(
            builder: (context) => TransactionDetailScreen(transaction: transaction),
          ),
        );
      },
      child: SizedBox(
        child: Card(
          color: Colors.grey.withValues(alpha: 0.1),
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //icon section
                transaction.type == TransactionType.credit ||
                        transaction.type == TransactionType.debit
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                        child: Icon(
                          _getTransactionIcon(transaction.type),
                          color: _getTransactionColor(transaction.type),
                          size: 25,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Icon(
                          _getTransactionIcon(transaction.type),
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                //details and amount section combined
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            //details section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.title,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    transaction.subtitle,
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 16,
                                    ),
                                  ),
                                  //not the right way to do it but for now its fine
                                  SizedBox(height: 12),
                                  Text(
                                    transaction.date,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Amount and Account
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                //in phonepe here AutoPay text is there
                                Text(
                                  '',
                                  style: TextStyle(
                                    color: _getTransactionColor(
                                      transaction.type,
                                    ),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  transaction.amount,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Debited from',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/SBI-logo.svg',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        height: 1,
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTransactionColor(TransactionType type) {
    return type == TransactionType.credit ? Colors.green : Colors.red;
  }

  IconData _getTransactionIcon(TransactionType type) {
    switch (type) {
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

enum TransactionType { credit, debit, mobile, bank, bill }

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
