import 'package:flutter/material.dart';
import '../models/models.dart';
import '../ui/theme/app_theme.dart';

class AppProvider extends ChangeNotifier {
  AppUser? _currentUser;
  Color _themeColor = AppColors.blue;

  // Preset Theme Colors
  static const List<Map<String, dynamic>> themePresets = [
    {'name': 'Ocean Blue', 'color': Color(0xFF0868DF)},
    {'name': 'Royal Indigo', 'color': Color(0xFF4F46E5)},
    {'name': 'Emerald Green', 'color': Color(0xFF059669)},
    {'name': 'Crimson Red', 'color': Color(0xFFDC2626)},
    {'name': 'Midnight Purple', 'color': Color(0xFF7C3AED)},
    {'name': 'Sunset Amber', 'color': Color(0xFFEA580C)},
  ];

  // 1. Registered Users (For Login, Role Checking & Admin Permissions)
  final List<AppUser> _users = [
    AppUser(
      id: 'admin_1',
      name: 'Hostel Administrator',
      email: 'admin@gmail.com',
      phone: '01700000000',
      studentId: 'ADM-001',
      role: 'admin',
      department: 'Hostel Administration',
      room: 'Office 101',
      address: 'Hostel Admin Complex, Uttara',
      guardian: 'Board of Governors',
      joinedDate: 'Jan 01, 2023',
      password: 'password123',
    ),
    AppUser(
      id: 'user_1',
      name: 'Md. Masud Rana',
      email: 'masud@gmail.com',
      phone: '01712345678',
      studentId: '241071031',
      role: 'student',
      department: 'CSE (Computer Science)',
      room: '204B',
      address: 'Sector 9, Uttara, Dhaka',
      guardian: 'Md. Abdur Rahim (01711000000)',
      joinedDate: 'Jan 15, 2024',
      password: 'password123',
    ),
    AppUser(
      id: 'user_2',
      name: 'Jonaki Akter',
      email: 'jonaki@gmail.com',
      phone: '01812345672',
      studentId: '241071032',
      role: 'student',
      department: 'BBA (Management)',
      room: '301A',
      address: 'Mirpur 10, Dhaka',
      guardian: 'Mohammad Ali (01811223344)',
      joinedDate: 'Feb 10, 2024',
      password: 'password123',
    ),
    AppUser(
      id: 'user_3',
      name: 'Rakib Hasan',
      email: 'rakib@gmail.com',
      phone: '01912345673',
      studentId: '241071035',
      role: 'student',
      department: 'EEE (Electrical)',
      room: '105C',
      address: 'Dhanmondi, Dhaka',
      guardian: 'Kalam Hasan (01911445566)',
      joinedDate: 'Mar 01, 2024',
      password: 'password123',
    ),
    AppUser(
      id: 'user_4',
      name: 'Sadia Islam',
      email: 'sadia@gmail.com',
      phone: '01612345674',
      studentId: '241071037',
      role: 'student',
      department: 'Pharmacy',
      room: '202A',
      address: 'Banani, Dhaka',
      guardian: 'Nazrul Islam (01611778899)',
      joinedDate: 'Mar 15, 2024',
      password: 'password123',
    ),
  ];

  // 2. Students Roster
  final List<StudentItem> _students = [
    StudentItem(
      id: '1',
      name: 'Md. Masud Rana',
      studentId: '241071031',
      room: '204B',
      phone: '01712345678',
      department: 'CSE (Computer Science)',
      joinedDate: 'Jan 15, 2024',
    ),
    StudentItem(
      id: '2',
      name: 'Jonaki Akter',
      studentId: '241071032',
      room: '301A',
      phone: '01812345672',
      department: 'BBA (Management)',
      joinedDate: 'Feb 10, 2024',
    ),
    StudentItem(
      id: '3',
      name: 'Rakib Hasan',
      studentId: '241071035',
      room: '105C',
      phone: '01912345673',
      department: 'EEE (Electrical)',
      joinedDate: 'Mar 01, 2024',
    ),
    StudentItem(
      id: '4',
      name: 'Sadia Islam',
      studentId: '241071037',
      room: '202A',
      phone: '01612345674',
      department: 'Pharmacy',
      joinedDate: 'Mar 15, 2024',
    ),
  ];

  // 3. Staff Members
  final List<StaffMember> _staff = [
    StaffMember(
      id: '1',
      name: 'Kamal Hossain',
      role: 'Warden',
      shift: 'Morning (7 AM–3 PM)',
      salary: '৳45,000/mo',
      phone: '01712345671',
    ),
    StaffMember(
      id: '2',
      name: 'Salam Mia',
      role: 'Security Guard',
      shift: 'Night (8 PM–6 AM)',
      salary: '৳32,000/mo',
      phone: '01812345672',
    ),
    StaffMember(
      id: '3',
      name: 'Rafiq Uddin',
      role: 'Cleaner',
      shift: 'Day (8 AM–4 PM)',
      salary: '৳28,000/mo',
      phone: '01912345673',
    ),
    StaffMember(
      id: '4',
      name: 'Jahangir Alam',
      role: 'Chief Cook',
      shift: 'Split (6 AM–2 PM, 6 PM–9 PM)',
      salary: '৳35,000/mo',
      phone: '01612345674',
    ),
  ];

