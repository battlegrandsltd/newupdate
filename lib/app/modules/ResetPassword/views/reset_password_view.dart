import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/color_manager.dart';
import '../../../routes/app_pages.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

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
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: Get.height - 56,
          width: Get.width - 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please enter your email below to receive your password reset instructions.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorManager.background2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(() => Column(
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Reset Code',
                            border: InputBorder.none,
                          ),
                        ),
                        TextField(
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                              labelText: 'New Password',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.isPasswordHidden.toggle(),
                                icon: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ColorManager.lightGrey,
                                ),
                              )),
                        ),
                        TextField(
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.isPasswordHidden.toggle(),
                                icon: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ColorManager.lightGrey,
                                ),
                              )),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
