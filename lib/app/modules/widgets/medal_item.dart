import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';

class MedalItem extends StatelessWidget {
  const MedalItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.xp,
  });
  final String title;
  final String description;
  final String icon;
  final String xp;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        ConfettiController confettiController = ConfettiController(
          duration: const Duration(seconds: 5),
        );
        confettiController.play();
        await Get.dialog(
          AlertDialog(
            icon: Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: true,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      icon,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: ColorManager.background1,
            content: SizedBox(
              height: 60,
              child: Column(
                children: [
                  const Text("Congratulations!",
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'You have earned ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorManager.lightGrey,
                      ),
                      children: [
                        TextSpan(
                          text: xp,
                          style: const TextStyle(
                            fontSize: 16,
                            color: ColorManager.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: ' XP.',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorManager.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width, 40),
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        );
        confettiController.stop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    icon,
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorManager.lightGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              color: ColorManager.lightGrey1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
