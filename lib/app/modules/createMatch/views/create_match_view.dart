import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/top_games_controller.dart';
import 'package:playground/app/modules/widgets/custom_dialog.dart';
import 'package:playground/app/resources/color_manager.dart';
import '../../../routes/app_pages.dart';
import '../controllers/create_match_controller.dart';

class CreateMatchView extends StatelessWidget {
  const CreateMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    CreateMatchController controller = Get.put(CreateMatchController());
    var selectedGame = ''.obs;
    var selectedGameImage = ''.obs;
    var selectedPlatform = ''.obs;
    TextEditingController aboutMatchController = TextEditingController();
    TextEditingController rulesController = TextEditingController();
    TextEditingController amountController = TextEditingController(text: '0.0');
    TopGamesController topGamesController = Get.find<TopGamesController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: ColorManager.background1,
        appBar: AppBar(
          backgroundColor: ColorManager.background1,
          title: const Text('Create Match',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (controller.filled.value) {
                controller.filled.value = false;
                return;
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: Form(
          key: formKey,
          child: Container(
            margin: const EdgeInsets.all(16),
            width: Get.width,
            height: Get.height * .85,
            child: Obx(() => ListView(
                  children: !controller.filled.value
                      ? [
                          const Row(
                            children: [
                              Text(
                                'Match Information',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  dropdownColor: ColorManager.background1,
                                  borderRadius: BorderRadius.circular(8.0),
                                  elevation: 0,
                                  decoration: InputDecoration(
                                    labelText: 'Game',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  items: topGamesController.topGames
                                      .map((game) => DropdownMenuItem(
                                            value: game.name,
                                            child: Text(game.name),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    selectedGame.value = value.toString();
                                    selectedGameImage.value = topGamesController
                                        .topGames
                                        .firstWhere(
                                            (game) => game.name == value)
                                        .banner;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a game';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField(
                                  dropdownColor: ColorManager.background1,
                                  borderRadius: BorderRadius.circular(8.0),
                                  elevation: 0,
                                  decoration: InputDecoration(
                                    labelText: 'Platform',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Mobile',
                                      child: Text('Mobile'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'XBox',
                                      child: Text('XBox'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    selectedPlatform.value = value.toString();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a platform';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: aboutMatchController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    labelText: 'About Match',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide details about the match';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: rulesController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    labelText: 'Rules',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please provide the rules';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Amount deducted from each player',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the amount';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 32),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  fixedSize: Size(Get.width * .8, 50),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.filled.value = true;
                                  }
                                },
                                child: const Text('Confirm'),
                              ),
                            ),
                          ),
                        ]
                      : [
                          const Text(
                            'Your match has been created successfully.',
                            style: TextStyle(
                              color: ColorManager.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text.rich(
                            textAlign: TextAlign.start,
                            TextSpan(
                              text: 'About\n',
                              style: const TextStyle(
                                color: ColorManager.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: aboutMatchController.text,
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: "\n\nRules\n"),
                                TextSpan(
                                  text: rulesController.text,
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(
                                    text:
                                        "\n\nAmount deducted from each player\n"),
                                TextSpan(
                                  text: 'GHS ${amountController.text}',
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: "\n\nTotal Win Prize\n"),
                                TextSpan(
                                  text:
                                      'GHS ${(double.parse(amountController.text) * 2).toString()}',
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: "\n\nGame\n"),
                                TextSpan(
                                  text: selectedGame.value,
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: "\n\nPlatform\n"),
                                TextSpan(
                                  text: selectedPlatform.value,
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              fixedSize: Size(Get.width * .8, 50),
                            ),
                            onPressed: () async {
                              if (controller.userController.coins.value <
                                  double.parse(amountController.text)) {
                                customDialog(
                                    'Insufficient Coins',
                                    'You do not have enough coins to create this match: ${controller.userController.coins.value}/${amountController.text} GHS',
                                    'Okay',
                                    null, () {
                                  Get.back();
                                }, () {});
                              } else if (formKey.currentState!.validate()) {
                                customDialog(
                                    'Confirm Match',
                                    'Are you sure you want to create this match? You will be deducted ${amountController.text} GHS',
                                    'Yes',
                                    'No', () async {
                                  await controller.addGame(
                                    selectedGame.value,
                                    selectedPlatform.value,
                                    aboutMatchController.text,
                                    rulesController.text,
                                    amountController.text,
                                    selectedGameImage.value,
                                  );
                                  Get.back();
                                  controller.filled.value = false;
                                  customDialog(
                                      'Match Created',
                                      'Your match has been created successfully. ',
                                      'Okay',
                                      null, () {
                                    Get.offAndToNamed(Routes.MAIN);
                                  }, () {});
                                }, () {
                                  Get.back();
                                });
                              }
                            },
                            child: const Text('Post'),
                          ),
                        ],
                )),
          ),
        ));
  }
}

  
  // Widget buildPage1(CreateMatchController controller) {
  //   return Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Obx(
  //         () => Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Row(
  //               children: [
  //                 CircleAvatar(
  //                   radius: 14,
  //                   backgroundColor: ColorManager.lightGrey,
  //                   child: Text(
  //                     '1',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(width: 8),
  //                 Text(
  //                   'Choose a Tournament type',
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 20),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: RadioListTile(
  //                 tileColor: controller.selectedTournamentType.value == 'League'
  //                     ? ColorManager.primary.withOpacity(.2)
  //                     : Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //                 title: const Text(
  //                   'League',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 subtitle: const Text(
  //                   'Competitors are ranked on a table based on total number of points or average points earned per fixture.',
  //                   style: TextStyle(color: ColorManager.lightGrey3),
  //                 ),
  //                 value: 'League',
  //                 groupValue: controller.selectedTournamentType.value,
  //                 onChanged: (value) {
  //                   controller.selectedTournamentType.value = value!;
  //                 },
  //                 activeColor: ColorManager.primary,
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: RadioListTile(
  //                 tileColor:
  //                     controller.selectedTournamentType.value == 'Knock-out'
  //                         ? ColorManager.primary.withOpacity(.2)
  //                         : Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //                 title: const Text(
  //                   'Knock-out',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 subtitle: const Text(
  //                   'Competitors play in successive rounds, winner progresses to the next round and the final round determines the winner.',
  //                   style: TextStyle(color: ColorManager.lightGrey3),
  //                 ),
  //                 value: 'Knock-out',
  //                 groupValue: controller.selectedTournamentType.value,
  //                 onChanged: (value) {
  //                   controller.selectedTournamentType.value = value!;
  //                 },
  //                 activeColor: ColorManager.primary,
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: RadioListTile(
  //                 tileColor:
  //                     controller.selectedTournamentType.value == 'Multi-Stage'
  //                         ? ColorManager.primary.withOpacity(.2)
  //                         : Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //                 title: const Text(
  //                   'Multi-Stage',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 subtitle: const Text(
  //                   'Competitors are matched in group stages and qualifiers from each group progress into Knockout stage.',
  //                   style: TextStyle(color: ColorManager.lightGrey3),
  //                 ),
  //                 value: 'Multi-Stage',
  //                 groupValue: controller.selectedTournamentType.value,
  //                 onChanged: (value) {
  //                   controller.selectedTournamentType.value = value!;
  //                 },
  //                 activeColor: ColorManager.primary,
  //               ),
  //             ),
  //             const Spacer(),
  //             const NextButton(),
  //           ],
  //         ),
  //       ));
  // }

  // Widget buildPage2(CreateMatchController controller) {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(16.0),
  //     child: SizedBox(
  //       width: Get.width,
  //       height: Get.height * .85,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const Row(
  //             children: [
  //               CircleAvatar(
  //                 radius: 14,
  //                 backgroundColor: ColorManager.lightGrey,
  //                 child: Text(
  //                   '2',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 8),
  //               Text(
  //                 'Tournament Information',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //               ),
  //             ],
  //           ),
  //           ElevatedButton.icon(
  //             onPressed: () {},
  //             icon:
  //                 const Icon(Icons.camera_alt, color: ColorManager.lightGrey3),
  //             label: const Text('Add banner',
  //                 style: TextStyle(color: ColorManager.lightGrey3)),
  //             style: ElevatedButton.styleFrom(
  //               foregroundColor: ColorManager.black,
  //               backgroundColor: ColorManager.lightGrey1,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               fixedSize: Size(Get.width * .5, 40),
  //             ),
  //           ),
  //           const SizedBox(height: 8),
  //           Container(
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: ColorManager.white,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Tournament Name',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 DropdownButtonFormField(
  //                   dropdownColor: ColorManager.background1,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   elevation: 0,
  //                   decoration: InputDecoration(
  //                     labelText: 'Game',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'Garena Free Fire',
  //                       child: Text('Garena Free Fire'),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'PUBG Mobile',
  //                       child: Text('PUBG Mobile'),
  //                     )
  //                   ],
  //                   onChanged: (value) {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 DropdownButtonFormField(
  //                   dropdownColor: ColorManager.background1,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   elevation: 0,
  //                   decoration: InputDecoration(
  //                     labelText: 'Platform',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'Mobile',
  //                       child: Text('Mobile'),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'XBox',
  //                       child: Text('XBox'),
  //                     ),
  //                   ],
  //                   onChanged: (value) {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   maxLines: 3,
  //                   decoration: InputDecoration(
  //                     labelText: 'Tournament Description',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Tournament Start Date',
  //                     suffixIcon: const Icon(Icons.calendar_today,
  //                         color: ColorManager.lightGrey),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   onTap: () {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 DropdownButtonFormField(
  //                   dropdownColor: ColorManager.background1,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   elevation: 0,
  //                   decoration: InputDecoration(
  //                     labelText: 'Region',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'Global',
  //                       child: Text('Global'),
  //                     ),
  //                   ],
  //                   onChanged: (value) {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 DropdownButtonFormField(
  //                   dropdownColor: ColorManager.background1,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   elevation: 0,
  //                   decoration: InputDecoration(
  //                     labelText: 'Organizer',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'Snazzy Entertainment',
  //                       child: Text('Snazzy Entertainment'),
  //                     ),
  //                   ],
  //                   onChanged: (value) {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Tournament URL',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Spacer(),
  //           const NextButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildPage3(CreateMatchController controller) {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(16.0),
  //     child: SizedBox(
  //       width: Get.width,
  //       height: Get.height * .85,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const Row(
  //             children: [
  //               CircleAvatar(
  //                 radius: 14,
  //                 backgroundColor: ColorManager.lightGrey,
  //                 child: Text(
  //                   '3',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 8),
  //               Text(
  //                 'Entry Settings',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 8),
  //           Container(
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: ColorManager.white,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Column(
  //               children: [
  //                 DropdownButtonFormField(
  //                   dropdownColor: ColorManager.background1,
  //                   borderRadius: BorderRadius.circular(8.0),
  //                   elevation: 0,
  //                   decoration: InputDecoration(
  //                     labelText: 'Entry Type',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   items: const [
  //                     DropdownMenuItem(
  //                       value: 'Free',
  //                       child: Text('Free'),
  //                     ),
  //                     DropdownMenuItem(
  //                       value: 'Paid',
  //                       child: Text('Paid'),
  //                     )
  //                   ],
  //                   onChanged: (value) {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   maxLines: 3,
  //                   decoration: InputDecoration(
  //                     labelText: 'Entry Fee',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   maxLines: 3,
  //                   decoration: InputDecoration(
  //                     labelText: 'CashOut Prize',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Registration Start Date',
  //                     suffixIcon: const Icon(Icons.calendar_today,
  //                         color: ColorManager.lightGrey),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   onTap: () {},
  //                 ),
  //                 const SizedBox(height: 8),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     labelText: 'Registration End Date',
  //                     suffixIcon: const Icon(Icons.calendar_today,
  //                         color: ColorManager.lightGrey),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                     ),
  //                   ),
  //                   onTap: () {},
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Spacer(),
  //           const NextButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildPage4(CreateMatchController controller) {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(16.0),
  //     child: SizedBox(
  //       width: Get.width,
  //       height: Get.height * 1.15,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Row(
  //             children: [
  //               CircleAvatar(
  //                 radius: 14,
  //                 backgroundColor: ColorManager.lightGrey,
  //                 child: Text(
  //                   '4',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 8),
  //               Text(
  //                 'League Settings',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           Container(
  //             padding: const EdgeInsets.all(16),
  //             decoration: BoxDecoration(
  //               color: ColorManager.white,
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 buildSettingRow('Rounds', 2, controller),
  //                 buildSettingRow('Points for Wins', 3, controller),
  //                 buildSettingRow('Points for Ties', 1, controller),
  //                 buildSettingRow('Points for Losses', 0, controller),
  //                 const Divider(color: ColorManager.lightGrey),
  //                 const SizedBox(height: 16),
  //                 const Row(
  //                   children: [
  //                     Text(
  //                       'League Schedule',
  //                       style: TextStyle(
  //                         color: ColorManager.black,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     Spacer(),
  //                     Icon(Icons.arrow_forward_ios, size: 20),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           const Row(
  //             children: [
  //               CircleAvatar(
  //                 radius: 14,
  //                 backgroundColor: ColorManager.lightGrey,
  //                 child: Text(
  //                   '5',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 8),
  //               Text(
  //                 'Participants Settings',
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           Obx(
  //             () => Container(
  //               padding: const EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 color: ColorManager.white,
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   RadioListTile(
  //                     title: const Text('Team'),
  //                     subtitle: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         buildSettingRow(
  //                             'Max. Number of Teams', 32, controller),
  //                         buildSettingRow('Max. Number of players per team', 10,
  //                             controller),
  //                         const Row(
  //                           children: [
  //                             Text('One team per user'),
  //                             Spacer(),
  //                             Checkbox(
  //                                 value: true,
  //                                 onChanged:
  //                                     null), // Replace with actual checkbox state
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     value: 'Team',
  //                     groupValue: controller.participantType.value,
  //                     onChanged: (value) {
  //                       controller.participantType.value = value.toString();
  //                     },
  //                     activeColor: ColorManager.primary,
  //                   ),
  //                   RadioListTile(
  //                     title: const Text('Single player'),
  //                     subtitle: buildSettingRow(
  //                         'Max. Number of Players', 100, controller),
  //                     value: 'Single player',
  //                     groupValue: controller.participantType.value,
  //                     onChanged: (value) {
  //                       controller.participantType.value = value.toString();
  //                     },
  //                     activeColor: ColorManager.primary,
  //                   ),
  //                   const Divider(color: ColorManager.lightGrey),
  //                   const SizedBox(height: 16),
  //                   const Text('Blacklist',
  //                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                   const SizedBox(height: 16),
  //                   GestureDetector(
  //                     onTap: () {
  //                       // Navigate to Add Team or User to Blacklist
  //                     },
  //                     child: const Row(
  //                       children: [
  //                         Icon(Icons.person_add_outlined,
  //                             color: ColorManager.primary),
  //                         SizedBox(width: 8),
  //                         Text(
  //                           'Add Team or User',
  //                           style: TextStyle(
  //                             color: ColorManager.primary,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const Spacer(),
  //           const NextButton(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildPage5(CreateMatchController controller) {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text("Add Rules",
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
  //         const SizedBox(height: 16),
  //         Expanded(
  //           child: Container(
  //             padding: const EdgeInsets.all(16.0),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(16),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.2),
  //                   spreadRadius: 2,
  //                   blurRadius: 5,
  //                 ),
  //               ],
  //             ),
  //             child: TextFormField(
  //               maxLines: null, // Allows for multiline input
  //               keyboardType: TextInputType.multiline,
  //               decoration: const InputDecoration(
  //                 hintText: 'Type tournament rules',
  //                 border: InputBorder.none,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         const Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Icon(Icons.format_bold, color: ColorManager.lightGrey3),
  //             Icon(Icons.format_italic, color: ColorManager.lightGrey3),
  //             Icon(Icons.format_list_bulleted, color: ColorManager.lightGrey3),
  //             Icon(Icons.format_quote, color: ColorManager.lightGrey3),
  //           ],
  //         ),
  //         const Spacer(),
  //         const NextButton(),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildSettingRow(
  //     String title, int initialValue, CreateMatchController controller) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       children: [
  //         Expanded(child: Text(title)),
  //         IconButton(
  //           style: ButtonStyle(
  //             backgroundColor:
  //                 WidgetStateProperty.all(ColorManager.transparent),
  //           ),
  //           icon: const Icon(Icons.remove_circle_outline),
  //           onPressed: () {
  //             // Logic to decrease value
  //           },
  //         ),
  //         Text(initialValue.toString()),
  //         IconButton(
  //           style: ButtonStyle(
  //             backgroundColor:
  //                 WidgetStateProperty.all(ColorManager.transparent),
  //           ),
  //           icon: const Icon(Icons.add_circle_outline),
  //           onPressed: () {
  //             // Logic to increase value
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
// }

// class NextButton extends StatelessWidget {
//   const NextButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CreateMatchController controller = Get.find();
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: ColorManager.primary,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             fixedSize: Size(Get.width * .8, 50),
//           ),
//           onPressed: () {
//             if (controller.currentPage.value == 4) {
//               Get.back();
//               return;
//             }
//             controller.currentPage.value++;
//           },
//           child: const Text('Continue'),
//         ),
//       ),
//     );
//   }
// }
