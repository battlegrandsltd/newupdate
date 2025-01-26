import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/color_manager.dart';

class ManagePaymentsView extends GetView {
  const ManagePaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Manage Payments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: ColorManager.primary),
            onPressed: () {
              // Handle add payment method
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            PaymentMethodItem(
              accountType: 'Personal Account',
              accountNumber: '0553904021',
              bankName: 'GTBank',
            ),
            PaymentMethodItem(
              accountType: 'Business Account',
              accountNumber: '3230034020',
              bankName: 'First Bank',
            ),
            PaymentMethodItem(
              accountType: 'Family Account',
              accountNumber: '3230034020',
              bankName: 'AccessBank',
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  final String accountType;
  final String accountNumber;
  final String bankName;

  const PaymentMethodItem({
    super.key,
    required this.accountType,
    required this.accountNumber,
    required this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: ColorManager.background2,
          child:
              Icon(Icons.account_balance_wallet, color: ColorManager.primary),
        ),
        title: Text(
          accountType,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '$accountNumber - $bankName',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Handle payment method tap
        },
      ),
    );
  }
}
