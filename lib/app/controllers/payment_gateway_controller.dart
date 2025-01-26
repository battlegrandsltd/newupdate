import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:playground/app/controllers/user_controller.dart';

/*class PaymentGatewayController extends GetxController {
  final String secretKey = dotenv.env['TSK']!;
  final String publicKey = dotenv.env['TPK']!;

  Future<bool> payWithPaystack(
      int amount, String email, String name, String phone) async {
    final uniqueTransRef = PayWithPayStack().generateUuidV4();
    await PayWithPayStack().now(
        context: Get.context!,
        secretKey: secretKey,
        customerEmail: email,
        reference: uniqueTransRef,
        callbackUrl: "setup in your paystack dashboard",
        currency: "GHS",
        // paymentChannel: ["mobile_money", "card"],
        amount: double.parse(amount.toString()),
        metaData: {
          "data": [
            {"name": name, "phone": phone}
          ]
        },
        transactionCompleted: () async {
          debugPrint('-----Transaction Completed----');
          Get.snackbar(
            'Success',
            'Transaction Successful!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          await Future.delayed(const Duration(seconds: 2), () {
            Get.back();
          });
          return true;
        },
        transactionNotCompleted: () async {
          debugPrint('-----Transaction Not Completed----');
          Get.snackbar(
            'Error',
            'Transaction Failed!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          await Future.delayed(const Duration(seconds: 2), () {
            Get.back();
          });
          return false;
        });
    return false;
  }
}
 */

class PaymentGatewayController extends GetxController {
  final String secretKey = dotenv.env['TSK']!;
  final Uuid uuid = Uuid();
  Future<bool> payWithPaystack(
      int amount, String email, String name, String phone) async {
    final uniqueTransRef = PayWithPayStack().generateUuidV4();
    bool isSuccess = false;

    debugPrint('---Starting payment with Paystack---');

    try {
      await PayWithPayStack().now(
        context: Get.context!,
        secretKey: secretKey,
        customerEmail: email,
        reference: uniqueTransRef,
        callbackUrl: "https://battleground-wp3e.onrender.com",
        currency: "GHS",
        amount: amount.toDouble(),
        metaData: {
          "data": [
            {"name": name, "phone": phone}
          ]
        },
        transactionCompleted: () async {
          debugPrint('---Transaction Completed---');

          await Future.delayed(const Duration(seconds: 1));

          if (Get.context != null) {
            Get.snackbar(
              'Success',
              'Transaction Successful!',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          }

          isSuccess = true;
        },
        transactionNotCompleted: () async {
          debugPrint('---Transaction Failed---');

          if (Get.context != null) {
            Get.snackbar(
              'Error',
              'Transaction Failed!',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }

          isSuccess = false;
        },
      );
    } catch (e) {
      debugPrint('---Error in payment: $e---');
      isSuccess = false;

      // Show an error snackbar
      if (Get.context != null) {
        Get.snackbar(
          'Error',
          'Something went wrong during payment!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return isSuccess;
  }

  /* Future<String?> createTransferRecipient({
    required String name,
    required String mobileNumber,
    required String email,
  }) async {
    final url = Uri.parse("https://api.paystack.co/transferrecipient");
    final headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "type": "mobile_money", // Specify the type as mobile money
      "name": name,
      "account_number":
          mobileNumber, // For mobile money, this is the phone number
      "bank_code":
          "MTN", // Specify the network provider here (e.g., MTN, Vodafone)
      "currency": "GHS",
      "email": email,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['recipient_code']; // Returns recipient code
      } else {
        throw Exception("Failed to create recipient: ${response.body}");
      }
    } catch (error) {
      debugPrint("Error creating recipient: $error");
      return null;
    }
  }

  Future<bool> withdrawToMobileMoney({
    required int amount,
    required String recipientCode,
    required String reason,
  }) async {
    final url = Uri.parse("https://api.paystack.co/transfer");

    // Generate a unique reference
    String uniqueReference = uuid.v4();

    final headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "source": "balance",
      "amount": amount,
      "reference": uniqueReference,
      "recipient": recipientCode,
      "reason": reason,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          Get.snackbar(
            'Withdrawal Successful',
            'Funds have been sent to $recipientCode',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          return true;
        } else {
          Get.snackbar(
            'Withdrawal Failed',
            'Error: ${data['message']}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }
      } else {
        throw Exception(
            'Failed to process withdrawal, Status Code: ${response.statusCode}');
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  } */

  // Step 1: Create a Transfer Recipient
  Future<String?> createRecipient(String name, String accountNumber) async {
    final url = Uri.parse("https://api.paystack.co/transferrecipient");
    final headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "type": "mobile_money",
      "name": name,
      "account_number": accountNumber,
      "bank_code": "MTN",
      "currency": "GHS"
    });

    try {
      print("Sending request to create recipient..."); // Debugging log
      final response = await http.post(url, headers: headers, body: body);
      print("Response received: ${response.body}"); // Log full response

      final data = jsonDecode(response.body);

      if (/* response.statusCode == 200 || */ data['status'] == true) {
        Get.snackbar(
          'Success',
          'Recipient created successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return data['data']['recipient_code'];
      } else {
        print("Recipient creation failed: ${data['message']}"); // Debugging log
        Get.snackbar(
          'Error',
          'Failed to create recipient: ${data['message']}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }
    } catch (error) {
      print("/* Exception occurred: $error */"); // Log the error
      /*  Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      ); */
      return null;
    }
  }

  // Step 2: Initiate Transfer
  Future<bool> initiateTransfer(String recipientCode, int amount) async {
    final url = Uri.parse("https://api.paystack.co/transfer");
    final headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "source": "balance",
      "amount": amount,
      "reference":
          DateTime.now().millisecondsSinceEpoch.toString(), // Unique reference
      "recipient": recipientCode,
      "reason": "Withdrawal",
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar(
            'Withdrawal Successful', 'Funds have been sent successfully.');
        return true;
      } else {
        Get.snackbar('Transfer Failed', 'Error: ${data['message']}');
        return false;
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return false;
    }
  }
}
