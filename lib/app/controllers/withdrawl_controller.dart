import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart'; // Ensure you have the uuid package added in pubspec.yaml

class PaymentGatewayControllers {
  final String secretKey =
      dotenv.env['TSK']!; // Replace with your actual secret key

  // Generate a unique reference using UUID
  String generateUniqueReference() {
    return Uuid().v4(); // Generates a v4 UUID
  }

  // Step 1: Create Transfer Recipient
  Future<String?> createRecipient(String name, String mobileNumber) async {
    final url = Uri.parse("https://api.paystack.co/transferrecipient");
    final headers = {
      "Authorization": "Bearer $secretKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "type": "mobilemoneyghana",
      "name": name,
      "mobile_number": mobileNumber,
      "email": "", // Optional if not provided
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Response Status Code: ${response.statusCode}'); // Log status code
      print('Response Body: ${response.body}'); // Log response body

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) {
          return data['data']['recipient_code']; // Return the recipient code
        } else {
          Get.snackbar(
              'Error', 'Failed to create recipient: ${data['message']}');
          return null;
        }
      } else {
        Get.snackbar('Error', 'Failed to create recipient: ${response.body}');
        return null;
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return null;
    }
  }

  // Step 2: Withdraw to Mobile Money (Initiate Transfer)
  Future<bool> withdrawToMobileMoney({
    required int amount,
    required String
        recipientCode, // recipient code from createTransferRecipient
    required String reason,
  }) async {
    String uniqueReference = generateUniqueReference();
    final url = Uri.parse("https://api.paystack.co/transfer");

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
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == true) {
        Get.snackbar(
          'Withdrawal Initiated',
          'Funds sent to $recipientCode',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        Get.snackbar(
          'Transfer Failed',
          'Error: ${data['message']}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
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
  }
}
