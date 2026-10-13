import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../theme/app_theme.dart';
import 'home_screen.dart';
import '../features/student_screen.dart';
import '../features/staff_screen.dart';
import '../features/payment_screen.dart';
import '../features/complain_screen.dart';
import '../features/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  final bool isAdmin;

  const DashboardScreen({super.key, this.isAdmin = true});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    // Use provider state if authenticated, fallback to widget.isAdmin
    final effectiveIsAdmin = appProvider.currentUser != null
        ? appProvider.isAdmin
        : widget.isAdmin;
    final themeColor = appProvider.themeColor;

    final List<Widget> pages = [
      HomeScreen(onTabSelected: _onItemTapped, isAdmin: effectiveIsAdmin),
      StudentScreen(isAdmin: effectiveIsAdmin),
      StaffScreen(isAdmin: effectiveIsAdmin),
      PaymentScreen(isAdmin: effectiveIsAdmin),
      ComplainScreen(isAdmin: effectiveIsAdmin),
      SettingScreen(isAdmin: effectiveIsAdmin),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[_selectedIndex],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.line, width: 1.0),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  themeColor: themeColor,
                ),
                _buildNavItem(
                  index: 1,
                  icon: effectiveIsAdmin ? Icons.people_outline_rounded : Icons.person_outline_rounded,
                  activeIcon: effectiveIsAdmin ? Icons.people_rounded : Icons.person_rounded,
                  label: effectiveIsAdmin ? 'Students' : 'My Info',
                  themeColor: themeColor,
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.badge_outlined,
                  activeIcon: Icons.badge_rounded,
                  label: 'Staff',
                  themeColor: themeColor,
                ),
                _buildNavItem(
                  index: 3,
                  icon: Icons.payment_outlined,
                  activeIcon: Icons.payment_rounded,
                  label: 'Payments',
                  themeColor: themeColor,
                ),
                _buildNavItem(
                  index: 4,
                  icon: Icons.report_problem_outlined,
                  activeIcon: Icons.report_problem_rounded,
                  label: 'Complaints',
                  themeColor: themeColor,
                ),
                _buildNavItem(
                  index: 5,
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings_rounded,
                  label: 'Settings',
                  themeColor: themeColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required Color themeColor,
  }) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        splashColor: themeColor.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              size: 20,
              color: isSelected ? themeColor : const Color(0xFF70859A),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? themeColor : const Color(0xFF70859A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
