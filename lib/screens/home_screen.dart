import 'package:flutter/material.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/recharge_bills_section.dart';
import '../widgets/payment_actions_section.dart';
import '../widgets/slidable_container_widget.dart';
import '../widgets/sticky_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 150 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 150 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                toolbarHeight: 70,
                expandedHeight: 240,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/test_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //Quick Action Section
              const SliverToBoxAdapter(child: QuickActionsSection()),
              //Recharge bill Section
              const SliverToBoxAdapter(child: RechargeBillsSection()),
              //Payment Actions Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const PaymentActionsSection(),
                    const SizedBox(height: 30),
                    const SlidableContainerWidget(),
                  ],
                ),
              ),
              //  SliverFillRemaining(),
            ],
          ),
          // Transparent sticky app bar
          StickyAppBar(isScrolled: _isScrolled),
        ],
      ),
    );
  }
}
