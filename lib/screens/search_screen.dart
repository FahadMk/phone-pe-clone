import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _searchResults = [];
  bool _isSearchFocused = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late AnimationController _hintAnimationController;
  late Animation<double> _hintFadeAnimation;
  int _currentHintIndex = 0;

  final List<String> _suggestions = [
    'Mobile Recharge',
    'DTH Recharge',
    'Electricity Bill',
    'Gas Bill',
    'Water Bill',
    'Internet Bill',
  ];

  final List<String> _hintSuggestions = [
    'loans',
    'mobile recharge',
    'electricity bill',
    'insurance',
    'mutual funds',
    'gas bill',
    'DTH recharge',
    'gold investment',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slideAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    // Hint animation controller
    _hintAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _hintFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _hintAnimationController,
        curve: Curves.bounceInOut,
      ),
    );

    _focusNode.addListener(() {
      setState(() {
        _isSearchFocused = _focusNode.hasFocus;
      });
      if (_focusNode.hasFocus) {
        _animationController.forward();
        _hintAnimationController.stop(); // Stop hint animation when focused
      } else {
        _animationController.reverse();
        _startHintAnimation(); // Restart hint animation when unfocused
      }
    });

    // Start hint animation
    _startHintAnimation();
  }

  void _startHintAnimation() {
    if (!_isSearchFocused && _searchController.text.isEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!_isSearchFocused && _searchController.text.isEmpty && mounted) {
          _hintAnimationController.forward().then((_) {
            if (mounted) {
              setState(() {
                _currentHintIndex =
                    (_currentHintIndex + 1) % _hintSuggestions.length;
              });
              _hintAnimationController.reverse().then((_) {
                _startHintAnimation(); // Continue the cycle
              });
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _hintAnimationController.dispose();
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _suggestions
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _onChipTap(String suggestion) {
    _searchController.text = suggestion;
    _performSearch(suggestion);
  }

  void _onBackPressed() {
    _focusNode.unfocus();
    _searchController.clear();
    _performSearch('');
  }

  Widget _buildAnimatedHint() {
    return AnimatedBuilder(
      animation: _hintFadeAnimation,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Search for ',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
            Opacity(
              opacity: _hintFadeAnimation.value,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  children: [
                    const TextSpan(text: "'"),
                    TextSpan(
                      text: _hintSuggestions[_currentHintIndex],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: "'"),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(
        title: 'Search',
        type: AppBarType.conditional,
        condition: !_isSearchFocused,
        showTitle: false,
        actions: [
          AppBarAction.help(),
        ],
      ),
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              // AppBar area
              AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: SizedBox(
                      child: _isSearchFocused
                          ? null
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  'Search',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),

              // Search Bar - animated to top when focused
              AnimatedBuilder(
                animation: _slideAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Container(
                      margin: EdgeInsets.all(_isSearchFocused ? 8 : 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        onChanged: _performSearch,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText:
                              _isSearchFocused ||
                                  _searchController.text.isNotEmpty
                              ? 'Search for services...'
                              : null,
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: GestureDetector(
                            onTap: _isSearchFocused ? _onBackPressed : null,
                            child: Icon(
                              _isSearchFocused
                                  ? Icons.arrow_back
                                  : Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          label:
                              _isSearchFocused ||
                                  _searchController.text.isNotEmpty
                              ? null
                              : _buildAnimatedHint(),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Search Results
              Expanded(
                child: _searchResults.isEmpty && _searchController.text.isEmpty
                    ? _buildSuggestions()
                    : _buildSearchResults(),
              ),
            ],
          ),

          // Back button overlay when focused
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'SEARCH FOR',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _suggestions.map((suggestion) {
                return GestureDetector(
                  onTap: () => _onChipTap(suggestion),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      suggestion,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.search, color: Colors.white70),
          title: Text(
            _searchResults[index],
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            // Handle selection
          },
        );
      },
    );
  }
}
