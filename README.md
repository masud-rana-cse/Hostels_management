# 🏢 Hostel Management System (Flutter Mobile App)

A modern, full-featured, role-based **Hostel Management System** built with **Flutter** and **Provider**. It features complete UI design separation for **Student Residents** and **Hostel Administrators**, complete with live dynamic theme customization and real-time state management.

---

## 📸 Screenshots & UI Showcase

The app is built following a clean, Figma-styled mobile prototype with pixel-perfect responsive components:

- **Login & Sign Up Screens:** Streamlined email & password authentication with role-aware navigation.
- **Admin Dashboard:** Overview grid metrics, registered users permission switcher, and collection charts.
- **Student Home:** Personal room card (Room 204B), rent status, payment history chart, and staff assistance shortcuts.
- **Student Directory:** Searchable resident list with Add, Edit, and Delete actions.
- **Staff Management:** Role-filtered staff list with direct **Call** buttons.
- **Payment Receipts:** Financial overview banner, payment method badges, and status toggles.
- **Complaints Box:** Filtered ticket management (`PENDING` vs `RESOLVED`) with ticket creation and status updates.
- **Settings & Theme Customizer:** Profile details card, Edit Profile sheet, password manager, and 6 preset Theme Accent Color palettes!

---

## 🌟 Core Features & Modules

### 🔐 1. Authentication & Role-Based Access
- **Smart Login (`login_screen.dart`):** Automatically routes users based on their registered role (**Student** vs **Admin**).
- **Default Accounts for Testing:**
  - **Admin Login:** `admin@gmail.com` / `password123`
  - **Student Logins:**
    - `masud@gmail.com` / `password123` (*Md. Masud Rana - Room 204B*)
    - `jonaki@gmail.com` / `password123` (*Jonaki Akter - Room 301A*)
    - `rakib@gmail.com` / `password123` (*Rakib Hasan - Room 105C*)
    - `sadia@gmail.com` / `password123` (*Sadia Islam - Room 202A*)
- **Sign Up (`signup_screen.dart`):** Registration for new residents with Full Name, Email, Phone, Student ID, Allocated Room, and Password.
- **Role Permission Management (Admin Only):** Admin can toggle `Make Admin` or `Revoke Admin` permissions for any user in real-time.

---

### 👑 2. Admin Portal Features
1. **Admin Overview (`home_screen.dart`):**
   - Admin Header with Avatar (`HA`), Admin Title (`Hostel Administrator`), Subtitle (`Admin Portal · Full System Access`), and Notification Bell.
   - 4 Metric Grid Cards: `Total Students (4)`, `Total Staff (4)`, `Pending Dues (৳6,000)`, `Active Complaints (1 Pending)`.
   - Quick Filter Shortcuts: `Students (4)`, `Staff (4)`, `Payments`.
   - **All Registered Users List:** Displays all logged-in accounts with interactive `[Make Admin]` and `[Revoke Admin]` permission buttons.
   - **Monthly Collections Chart:** Bar chart representing revenue analytics.

2. **Student Directory (`student_screen.dart`):**
   - Real-time search bar by student name, student ID, or room number.
   - Resident Cards with Avatar initials, Full Name, ID, Room, Department, and Phone.
   - Edit Student profile & Delete Student with confirmation.
   - **`＋ Add Student`** bottom action button with modal form.

3. **Staff Management (`staff_screen.dart`):**
   - Role Filter Chips: `All`, `Warden`, `Security`, `Cleaner`, `Cook`.
   - Search bar by staff name or designation.
   - Staff Cards with Shift timing, Salary (`৳45,000/mo`), and direct **`Call`** green pill button.
   - Popup menu to Call or Remove staff.
   - **`＋ Add Staff Member`** bottom action button.

4. **Payment Management (`payment_screen.dart`):**
   - Metrics Banner: `Total Paid` (৳6,000) vs `Pending Due` (৳6,000).
   - Search bar by student name, room, or receipt number.
   - Payment Receipts showing Date, Payment Method (*bKash, Nagad, Bank Transfer, Cash*), Amount, and `PAID` / `DUE` Status Badges.
   - Toggle payment status & Delete receipt actions.
   - **`＋ Log New Payment`** floating/top action button.

5. **Complaints Box (`complain_screen.dart`):**
   - Filter Tabs: `All (3)`, `Pending (1)`, `Resolved (2)`.
   - Complaint Cards displaying Ticket Number, Category Badge (*Plumbing, Electrical, Appliances*), Status Badge (*PENDING / RESOLVED*), Student Name, Room, Description, and Date.
   - Action buttons: `[Mark Resolved]` / `[Reopen]` & Delete ticket.
   - **`＋ File New Complaint Ticket`** bottom action button.

