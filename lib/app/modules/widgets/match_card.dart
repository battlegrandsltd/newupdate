import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/routes/app_pages.dart';

import '../../data/models/game.dart';
import '../../data/models/profile.dart';
import '../../resources/color_manager.dart';
import 'custom_loading.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key, required this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    String result = game.status == 'closed'
        ? game.winner == userController.uid.value
            ? 'Win'
            : 'Lose'
        : game.status;
    return FutureBuilder(
        future: Profile.findPlayers(game.player_1, game.player_2),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CustomLoading(heightFactor: .25, widthFactor: 1);
          }

          return InkWell(
            onTap: () {
              Get.toNamed(Routes.MATCH_DETAIL, arguments: game);
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.1,
                  image: NetworkImage(game.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
                color: ColorManager.lightGrey,
                border: Border.all(
                  color: ColorManager.lightGrey1,
                  width: 1,
                ),
              ),
              width: Get.width * 0.8,
              // height: 160,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    game.name,
                    style: const TextStyle(
                      fontSize: 20,
                      color: ColorManager.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    game.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorManager.black,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                              "assets/images/user avatar (${snapshot.data![0].photo}).png",
                              height: 40,
                              width: 40),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.data![0].name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: ColorManager.black,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: ' vs ',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorManager.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result,
                            style: TextStyle(
                                fontSize: 16,
                                color: result == 'Win'
                                    ? ColorManager.green
                                    : ColorManager.error,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Image.asset(
                              snapshot.data!.length == 1
                                  ? "assets/images/user avatar (1).png"
                                  : "assets/images/user avatar (${snapshot.data![1].photo}).png",
                              height: 40,
                              width: 40),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.data!.length == 1
                                ? "Waiting"
                                : snapshot.data![1].name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: ColorManager.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
