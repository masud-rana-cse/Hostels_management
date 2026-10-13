class AppUser {
  final String id;
  String name;
  String email;
  String phone;
  String studentId;
  String role; // 'admin' or 'student'
  String department;
  String room;
  String address;
  String guardian;
  String joinedDate;
  String password;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.studentId,
    required this.role,
    this.department = 'CSE',
    this.room = '204B',
    this.address = 'Sector 9, Uttara, Dhaka',
    this.guardian = 'Md. Abdur Rahim (01711000000)',
    this.joinedDate = 'Jan 15, 2024',
    this.password = 'password123',
  });

  bool get isAdmin => role.toLowerCase() == 'admin';

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'U';
  }
}

class StudentItem {
  final String id;
  String name;
  String studentId;
  String room;
  String phone;
  String department;
  String joinedDate;

  StudentItem({
    required this.id,
    required this.name,
    required this.studentId,
    required this.room,
    this.phone = '01712345678',
    this.department = 'CSE',
    this.joinedDate = 'Jan 15, 2024',
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'ST';
  }
}

class StaffMember {
  final String id;
  String name;
  String role;
  String shift;
  String salary;
  String phone;

  StaffMember({
    required this.id,
    required this.name,
    required this.role,
    required this.shift,
    required this.salary,
    required this.phone,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'ST';
  }
}

class ComplaintItem {
  final String id;
  final String ticketNo;
  final String userId;
  String studentName;
  String room;
  String category;
  String description;
  String date;
  String status; // 'PENDING' or 'RESOLVED'

  ComplaintItem({
    required this.id,
    required this.ticketNo,
    this.userId = '',
    required this.studentName,
    required this.room,
    this.category = 'General',
    required this.description,
    required this.date,
    required this.status,
  });
}

class PaymentItem {
  final String id;
  final String receiptNo;
  String studentName;
  String room;
  double amount;
  String date;
  bool isPaid;
  String month;
  String method;

  PaymentItem({
    required this.id,
    required this.receiptNo,
    required this.studentName,
    required this.room,
    required this.amount,
    required this.date,
    required this.isPaid,
    this.month = 'April 2025',
    this.method = 'bKash',
  });
}
