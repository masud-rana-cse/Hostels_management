import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/models.dart';
import '../../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class StudentScreen extends StatefulWidget {
  final bool isAdmin;

  const StudentScreen({super.key, this.isAdmin = true});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddStudentDialog(BuildContext context, Color themeColor) {
    final nameController = TextEditingController();
    final idController = TextEditingController();
    final roomController = TextEditingController();
    final phoneController = TextEditingController();
    final deptController = TextEditingController(text: 'CSE');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Add New Student',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField(
                  controller: nameController,
                  label: 'Full Name',
                  hint: 'e.g. Tanvir Ahmed',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: idController,
                  label: 'Student ID',
                  hint: 'e.g. 241071040',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Student ID is required' : null,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: roomController,
                  label: 'Room Number',
                  hint: 'e.g. 104A',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Room is required' : null,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: phoneController,
                  label: 'Phone Number',
                  hint: 'e.g. 01712345679',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: deptController,
                  label: 'Department',
                  hint: 'e.g. BBA, CSE, EEE',
                ),
              ],
            ),
          ),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newStudent = StudentItem(
                  id: 'std_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameController.text.trim(),
                  studentId: idController.text.trim(),
                  room: roomController.text.trim(),
                  phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : '01710000000',
                  department: deptController.text.trim().isNotEmpty ? deptController.text.trim() : 'General',
                );

                Provider.of<AppProvider>(context, listen: false).addStudent(newStudent);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${newStudent.name} added to roster!'),
                    backgroundColor: AppColors.green,
                  ),
                );
              }
            },
            child: const Text('Save Student'),
          ),
        ],
      ),
    );
  }

  void _showEditStudentDialog(BuildContext context, StudentItem student, Color themeColor) {
    final nameController = TextEditingController(text: student.name);
    final idController = TextEditingController(text: student.studentId);
    final roomController = TextEditingController(text: student.room);
    final phoneController = TextEditingController(text: student.phone);
    final deptController = TextEditingController(text: student.department);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Edit Student Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField(
                  controller: nameController,
                  label: 'Full Name',
                  hint: 'Enter full name',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: idController,
                  label: 'Student ID',
                  hint: 'Enter student ID',
                  validator: (v) => v == null || v.trim().isEmpty ? 'ID is required' : null,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: roomController,
                  label: 'Room Number',
                  hint: 'Enter room',
                  validator: (v) => v == null || v.trim().isEmpty ? 'Room is required' : null,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: phoneController,
                  label: 'Phone Number',
                  hint: 'Enter phone',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                _buildDialogField(
                  controller: deptController,
                  label: 'Department',
                  hint: 'Enter department',
                ),
              ],
            ),
          ),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                student.name = nameController.text.trim();
                student.studentId = idController.text.trim();
                student.room = roomController.text.trim();
                student.phone = phoneController.text.trim();
                student.department = deptController.text.trim();

                Provider.of<AppProvider>(context, listen: false).updateStudent(student);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${student.name} updated successfully!'),
                    backgroundColor: AppColors.green,
                  ),
                );
              }
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _deleteStudent(BuildContext context, StudentItem student) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Student',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
        ),
        content: Text(
          'Are you sure you want to remove ${student.name} from the student database?',
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
              Provider.of<AppProvider>(context, listen: false).deleteStudent(student.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${student.name} has been removed'),
                  backgroundColor: AppColors.red,
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.navy),
        ),
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
    final isAdminMode = widget.isAdmin;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          isAdminMode ? 'Student Directory' : 'My Info',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isAdminMode
            ? _buildAdminStudentList(appProvider, themeColor)
            : _buildStudentSingleProfile(appProvider, themeColor),
      ),
    );
  }

  // ==========================================
  // STUDENT / USER VIEW: MY INFO
  // ==========================================
  Widget _buildStudentSingleProfile(AppProvider provider, Color themeColor) {
    final user = provider.currentUser;
    final name = user?.name ?? 'Md. Masud Rana';
    final studentId = user?.studentId ?? '241071031';
    final dept = user?.department ?? 'CSE (Computer Science)';
    final room = user?.room ?? '204B';
    final phone = user?.phone ?? '01712345678';
    final email = user?.email ?? 'masud@gmail.com';
    final address = user?.address ?? 'Sector 9, Uttara, Dhaka';
    final guardian = user?.guardian ?? 'Md. Abdur Rahim (01711000000)';
    final joined = user?.joinedDate ?? 'Jan 15, 2024';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
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
                CircleAvatar(
                  radius: 36,
                  backgroundColor: themeColor.withValues(alpha: 0.15),
                  child: Text(
                    user?.initials ?? 'MR',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF8EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Active Resident · Room $room (Bed A)',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                ),
                const Divider(height: 28, color: AppColors.line),

                _buildInfoRow(Icons.badge_outlined, 'Student ID', studentId, themeColor),
                _buildInfoRow(Icons.school_outlined, 'Department', dept, themeColor),
                _buildInfoRow(Icons.meeting_room_outlined, 'Assigned Room', 'Room $room (Bed A)', themeColor),
                _buildInfoRow(Icons.phone_outlined, 'Phone', phone, themeColor),
                _buildInfoRow(Icons.email_outlined, 'Email', email, themeColor),
                _buildInfoRow(Icons.location_on_outlined, 'Address', address, themeColor),
                _buildInfoRow(Icons.person_outline, 'Guardian Contact', guardian, themeColor),
                _buildInfoRow(Icons.calendar_today_outlined, 'Joined Date', joined, themeColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color themeColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: themeColor),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 12, color: AppColors.muted),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ADMIN VIEW: ALL STUDENTS WITH ADD, EDIT, DELETE
  // ==========================================
  Widget _buildAdminStudentList(AppProvider provider, Color themeColor) {
    final students = provider.students;
    final filtered = _searchQuery.trim().isEmpty
        ? students
        : students.where((s) {
            final q = _searchQuery.toLowerCase();
            return s.name.toLowerCase().contains(q) ||
                s.studentId.toLowerCase().contains(q) ||
                s.room.toLowerCase().contains(q);
          }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search students by name, ID, or room...',
              hintStyle: const TextStyle(fontSize: 12, color: AppColors.muted),
              prefixIcon: Icon(Icons.search, color: themeColor, size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: themeColor, width: 1.5),
              ),
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const Center(
                  child: Text(
                    'No students found',
                    style: TextStyle(color: AppColors.muted, fontSize: 14),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final student = filtered[index];

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.line),
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.cardShadow,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: themeColor.withValues(alpha: 0.12),
                            child: Text(
                              student.initials,
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.text,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'ID: ${student.studentId}  ·  Room: ${student.room}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.muted,
                                  ),
                                ),
                                Text(
                                  'Dept: ${student.department}  ·  ${student.phone}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // EDIT STUDENT BUTTON
                          IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: themeColor,
                              size: 20,
                            ),
                            tooltip: 'Edit Student',
                            onPressed: () => _showEditStudentDialog(context, student, themeColor),
                          ),

                          // DELETE STUDENT BUTTON
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.red,
                              size: 20,
                            ),
                            tooltip: 'Delete Student',
                            onPressed: () => _deleteStudent(context, student),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
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
              onPressed: () => _showAddStudentDialog(context, themeColor),
              icon: const Icon(Icons.add, color: Colors.white, size: 20),
              label: const Text(
                'Add Student',
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
    );
  }
}
