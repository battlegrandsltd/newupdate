import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/modules/Settings/controllers/settings_controller.dart';
import 'package:intl/intl.dart';

import '../resources/color_manager.dart';

class PersonalInformationView extends GetView {
  const PersonalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find();
    UserController userController = Get.find();
    RxString gender = userController.gender.value.obs;
    RxString dob = userController.dob.value.obs;
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            controller.selectedPage.value = 1;
          },
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: Get.width - 32,
          height: Get.height - 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your personal Information are your private details you provided during sign up and won’t be part of your public Information. Please provide your correct details',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorManager.background2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: TextEditingController(
                          text: userController.email.value),
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      controller: TextEditingController(
                          text: userController.phone.value),
                      enabled: false,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: ColorManager.background2,
                        textTheme: Theme.of(context).textTheme.copyWith(
                              titleMedium: const TextStyle(
                                color: ColorManager.lightGrey2,
                                fontSize: 16,
                              ),
                            ),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: gender.value,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: InputBorder.none,
                        ),
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) {
                          gender.value = value ?? "Male";
                        },
                      ),
                    ),
                    Obx(() => ListTile(
                          title: const Text(
                            'Date of Birth',
                            style: TextStyle(
                              color: ColorManager.lightGrey2,
                              fontSize: 12,
                            ),
                          ),
                          subtitle: Text(dob.value,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          trailing: const Icon(
                            Icons.calendar_today,
                            color: ColorManager.lightGrey2,
                          ),
                          contentPadding: EdgeInsets.zero,
                          onTap: () async {
                            var format = DateFormat('yyyy-MM-dd');
                            await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    initialDate: DateTime.now())
                                .then((value) {
                              if (value != null) {
                                dob.value = format.format(value);
                              }
                            });
                          },
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  userController.dob.value = dob.value;
                  userController.gender.value = gender.value;
                  await userController.updateProfile();
                  controller.selectedPage.value = 1;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save Changes',
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