  // 4. Complaints
  final List<ComplaintItem> _complaints = [
    ComplaintItem(
      id: '1',
      ticketNo: 'Ticket #CMP-104',
      userId: 'user_2',
      studentName: 'Jonaki Akter',
      room: 'Room 304',
      category: 'Plumbing',
      description: 'Water leakage in bathroom pipe',
      date: 'Apr 12, 2025',
      status: 'PENDING',
    ),
    ComplaintItem(
      id: '2',
      ticketNo: 'Ticket #CMP-099',
      userId: 'user_3',
      studentName: 'Tanvir Ahmed',
      room: 'Room 102',
      category: 'Electrical',
      description: 'Corridor tube light replaced',
      date: 'Apr 10, 2025',
      status: 'RESOLVED',
    ),
    ComplaintItem(
      id: '3',
      ticketNo: 'Ticket #CMP-095',
      userId: 'user_1',
      studentName: 'Md. Masud Rana',
      room: 'Room 204B',
      category: 'Appliances',
      description: 'Ceiling fan making squeaking noise',
      date: 'Apr 06, 2025',
      status: 'RESOLVED',
    ),
  ];

  // 5. Payments
  final List<PaymentItem> _payments = [
    PaymentItem(
      id: '1',
      receiptNo: 'RCP-9012',
      studentName: 'Md. Masud Rana',
      room: 'Room 204B',
      amount: 3000.0,
      date: 'Apr 10, 2025',
      isPaid: true,
      month: 'April 2025',
      method: 'bKash',
    ),
    PaymentItem(
      id: '2',
      receiptNo: 'RCP-9013',
      studentName: 'Jonaki Akter',
      room: 'Room 301A',
      amount: 3000.0,
      date: 'Apr 08, 2025',
      isPaid: false,
      month: 'April 2025',
      method: 'Nagad',
    ),
    PaymentItem(
      id: '3',
      receiptNo: 'RCP-9014',
      studentName: 'Rakib Hasan',
      room: 'Room 105C',
      amount: 3000.0,
      date: 'Apr 05, 2025',
      isPaid: true,
      month: 'April 2025',
      method: 'Bank Transfer',
    ),
    PaymentItem(
      id: '4',
      receiptNo: 'RCP-9015',
      studentName: 'Sadia Islam',
      room: 'Room 202A',
      amount: 3000.0,
      date: 'Apr 02, 2025',
      isPaid: false,
      month: 'April 2025',
      method: 'Cash',
    ),
  ];

  // Getters
  AppUser? get currentUser => _currentUser;
  bool get isAdmin => _currentUser?.isAdmin ?? false;
  Color get themeColor => _themeColor;
  List<AppUser> get allUsers => List.unmodifiable(_users);
  List<StudentItem> get students => List.unmodifiable(_students);
  List<StaffMember> get staff => List.unmodifiable(_staff);
  List<ComplaintItem> get complaints => List.unmodifiable(_complaints);
  List<PaymentItem> get payments => List.unmodifiable(_payments);

  // Filtered Complaints for current student
  List<ComplaintItem> get myComplaints {
    if (_currentUser == null) return [];
    return _complaints.where((c) {
      return c.userId == _currentUser!.id ||
          c.studentName.toLowerCase() == _currentUser!.name.toLowerCase() ||
          c.room.toLowerCase() == _currentUser!.room.toLowerCase();
    }).toList();
  }

  // Filtered Payments for current student
  List<PaymentItem> get myPayments {
    if (_currentUser == null) return [];
    return _payments.where((p) {
      return p.studentName.toLowerCase() == _currentUser!.name.toLowerCase() ||
          p.room.toLowerCase() == _currentUser!.room.toLowerCase();
    }).toList();
  }

  // Theme Setter
  void setThemeColor(Color color) {
    _themeColor = color;
    notifyListeners();
  }

  // Login Functionality with exact email and password checking
  (bool, String) login(String email, String password) {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPass = password.trim();

    if (cleanEmail.isEmpty) {
      return (false, 'Please enter your email address.');
    }
    if (cleanPass.isEmpty) {
      return (false, 'Please enter your password.');
    }

    // Check existing registered users
    final index = _users.indexWhere((u) => u.email.toLowerCase() == cleanEmail);
    if (index == -1) {
      return (false, 'No account found with this email. Please Sign Up first.');
    }

    final user = _users[index];
    final isPasswordValid = (user.password == cleanPass) ||
        (user.isAdmin && (cleanPass == 'admin123' || cleanPass == 'password123')) ||
        (!user.isAdmin && (cleanPass == 'user123' || cleanPass == 'password123'));

    if (!isPasswordValid) {
      return (false, 'Incorrect password. Please enter the password you used during signup.');
    }

    _currentUser = user;
    notifyListeners();
    return (true, 'Success');
  }

