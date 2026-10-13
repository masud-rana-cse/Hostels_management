# Hostel Management — Mobile App UI Design System & Specifications

> **Source Prototype File**: [`ui_prototype.html`](file:///d:/hostel_app/ui_prototype.html)  
> Interactive 20-screen Figma-style prototype for browser preview and Flutter UI reference.

---

## 🎨 Color Palette & Design Tokens

| Token Name | Hex Code | Purpose / Usage |
|:---|:---|:---|
| **Primary Blue** | `#0868DF` | Main CTA buttons, active tabs, highlight icons, branding |
| **Deep Navy** | `#063B73` | Headings, bold titles, status bar elements, dark accents |
| **Dark Blue Border** | `#092F55` | Phone frame border, primary contrast accents |
| **Light BG** | `#F4F8FC` / `#E9F0F7` | App background, page background, card surfaces |
| **Card / Field Surface**| `#FFFFFF` / `#FBFDFF` | Cards, input fields, modals |
| **Border / Divider** | `#DCE8F4` | Input outlines, card borders, tab backgrounds |
| **Primary Text** | `#12304D` | Body text, labels, primary content |
| **Muted Text** | `#6C8197` / `#7B8FA4`| Subtitles, timestamps, placeholders |
| **Success / Paid** | `#13A66A` (`#DFF8EB` bg) | Paid badges, positive metrics, connected sync |
| **Warning / Pending** | `#FF9D2E` (`#FFF0D8` bg) | Pending dues, pending complaints, alerts |
| **Danger / Red** | `#EF4444` (`#FFE8E8` bg) | Delete buttons, logout modal, urgent items |

---

## 🔤 Typography & Components

- **Font Family**: Inter, Arial, sans-serif (`GoogleFonts.inter` in Flutter)
- **H1**: 23px, Bold, `#063B73`
- **H2**: 20px, Bold, `#063B73`
- **H3**: 15px, Semi-Bold, `#063B73`
- **Body**: 12px Regular, `#12304D`
- **Small/Muted**: 10px Regular, `#6C8197`
- **Input Fields**: 42px height, 10px border radius, `#FBFDFF` fill, `#DCE8F4` border
- **Buttons**: 11px-12px border radius, 12px bold, 44px-48px touch height
- **Cards**: 12px-16px border radius, subtle box shadow `rgba(23, 59, 92, 0.04)`

---

## 📱 20 Screen Overview & Flutter Mapping

| Screen # | Screen Name | Description & Elements | Flutter File Target |
|:---:|:---|:---|:---|
| **01** | **Splash Screen** | Gradient blue background, hostel logo, title, subtitle ("Safe Stay · Better Tomorrow"), circular progress indicator | [`splash_screen.dart`](file:///d:/hostel_app/lib/ui/screens/splash_screen.dart) |
| **02** | **Student Login** | Email/Phone input, password with show/hide eye, "Remember me", "Forgot Password", Login button, Create New Account button | [`login_screen.dart`](file:///d:/hostel_app/lib/ui/screens/login_screen.dart) |
| **03** | **Create Account** | Student / Staff segment toggle, Full Name, Email, Phone, Student ID, Password, Confirm Password, Sign Up button | [`signup_screen.dart`](file:///d:/hostel_app/lib/ui/screens/signup_screen.dart) |
| **04** | **Forgot Password** | Big email envelope icon, email/phone input field, "Send Reset Link", back to login link | [`login_screen.dart`](file:///d:/hostel_app/lib/ui/screens/login_screen.dart) |
| **05** | **Student Home** | Topbar (greeting + notification bell), Room Card (Room 204B, Bed A), Monthly Rent & Last Payment stat cards, Recent Notifications | [`home_screen.dart`](file:///d:/hostel_app/lib/ui/screens/home_screen.dart) |
| **06** | **My Profile** | Avatar with initials, student name, ID, detail rows (Room, Dept, Phone, Email, Address), Edit Profile & Change Password buttons | [`setting_screen.dart`](file:///d:/hostel_app/lib/ui/screens/setting_screen.dart) |
| **07** | **Student Directory** | Search bar, student list items with avatar, name, ID, room, delete action icon, "+ Add New Student" button | [`student_screen.dart`](file:///d:/hostel_app/lib/ui/screens/student_screen.dart) |
| **08** | **Payment Receipts** | Monthly target progress bar (Collected vs Due), receipt list with status badges (`PAID` / `PENDING`), "+ Log New Payment" button | [`payment_screen.dart`](file:///d:/hostel_app/lib/ui/screens/payment_screen.dart) |
| **09** | **Payment Details** | Student header card, breakdown list (Amount, Month, Method, Trx ID, Date, Status badge), Edit and Delete buttons | [`payment_screen.dart`](file:///d:/hostel_app/lib/ui/screens/payment_screen.dart) |
| **10** | **Staff Management** | Search staff bar, staff cards with shift & salary info, quick Call button, "+ Add New Staff" button | [`staff_screen.dart`](file:///d:/hostel_app/lib/ui/screens/staff_screen.dart) |
| **11** | **Complaint Box** | Filter tabs (All / Pending / Resolved), ticket cards with status badge, room number, description, "Change Status", "+ Add Complaint" | [`complain_screen.dart`](file:///d:/hostel_app/lib/ui/screens/complain_screen.dart) |
| **12** | **Settings** | Hostel profile, Firebase Cloud Sync status badge, Change Password, Notification Settings, App Theme, Logout button | [`setting_screen.dart`](file:///d:/hostel_app/lib/ui/screens/setting_screen.dart) |
| **13** | **Admin Login** | Secure Admin Access branded login screen | [`login_screen.dart`](file:///d:/hostel_app/lib/ui/screens/login_screen.dart) |
| **14** | **Admin Dashboard** | 4-grid stat cards (Total Students, Occupied Rooms, Pending Dues, Active Complaints), Quick Entry buttons, Monthly Payment Bar Chart | [`dashboard_screen.dart`](file:///d:/hostel_app/lib/ui/screens/dashboard_screen.dart) |
| **15** | **All Students (Admin)** | Searchable student list with quick delete & view options, "+ Add Student" button | [`student_screen.dart`](file:///d:/hostel_app/lib/ui/screens/student_screen.dart) |
| **16** | **Add / Edit Student** | Photo upload placeholder, form fields (Full Name, Student ID, Phone, Department, Room, Gender), "Save Student" button | [`student_screen.dart`](file:///d:/hostel_app/lib/ui/screens/student_screen.dart) |
| **17** | **All Payments (Admin)**| Search payments, summary card with collected & due amounts, payment list cards, "+ Add Payment" button | [`payment_screen.dart`](file:///d:/hostel_app/lib/ui/screens/payment_screen.dart) |
| **18** | **All Complaints (Admin)**| Filter tabs, complaint cards with quick status toggle | [`complain_screen.dart`](file:///d:/hostel_app/lib/ui/screens/complain_screen.dart) |
| **19** | **Admin Profile** | Admin avatar, Administrator role details, phone, email, Edit Profile button | [`setting_screen.dart`](file:///d:/hostel_app/lib/ui/screens/setting_screen.dart) |
| **20** | **Logout Modal** | Confirmation modal dialog ("Are you sure you want to log out?"), Cancel (outline) & Log Out (danger red) buttons | [`setting_screen.dart`](file:///d:/hostel_app/lib/ui/screens/setting_screen.dart) |

---

## 📌 How to View the Prototype

Open [`ui_prototype.html`](file:///d:/hostel_app/ui_prototype.html) directly in any web browser (Chrome, Edge, etc.) or serve it locally.  
Use the **← Previous** and **Next →** buttons or keyboard arrow keys (**Left/Right/Up/Down**) to navigate smoothly through all 20 screens.
