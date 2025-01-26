import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/views/add_new_card_view.dart';
import 'package:playground/app/views/withdraw_view.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../views/top_up_view.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.selectedPage.value == 0
        ? const Wallet()
        : controller.selectedPage.value == 1
            ? const TopUpView()
            : controller.selectedPage.value == 2
                ? WithdrawView()
                : const AddNewCardView());
  }
}

class Wallet extends StatelessWidget {
  const Wallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WalletController controller = Get.find<WalletController>();
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
          'Wallet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: ColorManager.lightGrey1,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 80,
            height: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              dropdownColor: ColorManager.background1,
              focusColor: ColorManager.lightGrey1,
              borderRadius: BorderRadius.circular(8),
              value: 'GHS',
              items: <String>['GHS', 'USD', 'EUR'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle currency change
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.9,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Your Balance',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Text(
                          'GHS ${controller.userController.coins.value}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )),
                    const SizedBox(height: 16),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SizedBox(
                    //       width: Get.width * 0.45,
                    //       child: OutlinedButton(
                    //         style: OutlinedButton.styleFrom(
                    //           foregroundColor: Colors.black,
                    //           backgroundColor: ColorManager.lightGrey1,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //           side: const BorderSide(color: Colors.transparent),
                    //         ),
                    //         onPressed: () {
                    //           // Handle earnings stats
                    //         },
                    //         child: Row(
                    //           children: [
                    //             SvgPicture.asset(
                    //               AssetsManager.graph,
                    //               height: 20,
                    //               width: 20,
                    //             ),
                    //             const Spacer(),
                    //             const Text(
                    //               'Earnings Stats',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 color: Colors.black,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectedPage.value = 1;
                          },
                          child: SvgPicture.asset(
                            AssetsManager.topUp,
                            height: 70,
                            width: 70,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.selectedPage.value = 2;
                          },
                          child: SvgPicture.asset(
                            AssetsManager.withdraw,
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                height: Get.height * 0.65,
                width: Get.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 80,
                          decoration: BoxDecoration(
                            color: ColorManager.lightGrey1,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Activity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Handle see all
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorManager.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        children: const [
                          // WalletActivityItem(
                          //   type: 'Entry Fee',
                          //   amount: 'GHS 25',
                          //   date: 'Jul 23',
                          //   description: 'FOA - Snipers only',
                          //   isIncome: false,
                          // ),
                          // WalletActivityItem(
                          //   type: 'Cash Transfer',
                          //   amount: 'GHS 100',
                          //   date: 'Jun 18',
                          //   description: 'ElenaXR',
                          //   isIncome: true,
                          // ),
                          // WalletActivityItem(
                          //   type: 'Entry Fee',
                          //   amount: 'GHS 55',
                          //   date: 'Jun 18',
                          //   description: 'Brawl Stars : Battle Cry',
                          //   isIncome: false,
                          // ),
                          // WalletActivityItem(
                          //   type: 'Cash Prize',
                          //   amount: 'GHS 15,250',
                          //   date: 'Jun 16',
                          //   description: 'COD: Warzone Tournament',
                          //   isIncome: true,
                          // ),
                          // WalletActivityItem(
                          //   type: 'Cash Prize',
                          //   amount: 'GHS 32,500',
                          //   date: 'Jun 12',
                          //   description: 'PES 2021 English Tournament',
                          //   isIncome: true,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletActivityItem extends StatelessWidget {
  final String type;
  final String amount;
  final String date;
  final String description;
  final bool isIncome;

  const WalletActivityItem({
    super.key,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Icon(
          //   isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          //   color: isIncome ? Colors.green : Colors.red,
          // ),
          SvgPicture.asset(
            !isIncome ? AssetsManager.debit : AssetsManager.credit,
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
