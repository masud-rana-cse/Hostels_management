import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/models.dart';
import '../../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class PaymentScreen extends StatefulWidget {
  final bool isAdmin;

  const PaymentScreen({super.key, this.isAdmin = true});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddPaymentSheet(BuildContext context, Color themeColor) {
    final studentCtrl = TextEditingController();
    final roomCtrl = TextEditingController();
    final amountCtrl = TextEditingController(text: '3000');
    final methodCtrl = TextEditingController(text: 'bKash');
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
                      decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Log New Payment Receipt',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                  ),
                  const SizedBox(height: 14),
                  _buildPaymentInput(
                    controller: studentCtrl,
                    label: 'Student Name',
                    hint: 'e.g. Jonaki Akter',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Student name is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentInput(
                    controller: roomCtrl,
                    label: 'Room Number',
                    hint: 'e.g. 301A',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Room is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentInput(
                    controller: amountCtrl,
                    label: 'Amount (৳)',
                    hint: 'e.g. 3000',
                    keyboardType: TextInputType.number,
                    validator: (v) => v == null || v.trim().isEmpty ? 'Amount is required' : null,
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentInput(
                    controller: methodCtrl,
                    label: 'Payment Method',
                    hint: 'e.g. bKash, Nagad, Bank, Cash',
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
                          final newPay = PaymentItem(
                            id: 'pay_${DateTime.now().millisecondsSinceEpoch}',
                            receiptNo: 'RCP-${DateTime.now().millisecond + 9000}',
                            studentName: studentCtrl.text.trim(),
                            room: 'Room ${roomCtrl.text.trim().replaceAll("Room", "").trim()}',
                            amount: double.tryParse(amountCtrl.text.trim()) ?? 3000.0,
                            date: 'Just now',
                            isPaid: true,
                            month: 'April 2025',
                            method: methodCtrl.text.trim(),
                          );
                          Provider.of<AppProvider>(context, listen: false).addPayment(newPay);
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Payment recorded successfully!'), backgroundColor: AppColors.green),
                          );
                        }
                      },
                      child: const Text('Record Payment', style: TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildPaymentInput({
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
    final isAdminMode = widget.isAdmin;

    final sourceList = isAdminMode ? appProvider.payments : appProvider.myPayments;

    final displayPayments = sourceList.where((p) {
      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return p.studentName.toLowerCase().contains(q) ||
          p.receiptNo.toLowerCase().contains(q) ||
          p.room.toLowerCase().contains(q);
    }).toList();

    double totalCollected = 0;
    double totalDue = 0;
    for (var p in sourceList) {
      if (p.isPaid) {
        totalCollected += p.amount;
      } else {
        totalDue += p.amount;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          isAdminMode ? 'Payment Management' : 'My Payment Receipts',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        centerTitle: true,
        actions: isAdminMode
            ? [
                IconButton(
                  icon: Icon(Icons.add_circle_outline_rounded, color: themeColor),
                  tooltip: 'Record Payment',
                  onPressed: () => _showAddPaymentSheet(context, themeColor),
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Summary Card (Collected vs Due)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Paid',
                            style: TextStyle(fontSize: 11, color: AppColors.muted),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '৳${totalCollected.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 36, width: 1, color: AppColors.line),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pending Due',
                              style: TextStyle(fontSize: 11, color: AppColors.muted),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '৳${totalDue.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Container(
                height: 40,
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
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search by student name, room, or receipt...',
                    hintStyle: const TextStyle(fontSize: 11, color: AppColors.muted),
                    prefixIcon: Icon(Icons.search, size: 18, color: themeColor),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 16, color: AppColors.muted),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),

            // Payment List
            Expanded(
              child: displayPayments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.line),
                          SizedBox(height: 8),
                          Text(
                            'No payment receipts found',
                            style: TextStyle(fontSize: 13, color: AppColors.muted),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      itemCount: displayPayments.length,
                      itemBuilder: (context, index) {
                        final item = displayPayments[index];
                        final isPaid = item.isPaid;

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
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: isPaid ? const Color(0xFFDFF8EB) : const Color(0xFFFFF0D8),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPaid ? Icons.check_circle_outline : Icons.pending_outlined,
                                  color: isPaid ? AppColors.green : AppColors.orange,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.receiptNo,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.navy,
                                          ),
                                        ),
                                        Text(
                                          '৳${item.amount.toStringAsFixed(0)}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.studentName} · ${item.room}',
                                      style: const TextStyle(fontSize: 11, color: AppColors.muted),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${item.date} · via ${item.method}',
                                      style: const TextStyle(fontSize: 10, color: AppColors.muted),
                                    ),
                                  ],
                                ),
                              ),

                              // If Admin: toggle status & delete
                              if (isAdminMode) ...[
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    appProvider.togglePaymentStatus(item.id);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isPaid
                                          ? AppColors.green.withValues(alpha: 0.1)
                                          : AppColors.orange.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      isPaid ? 'PAID' : 'DUE',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: isPaid ? AppColors.green : AppColors.orange,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.red),
                                  onPressed: () {
                                    appProvider.deletePayment(item.id);
                                  },
                                ),
                              ] else ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isPaid ? const Color(0xFFDFF8EB) : const Color(0xFFFFF0D8),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    isPaid ? 'PAID' : 'DUE',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: isPaid ? AppColors.green : AppColors.orange,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
