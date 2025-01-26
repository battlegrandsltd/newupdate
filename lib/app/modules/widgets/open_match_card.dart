import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/tournament.dart';
import 'package:playground/app/routes/app_pages.dart';

import '../../data/models/game.dart';
import '../../data/models/profile.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import 'custom_loading.dart';

class OpenMatchCard extends StatelessWidget {
  final Game game;

  const OpenMatchCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return FutureBuilder(
        future: Profile.findUser(game.creator!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CustomLoading(heightFactor: .3, widthFactor: 1);
          }
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(16),
              // boxShadow: const [
              //   BoxShadow(
              //     color: ColorManager.shadow,
              //     blurRadius: 5,
              //     offset: Offset(0, 2),
              //   ),
              // ],
              border:
                  Border.all(color: ColorManager.lightGrey.withOpacity(0.3)),
            ),
            height: Get.height * .3,
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        game.image,
                        width: Get.width * .8,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: Get.width * .8,
                            height: 140,
                            child: const Center(
                              child: Icon(
                                Icons.error,
                                color: ColorManager.error,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            width: Get.width * .8,
                            height: 140,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: ColorManager.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Obx(() => InkWell(
                              onTap: () {
                                if (!userController.gamesBookmarked
                                    .contains(game.id)) {
                                  userController.addGameBookmarked(game.id);
                                } else {
                                  userController.removeGameBookmarked(game.id);
                                }
                              },
                              child: Icon(
                                  userController.gamesBookmarked
                                          .contains(game.id)
                                      ? Icons.bookmark_remove_outlined
                                      : Icons.bookmark_add_outlined,
                                  size: 14,
                                  color: ColorManager.white),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.MATCH_DETAIL, arguments: game);
                    },
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              game.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              game.status,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage: AssetImage(
                                    "assets/images/user avatar (${snapshot.data!.photo}).png",
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  snapshot.data!.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: Get.width * .3,
                                  child: Text(
                                    game.date,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: ColorManager.lightGrey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetsManager.enter,
                                    colorFilter: const ColorFilter.mode(
                                        ColorManager.lightGrey2,
                                        BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    game.amount.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: ColorManager.lightGrey2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class OpenTournamentCard extends StatelessWidget {
  final Tournament tournament;

  const OpenTournamentCard({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        // boxShadow: const [
        //   BoxShadow(
        //     color: ColorManager.shadow,
        //     blurRadius: 5,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      height: Get.height * .3,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  tournament.image,
                  width: Get.width * .8,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      width: Get.width * .8,
                      height: 140,
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: ColorManager.error,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      width: Get.width * .8,
                      height: 140,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorManager.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Obx(() => InkWell(
                        onTap: () {
                          if (!userController.tournamentsBookmarked
                              .contains(tournament.id)) {
                            userController
                                .addTournamentBookmarked(tournament.id);
                          } else {
                            userController
                                .removeTournamentBookmarked(tournament.id);
                          }
                        },
                        child: Icon(
                            userController.tournamentsBookmarked
                                    .contains(tournament.id)
                                ? Icons.bookmark_remove_outlined
                                : Icons.bookmark_add_outlined,
                            size: 14,
                            color: ColorManager.white),
                      )),
                ),
              ),
            ],
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.TOURNAMENT_DETAIL, arguments: tournament);
              },
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tournament.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        tournament.status,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        '${tournament.players.length} players',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: Get.width * .3,
                            child: Text(
                              tournament.date,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: ColorManager.lightGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsManager.enter,
                              colorFilter: const ColorFilter.mode(
                                  ColorManager.lightGrey2, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              tournament.amount.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: ColorManager.lightGrey2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