6. **Admin Settings (`setting_screen.dart`):**
   - **Admin Profile Header Card:** Profile Avatar (`HA`), Name, ID (`ADM-001`), Email, Phone, Department (`Hostel Administration`), and Room (`Office 101`).
   - **Theme Accent Color Picker:** 6 preset color palettes (*Ocean Blue, Royal Indigo, Emerald Green, Crimson Red, Midnight Purple, Sunset Amber*) that dynamically change the application primary theme color!
   - **Change Password:** Modal dialog to update security credentials.
   - **Lock Out / Exit Admin:** Confirmation modal to end session and return to login screen.

---

### 🎓 3. Student Portal Features
1. **Student Dashboard (`home_screen.dart`):**
   - **Student Header:** Avatar (`MR`), Name (`Md. Masud Rana`), Subtitle (`Resident · 204B (Bed A)`), Notification bell with 3 new notifications.
   - **Room Card:** Blue gradient hero banner `Room 204B` (*Bed: A · 2nd Floor · Active Resident*) with `[View Details]` room details bottom sheet.
   - **Rent Metrics:** `Monthly Rent` (৳3,000) & `Last Payment` (৳3,000 Paid).
   - **My Complaints Status:** Summary card showing `0 Ticket Pending · 1 Resolved` with `[File Complaint]` shortcut.
   - **My Payment History:** Bar chart displaying personal payment trends over 6 months.
   - **Need Hostel Staff Assistance Card:** Emergency card with direct `[Call Staff]` green button.

2. **Student My Info (`student_screen.dart`):**
   - **Personal Profile Card:** Large Avatar (`MR`), Name (`Md. Masud Rana`), Status Badge (`Active Resident · Room 204B`).
   - **Detailed Profile List:** Student ID (`241071031`), Department (`CSE`), Assigned Room (`Room 204B`), Phone (`01712345678`), Email (`masud@gmail.com`), Address (`Sector 9, Uttara, Dhaka`), Guardian Contact (`Md. Abdur Rahim`), Joined Date (`Jan 15, 2024`).

3. **Hostel Staff Directory (`staff_screen.dart`):**
   - View all hostel staff members (*Warden, Security, Cleaner, Cook*) with direct **`Call`** buttons.

4. **My Payment Receipts (`payment_screen.dart`):**
   - Personal payment receipts list with `Total Paid` & `Pending Due` summary.

5. **My Complaints (`complain_screen.dart`):**
   - View personal complaint tickets, status badges (`PENDING` / `RESOLVED`), and option to `[File New Complaint Ticket]`.

6. **Student Settings (`setting_screen.dart`):**
   - Profile Header Card with **Edit Profile Details** sheet to update Name, Phone, Department, Room, and Address live!
   - **Theme Accent Color Customizer:** Switch primary color palette dynamically.
   - **Change Password:** Security dialog.
   - **Log Out:** Confirmation dialog to sign out from device.

---

## 🛠 Project Structure & Architecture

```
lib/
├── main.dart                      # App Entry Point & Provider Root
├── models/
│   └── models.dart                # AppUser, StudentItem, StaffMember, ComplaintItem, PaymentItem
├── providers/
│   └── app_provider.dart          # Global State, Authentication, Role Logic, Theme, CRUD Operations
└── ui/
    ├── theme/
    │   └── app_theme.dart         # Color Palettes & ThemeData Configuration
    └── screens/
        ├── screens.dart           # Screen Exports
        ├── auth/
        │   ├── login_screen.dart  # Login Page with Email & Password Validation
        │   ├── signup_screen.dart # Registration Page for Residents
        │   └── splash_screen.dart # Animated Branding Splash Screen
        ├── dashboard/
        │   ├── dashboard_screen.dart # Main Bottom Navigation Scaffold
        │   └── home_screen.dart      # Admin Overview & Student Dashboard
        └── features/
            ├── student_screen.dart   # Student Directory / My Info Profile
            ├── staff_screen.dart     # Staff Management Directory & Calling System
            ├── payment_screen.dart   # Payment Receipts & Financial Records
            ├── complain_screen.dart  # Complaints Box & Ticket Management
            └── setting_screen.dart   # User Profile, Theme Color Picker, Password & Logout
```

---

## 🚀 Getting Started & Running the App

### Prerequisites:
- Flutter SDK (v3.0.0 or higher)
- Android Studio / VS Code / IntelliJ IDEA
- Android Emulator / iOS Simulator / Physical Device

### Installation Steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/masud-rana-cse/Hostel_App.git
   cd Hostel_App
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Check Analysis & Build Status:**
   ```bash
   dart analyze
   ```

4. **Run the Application:**
   ```bash
   flutter run
   ```

---

## 📄 License
This project is open-source and available under the **MIT License**.
