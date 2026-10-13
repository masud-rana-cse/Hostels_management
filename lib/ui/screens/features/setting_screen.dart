import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';

class SettingScreen extends StatefulWidget {
  final bool isAdmin;

  const SettingScreen({super.key, this.isAdmin = true});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void _showEditProfileSheet(BuildContext context, Color themeColor) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final user = appProvider.currentUser;

    final nameCtrl = TextEditingController(text: user?.name ?? 'User Name');
    final idCtrl = TextEditingController(text: user?.studentId ?? 'ID-001');
    final phoneCtrl = TextEditingController(text: user?.phone ?? '01700000000');
    final deptCtrl = TextEditingController(text: user?.department ?? 'CSE');
    final roomCtrl = TextEditingController(text: user?.room ?? '204B');
    final addressCtrl = TextEditingController(text: user?.address ?? 'Sector 9, Uttara, Dhaka');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isAdmin ? 'Edit Admin Profile' : 'Edit My Profile Details',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navy,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20, color: AppColors.muted),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Update your profile contact & room information below',
                  style: TextStyle(fontSize: 11, color: AppColors.muted),
                ),
                const SizedBox(height: 18),

                _buildSheetInput(controller: nameCtrl, label: 'Full Name', hint: 'Enter name'),
                _buildSheetInput(
                  controller: idCtrl,
                  label: widget.isAdmin ? 'Admin Designation ID' : 'Student ID',
                  hint: 'Enter ID',
                ),
                _buildSheetInput(
                  controller: phoneCtrl,
                  label: 'Phone Number',
                  hint: 'Enter phone',
                  keyboardType: TextInputType.phone,
                ),
                _buildSheetInput(controller: deptCtrl, label: 'Department / Unit', hint: 'Enter department'),
                _buildSheetInput(
                  controller: roomCtrl,
                  label: widget.isAdmin ? 'Office Room' : 'Assigned Hostel Room',
                  hint: 'Enter room',
                ),
                _buildSheetInput(controller: addressCtrl, label: 'Permanent Address', hint: 'Enter address'),

                const SizedBox(height: 16),
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      appProvider.updateCurrentUserProfile(
                        name: nameCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                        department: deptCtrl.text.trim(),
                        room: roomCtrl.text.trim(),
                        address: addressCtrl.text.trim(),
                        studentId: idCtrl.text.trim(),
                      );
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile details updated successfully!'),
                          backgroundColor: AppColors.green,
                        ),
                      );
                    },
                    child: const Text('Save Profile Updates', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemeColorDialog(BuildContext context, Color currentThemeColor) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.palette_outlined, color: AppColors.navy, size: 22),
            SizedBox(width: 8),
            Text(
              'Change App Theme Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select your preferred accent theme color across the app:',
              style: TextStyle(fontSize: 12, color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: AppProvider.themePresets.map((preset) {
                final Color color = preset['color'];
                final String name = preset['name'];
                final isSelected = color == currentThemeColor;

                return InkWell(
                  onTap: () {
                    Provider.of<AppProvider>(context, listen: false).setThemeColor(color);
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Theme changed to $name!'),
                        backgroundColor: color,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? color.withValues(alpha: 0.15) : const Color(0xFFF4F8FC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? color : AppColors.line,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? color : AppColors.navy,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 4),
                          Icon(Icons.check, size: 14, color: color),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: AppColors.muted)),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context, Color themeColor) {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'Change Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogInput(controller: oldPassCtrl, label: 'Current Password', obscure: true),
            const SizedBox(height: 10),
            _buildDialogInput(controller: newPassCtrl, label: 'New Password', obscure: true),
            const SizedBox(height: 10),
            _buildDialogInput(controller: confirmPassCtrl, label: 'Confirm New Password', obscure: true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (newPassCtrl.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a new password'), backgroundColor: AppColors.red),
                );
                return;
              }
              if (newPassCtrl.text != confirmPassCtrl.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Passwords do not match!'), backgroundColor: AppColors.red),
                );
                return;
              }
              Provider.of<AppProvider>(context, listen: false).changePassword(newPassCtrl.text.trim());
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password updated successfully!'), backgroundColor: AppColors.green),
              );
            },
            child: const Text('Update Password'),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.navy)),
          const SizedBox(height: 4),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.line),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 11, color: AppColors.muted),
                contentPadding: const EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogInput({
    required TextEditingController controller,
    required String label,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.text)),
        const SizedBox(height: 4),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.line),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(fontSize: 12),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 9)),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, bool isLockout) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE8E8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.red,
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isLockout ? 'Lock Out / Log Out' : 'Log Out',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isLockout
                  ? 'Lock your admin session and return to portal login screen?'
                  : 'Are you sure you want to log out from your account?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.muted,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      Provider.of<AppProvider>(context, listen: false).logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      isLockout ? 'Lock Out' : 'Log Out',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final user = appProvider.currentUser;
    final themeColor = appProvider.themeColor;
    final isAdminMode = widget.isAdmin;

    final name = user?.name ?? (isAdminMode ? 'Hostel Administrator' : 'Md. Masud Rana');
    final roleLabel = isAdminMode ? 'Administrator · Office Head' : 'Resident Student';
    final idVal = user?.studentId ?? (isAdminMode ? 'ADM-001' : '241071031');
    final emailVal = user?.email ?? (isAdminMode ? 'admin@gmail.com' : 'masud@gmail.com');
    final phoneVal = user?.phone ?? '01712345678';
    final roomVal = user?.room ?? (isAdminMode ? 'Office 101' : '204B');
    final deptVal = user?.department ?? (isAdminMode ? 'Management' : 'CSE');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          isAdminMode ? 'Admin Settings' : 'Settings',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. PROFILE DETAILS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.line),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: themeColor.withValues(alpha: 0.15),
                          child: Text(
                            user?.initials ?? (isAdminMode ? 'AD' : 'MR'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.navy,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isAdminMode
                                          ? const Color(0xFFEDE9FE)
                                          : const Color(0xFFDFF8EB),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      roleLabel,
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: isAdminMode
                                            ? const Color(0xFF6D28D9)
                                            : AppColors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit_note_rounded, color: themeColor, size: 24),
                          tooltip: 'Edit Profile Details',
                          onPressed: () => _showEditProfileSheet(context, themeColor),
                        ),
                      ],
                    ),

                    const Divider(height: 24, color: AppColors.line),

                    _buildProfileDetailRow(Icons.badge_outlined, 'ID', idVal, themeColor),
                    _buildProfileDetailRow(Icons.email_outlined, 'Email', emailVal, themeColor),
                    _buildProfileDetailRow(Icons.phone_outlined, 'Phone', phoneVal, themeColor),
                    _buildProfileDetailRow(Icons.school_outlined, 'Department', deptVal, themeColor),
                    _buildProfileDetailRow(Icons.meeting_room_outlined, 'Room', roomVal, themeColor),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              const Text(
                'System & Preferences',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 10),

              // THEME COLOR CHANGE OPTION (Requested by user)
              _buildSettingCard(
                icon: Icons.palette_outlined,
                iconColor: themeColor,
                title: 'Theme Accent Color',
                subtitle: 'Customize the application primary color palette',
                onTap: () => _showThemeColorDialog(context, themeColor),
              ),
              const SizedBox(height: 10),

              // PASSWORD CHANGE OPTION (Requested by user)
              _buildSettingCard(
                icon: Icons.lock_outline_rounded,
                iconColor: AppColors.orange,
                title: 'Change Password',
                subtitle: 'Update your account login security password',
                onTap: () => _showChangePasswordDialog(context, themeColor),
              ),
              const SizedBox(height: 10),

              // LOCK OUT / LOGOUT (Requested by user)
              _buildSettingCard(
                icon: Icons.logout_rounded,
                iconColor: AppColors.red,
                title: isAdminMode ? 'Lock Out / Exit Admin' : 'Log Out',
                subtitle: isAdminMode ? 'End admin session and return to login' : 'Sign out from this device',
                subtitleColor: AppColors.red,
                onTap: () => _showLogoutDialog(context, isAdminMode),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetailRow(IconData icon, String label, String value, Color themeColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: themeColor),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 11, color: AppColors.muted),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    Color? subtitleColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.navy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: subtitleColor ?? AppColors.muted,
                          fontWeight: subtitleColor != null ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.muted,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
