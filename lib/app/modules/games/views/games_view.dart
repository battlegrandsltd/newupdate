import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/modules/widgets/custom_search_field.dart';

import '../../../controllers/games_controller.dart';
import '../../../resources/color_manager.dart';
import 'package:playground/app/controllers/games_controller.dart' as gc;
import '../../widgets/match_card.dart';

class GamesView extends GetView<GamesController> {
  const GamesView({super.key});
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    RxString search = ''.obs;
    return Scaffold(
        backgroundColor: ColorManager.background1,
        appBar: AppBar(
          backgroundColor: ColorManager.background1,
          title: const Text('Games',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all(ColorManager.transparent),
            ),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(ColorManager.lightGrey1),
              ),
              icon: const Icon(Icons.more_horiz_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomSearchField(
                  search: search,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'You have played ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorManager.lightGrey,
                        ),
                        children: [
                          TextSpan(
                            text: userController.gamesPlayed.length.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: ColorManager.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text: ' games.',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorManager.lightGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        color: ColorManager.background1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              child: Text('Recent',
                                  style: TextStyle(
                                      color: ColorManager.lightGrey2)),
                            ),
                            const PopupMenuItem(
                              child: Text('Low to High',
                                  style: TextStyle(
                                      color: ColorManager.lightGrey2)),
                            ),
                            const PopupMenuItem(
                              child: Text('High to Low',
                                  style: TextStyle(
                                      color: ColorManager.lightGrey2)),
                            ),
                          ];
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Recent',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorManager.lightGrey2,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: ColorManager.lightGrey2,
                            ),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(userController.gamesCreated.length,
                        (index) {
                      gc.GamesController gamesController =
                          Get.find<gc.GamesController>();
                      var game = gamesController
                          .findGame(userController.gamesCreated[index]);
                      return game == null
                          ? const SizedBox()
                          : MatchCard(
                              game: game,
                            );
                    }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