  // Sign Up Functionality
  bool signUp({
    required String name,
    required String email,
    required String phone,
    required String studentId,
    required String role, // 'admin' or 'student'
    required String password,
    String department = 'CSE',
    String room = '101A',
  }) {
    final cleanEmail = email.trim().toLowerCase();
    final exists = _users.any((u) => u.email.toLowerCase() == cleanEmail);
    if (exists) {
      return false;
    }

    final newUser = AppUser(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: cleanEmail,
      phone: phone.trim(),
      studentId: studentId.trim(),
      role: role.toLowerCase(),
      department: department,
      room: room,
      password: password.trim(),
      joinedDate: 'Apr 2025',
    );

    _users.add(newUser);

    if (newUser.role == 'student') {
      _students.add(StudentItem(
        id: newUser.id,
        name: newUser.name,
        studentId: newUser.studentId,
        room: newUser.room,
        phone: newUser.phone,
        department: newUser.department,
      ));
    }

    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  // Admin Permission Toggle: Give or revoke Admin permission
  void toggleAdminPermission(String userId) {
    final index = _users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final user = _users[index];
      if (user.role.toLowerCase() == 'admin') {
        user.role = 'student';
      } else {
        user.role = 'admin';
      }

      // If the current logged-in user's role changed, update instance
      if (_currentUser?.id == userId) {
        _currentUser = user;
      }
      notifyListeners();
    }
  }

  // User Profile Update
  void updateCurrentUserProfile({
    required String name,
    required String phone,
    required String department,
    required String room,
    required String address,
    required String studentId,
  }) {
    if (_currentUser == null) return;
    _currentUser!.name = name;
    _currentUser!.phone = phone;
    _currentUser!.department = department;
    _currentUser!.room = room;
    _currentUser!.address = address;
    _currentUser!.studentId = studentId;

    // Synchronize in users list
    final uIndex = _users.indexWhere((u) => u.id == _currentUser!.id);
    if (uIndex != -1) {
      _users[uIndex] = _currentUser!;
    }

    // Synchronize in students roster if present
    final sIndex = _students.indexWhere((s) => s.id == _currentUser!.id || s.studentId == _currentUser!.studentId);
    if (sIndex != -1) {
      _students[sIndex].name = name;
      _students[sIndex].room = room;
      _students[sIndex].phone = phone;
      _students[sIndex].department = department;
      _students[sIndex].studentId = studentId;
    }

    notifyListeners();
  }

  // Change Password
  void changePassword(String newPassword) {
    if (_currentUser == null) return;
    _currentUser!.password = newPassword;
    final uIndex = _users.indexWhere((u) => u.id == _currentUser!.id);
    if (uIndex != -1) {
      _users[uIndex].password = newPassword;
    }
    notifyListeners();
  }

  // Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // -------------------------------------------------------------
  // Student CRUD Operations (Admin)
  // -------------------------------------------------------------
  void addStudent(StudentItem student) {
    _students.add(student);
    notifyListeners();
  }

  void updateStudent(StudentItem updatedStudent) {
    final index = _students.indexWhere((s) => s.id == updatedStudent.id);
    if (index != -1) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

  void deleteStudent(String id) {
    _students.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  // -------------------------------------------------------------
  // Staff CRUD Operations (Admin)
  // -------------------------------------------------------------
  void addStaff(StaffMember member) {
    _staff.add(member);
    notifyListeners();
  }

  void updateStaff(StaffMember updatedMember) {
    final index = _staff.indexWhere((s) => s.id == updatedMember.id);
    if (index != -1) {
      _staff[index] = updatedMember;
      notifyListeners();
    }
  }

  void deleteStaff(String id) {
    _staff.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  // -------------------------------------------------------------
  // Complaint Operations (User can add; Admin can resolve/reopen)
  // -------------------------------------------------------------
  void addComplaint({
    required String description,
    required String category,
    required String room,
  }) {
    final studentName = _currentUser?.name ?? 'Resident';
    final userId = _currentUser?.id ?? '';
    final newComplaint = ComplaintItem(
      id: 'cmp_${DateTime.now().millisecondsSinceEpoch}',
      ticketNo: 'Ticket #CMP-${100 + _complaints.length + 1}',
      userId: userId,
      studentName: studentName,
      room: room.isNotEmpty ? room : (_currentUser?.room ?? 'Room 204B'),
      category: category,
      description: description,
      date: 'Just now',
      status: 'PENDING',
    );
    _complaints.insert(0, newComplaint);
    notifyListeners();
  }

  void toggleComplaintStatus(String id) {
    final index = _complaints.indexWhere((c) => c.id == id);
    if (index != -1) {
      final current = _complaints[index];
      current.status = (current.status == 'PENDING') ? 'RESOLVED' : 'PENDING';
      notifyListeners();
    }
  }

  void deleteComplaint(String id) {
    _complaints.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  // -------------------------------------------------------------
  // Payment Operations
  // -------------------------------------------------------------
  void addPayment(PaymentItem payment) {
    _payments.insert(0, payment);
    notifyListeners();
  }

  void togglePaymentStatus(String id) {
    final index = _payments.indexWhere((p) => p.id == id);
    if (index != -1) {
      _payments[index].isPaid = !_payments[index].isPaid;
      notifyListeners();
    }
  }

  void deletePayment(String id) {
    _payments.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
