import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/models.dart';
import '../../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class StaffScreen extends StatefulWidget {
  final bool isAdmin;

  const StaffScreen({super.key, this.isAdmin = true});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedRoleFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddStaffSheet(BuildContext context, Color themeColor) {
    final nameCtrl = TextEditingController();
    final roleCtrl = TextEditingController(text: 'Security Guard');
    final shiftCtrl = TextEditingController(text: 'Morning (8 AM–4 PM)');
    final salaryCtrl = TextEditingController(text: '৳30,000/mo');
    final phoneCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
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
                  const Text(
                    'Add New Staff Member',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                  ),
                  const SizedBox(height: 14),
                  _buildFormInput(
                    controller: nameCtrl,
                    label: 'Staff Full Name',
                    hint: 'e.g. Kamal Hossain',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: roleCtrl,
                    label: 'Job Designation / Role',
                    hint: 'e.g. Warden, Security Guard, Cleaner, Cook',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Role is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: shiftCtrl,
                    label: 'Assigned Shift',
                    hint: 'e.g. Day (8 AM–4 PM)',
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: salaryCtrl,
                    label: 'Monthly Salary',
                    hint: 'e.g. ৳35,000/mo',
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: phoneCtrl,
                    label: 'Contact Phone Number',
                    hint: 'e.g. 01712345671',
                    keyboardType: TextInputType.phone,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Phone is required' : null,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final newStaff = StaffMember(
                            id: 'st_${DateTime.now().millisecondsSinceEpoch}',
                            name: nameCtrl.text.trim(),
                            role: roleCtrl.text.trim(),
                            shift: shiftCtrl.text.trim(),
                            salary: salaryCtrl.text.trim(),
                            phone: phoneCtrl.text.trim(),
                          );
                          Provider.of<AppProvider>(context, listen: false).addStaff(newStaff);
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${newStaff.name} added to staff list'),
                              backgroundColor: AppColors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Add Staff Member', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditStaffSheet(BuildContext context, StaffMember staff, Color themeColor) {
    final nameCtrl = TextEditingController(text: staff.name);
    final roleCtrl = TextEditingController(text: staff.role);
    final shiftCtrl = TextEditingController(text: staff.shift);
    final salaryCtrl = TextEditingController(text: staff.salary);
    final phoneCtrl = TextEditingController(text: staff.phone);
    final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
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
                  const Text(
                    'Edit Staff Member',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                  ),
                  const SizedBox(height: 14),
                  _buildFormInput(
                    controller: nameCtrl,
                    label: 'Staff Full Name',
                    hint: 'Enter full name',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: roleCtrl,
                    label: 'Role / Designation',
                    hint: 'Enter role',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Role is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: shiftCtrl,
                    label: 'Shift',
                    hint: 'Enter shift',
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: salaryCtrl,
                    label: 'Salary',
                    hint: 'Enter salary',
                  ),
                  const SizedBox(height: 10),
                  _buildFormInput(
                    controller: phoneCtrl,
                    label: 'Phone Number',
                    hint: 'Enter phone',
                    keyboardType: TextInputType.phone,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Phone is required' : null,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          staff.name = nameCtrl.text.trim();
                          staff.role = roleCtrl.text.trim();
                          staff.shift = shiftCtrl.text.trim();
                          staff.salary = salaryCtrl.text.trim();
                          staff.phone = phoneCtrl.text.trim();

                          Provider.of<AppProvider>(context, listen: false).updateStaff(staff);
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${staff.name} details updated'),
                              backgroundColor: AppColors.green,
                            ),
                          );
                        }
                      },
                      child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteStaff(BuildContext context, StaffMember staff) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Remove Staff Member',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
        ),
        content: Text(
          'Are you sure you want to remove ${staff.name} (${staff.role}) from the staff records?',
          style: const TextStyle(fontSize: 12, color: AppColors.text),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: AppColors.muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              Provider.of<AppProvider>(context, listen: false).deleteStaff(staff.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${staff.name} removed from staff'),
                  backgroundColor: AppColors.red,
                ),
              );
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _callStaff(BuildContext context, StaffMember staff, Color themeColor) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 18),
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFDFF8EB),
                child: const Icon(Icons.phone_in_talk, color: AppColors.green, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                'Calling ${staff.name}',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.navy),
              ),
              Text(
                '${staff.role} · ${staff.phone}',
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F8FC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppColors.muted),
                    const SizedBox(width: 6),
                    Text(
                      'Shift: ${staff.shift}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.navy),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Dialing ${staff.phone}... Connected to ${staff.name}'),
                            backgroundColor: AppColors.green,
                          ),
                        );
                      },
                      icon: const Icon(Icons.call, size: 16),
                      label: const Text('Dial Now'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.navy)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            isDense: true,
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 11, color: AppColors.muted),
            filled: true,
            fillColor: AppColors.inputFill,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.line)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.line)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final themeColor = appProvider.themeColor;
    final staffList = appProvider.staff;
    final isAdminMode = widget.isAdmin;

    final filteredStaff = staffList.where((member) {
      final matchesSearch = _searchQuery.isEmpty ||
          member.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          member.role.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesRole = _selectedRoleFilter == 'All' ||
          member.role.toLowerCase().contains(_selectedRoleFilter.toLowerCase());

      return matchesSearch && matchesRole;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          isAdminMode ? 'Staff Management' : 'Hostel Staff Directory',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        centerTitle: true,
        // Only Admin has the Add button in AppBar
        actions: isAdminMode
            ? [
                IconButton(
                  icon: Icon(Icons.add_circle_outline_rounded, color: themeColor),
                  tooltip: 'Add Staff Member',
                  onPressed: () => _showAddStaffSheet(context, themeColor),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      style: const TextStyle(fontSize: 12, color: AppColors.text),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Search staff name or role...',
                        hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF7B8FA4)),
                        prefixIcon: Icon(Icons.search_rounded, size: 18, color: themeColor),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, size: 16, color: Color(0xFF7B8FA4)),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'Warden', 'Security', 'Cleaner', 'Cook'].map((role) {
                        final isSelected = _selectedRoleFilter == role;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: ChoiceChip(
                            label: Text(
                              role,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : AppColors.muted,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: themeColor,
                            backgroundColor: const Color(0xFFF4F8FC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: isSelected ? themeColor : AppColors.line,
                              ),
                            ),
                            onSelected: (selected) {
                              setState(() {
                                _selectedRoleFilter = selected ? role : 'All';
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: filteredStaff.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.person_search_outlined, size: 48, color: AppColors.line),
                          SizedBox(height: 8),
                          Text(
                            'No staff members found',
                            style: TextStyle(fontSize: 13, color: AppColors.muted),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
                      itemCount: filteredStaff.length,
                      itemBuilder: (context, index) {
                        final staff = filteredStaff[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          padding: const EdgeInsets.all(12.0),
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
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: themeColor.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  staff.initials,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
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
                                      staff.name,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.navy,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${staff.role} · ${staff.shift}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: AppColors.muted,
                                      ),
                                    ),
                                    if (isAdminMode) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        'Salary: ${staff.salary}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),

                              // Quick Call Button (Both can call, but prominent for students)
                              InkWell(
                                onTap: () => _callStaff(context, staff, themeColor),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.call, size: 12, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text(
                                        'Call',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Only Admin gets Edit and Delete options!
                              if (isAdminMode) ...[
                                const SizedBox(width: 4),
                                PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert, size: 18, color: AppColors.muted),
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  onSelected: (val) {
                                    if (val == 'edit') {
                                      _showEditStaffSheet(context, staff, themeColor);
                                    } else if (val == 'delete') {
                                      _deleteStaff(context, staff);
                                    }
                                  },
                                  itemBuilder: (ctx) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit_outlined, size: 16, color: AppColors.navy),
                                          SizedBox(width: 8),
                                          Text('Edit Staff', style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete_outline, size: 16, color: AppColors.red),
                                          SizedBox(width: 8),
                                          Text('Remove Staff', style: TextStyle(fontSize: 12, color: AppColors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
            ),

            // If Admin: also has bottom "+ Add New Staff" button
            if (isAdminMode)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () => _showAddStaffSheet(context, themeColor),
                    icon: const Icon(Icons.add, color: Colors.white, size: 20),
                    label: const Text(
                      'Add Staff Member',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
