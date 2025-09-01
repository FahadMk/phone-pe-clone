import 'package:flutter/material.dart';

enum BottomAppBarItems { home, search, barcode, alerts, history }

class BottomNavBar extends StatefulWidget {
  final BottomAppBarItems selectedItem;
  final Function(BottomAppBarItems) onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(color: Colors.white12, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              item: BottomAppBarItems.home,
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            _buildNavItem(
              item: BottomAppBarItems.search,
              icon: Icons.search_outlined,
              selectedIcon: Icons.search,
              label: 'Search',
            ),
            _buildBarcodeItem(),
            _buildNavItem(
              item: BottomAppBarItems.alerts,
              icon: Icons.notifications_outlined,
              selectedIcon: Icons.notifications,
              label: 'Alerts',
            ),
            _buildNavItem(
              item: BottomAppBarItems.history,
              icon: Icons.history_outlined,
              selectedIcon: Icons.history,
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BottomAppBarItems item,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
  }) {
    final bool isSelected = widget.selectedItem == item;

    return GestureDetector(
      onTap: () => widget.onItemSelected(item),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Icon(
                isSelected ? selectedIcon : icon,
                key: ValueKey(
                  isSelected
                      ? '${item.name}_selected'
                      : '${item.name}_unselected',
                ),
                color: isSelected ? Colors.white : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeItem() {
    final bool isSelected = widget.selectedItem == BottomAppBarItems.barcode;

    return GestureDetector(
      onTap: () => widget.onItemSelected(BottomAppBarItems.barcode),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF8522ee),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF8522ee), width: 2),
              ),
              child: Center(
                child: Icon(
                  Icons.qr_code_scanner,
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
