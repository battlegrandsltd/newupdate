import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/payment_gateway_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/modules/Wallet/controllers/wallet_controller.dart';

import '../resources/color_manager.dart';

class TopUpView extends GetView {
  const TopUpView({super.key});

  @override
  Widget build(BuildContext context) {
    WalletController walletController = Get.find();
    RxInt amount = 0.obs;
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            walletController.selectedPage.value = 0;
          },
        ),
        title: const Text(
          'Top Up',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Enter Amount',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(() => Text(
                      'GHS $amount',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                const SizedBox(height: 16),
                SizedBox(
                  width: Get.width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wallet_outlined,
                          color: ColorManager.lightGrey),
                      const Text(
                        'Balance:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Obx(() => Text(
                            'GHS ${walletController.userController.coins.value}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: ColorManager.lightGrey1,
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Mobile Number',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      walletController.userController.phone.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing:
                        const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {},
                  ),
                ),
                // Card(
                //   elevation: 0,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: ListTile(
                //     leading: const CircleAvatar(
                //       backgroundColor: ColorManager.lightGrey1,
                //       child: Padding(
                //         padding: EdgeInsets.all(4.0),
                //         child: Icon(
                //           Icons.phone_android,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //     title: const Text(
                //       'MTN Mobile Money',
                //       style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black,
                //       ),
                //     ),
                //     trailing:
                //         const Icon(Icons.chevron_right, color: Colors.grey),
                //     onTap: () {
                //       _showNetworkProviderSelection(context);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.all(16),
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
                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(12, (index) {
                    if (index == 9) {
                      return Container();
                    } else if (index == 11) {
                      return IconButton(
                        icon: const Icon(Icons.backspace_outlined,
                            color: Colors.black),
                        onPressed: () {
                          amount.value = amount.value ~/ 10;
                        },
                      );
                    } else {
                      return Center(
                        child: TextButton(
                          onPressed: () {
                            if (index == 10) {
                              amount.value = amount.value * 10;
                            } else {
                              amount.value = amount.value * 10 + (index + 1);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            fixedSize: const Size(100, 100),
                          ),
                          child: Text(
                            index == 10 ? '0' : (index + 1).toString(),
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      if (amount.value == 0) {
                        Get.snackbar(
                          'Error',
                          'Please enter an amount to top up',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      _showConfirmationDialog(amount.value);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Top Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _showNetworkProviderSelection(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           ListTile(
  //             // leading:
  //             //     SvgPicture.asset(AssetsManager.mtn, width: 24, height: 24),
  //             title: const Text('MTN Mobile Money'),
  //             onTap: () {
  //               // Handle selection
  //             },
  //           ),
  //           ListTile(
  //             // leading:
  //             //     SvgPicture.asset(AssetsManager.atCash, width: 24, height: 24),
  //             title: const Text('AT Cash'),
  //             onTap: () {
  //               // Handle selection
  //             },
  //           ),
  //           ListTile(
  //             // leading: SvgPicture.asset(AssetsManager.telecel,
  //             //     width: 24, height: 24),
  //             title: const Text('Telecel Cash'),
  //             onTap: () {
  //               // Handle selection
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showConfirmationDialog(int amount) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Top Up'),
          content: Text(
              'You are depositing GHS $amount to your account. This will attract a 5% system fee. Fee: GHS 5 Total: GHS105\n\nMobile money deposit has been initiated on your phone. Please follow instructions on the prompt to complete your top up. If you already done, tap on the "Completed" button to confirm.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () async {
                PaymentGatewayController paymentGatewayController = Get.find();
                UserController userController = Get.find();
                bool result = await paymentGatewayController.payWithPaystack(
                    amount,
                    userController.email.value,
                    userController.name.value,
                    userController.phone.value);
                if (result) {
                  userController.coins.value += amount;
                  amount = 0;
                }
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
