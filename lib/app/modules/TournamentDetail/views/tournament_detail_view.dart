import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/round_controller.dart';
import 'package:playground/app/data/models/profile.dart';
import 'package:playground/app/modules/TournamentDetail/controllers/tournament_detail_controller.dart';
import 'package:playground/app/modules/widgets/custom_dialog.dart';
import 'package:playground/app/resources/assets_manager.dart';
import 'package:playground/app/routes/app_pages.dart';
import '../../../resources/color_manager.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/match_card.dart';

class TournamentDetailView extends GetView<TournamentDetailController> {
  const TournamentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    RoundController roundController = Get.find<RoundController>();
    return Scaffold(
      backgroundColor: ColorManager.background1,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: FutureBuilder(
          future: controller.fetchTournament(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                children: [
                  SizedBox(height: Get.width * 0.2),
                  const CustomLoading(heightFactor: .3, widthFactor: .8),
                  SizedBox(height: Get.width * 0.05),
                  const CustomLoading(heightFactor: .4, widthFactor: .8),
                ],
              ));
            }
            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        controller.tournament.value.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    height: Get.height * 0.45,
                    width: Get.width,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: List.generate(
                          5,
                          (index) => ColorManager.background1
                              .withOpacity((index + 1) * 0.2),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 8.0, left: 8, top: 32),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    ColorManager.black.withOpacity(0.2),
                                  ),
                                ),
                                icon: const Icon(Icons.arrow_back),
                                color: ColorManager.white,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              Obx(() => IconButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                        ColorManager.black.withOpacity(0.2),
                                      ),
                                    ),
                                    icon: Icon(controller.userController
                                            .tournamentsBookmarked
                                            .contains(
                                                controller.tournament.value.id)
                                        ? Icons.notifications_rounded
                                        : Icons.notifications_none_rounded),
                                    color: ColorManager.white,
                                    onPressed: () {
                                      if (controller
                                          .userController.tournamentsBookmarked
                                          .contains(
                                              controller.tournament.value.id)) {
                                        controller.userController
                                            .removeTournamentBookmarked(
                                                controller.tournament.value.id);
                                      } else {
                                        controller.userController
                                            .addTournamentBookmarked(
                                                controller.tournament.value.id);
                                      }
                                    },
                                  )),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            // margin: const EdgeInsets.only(top: 16.0),
                            decoration: const BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.tournament.value.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '${controller.tournament.value.players.length} Subscribers',
                                  style: const TextStyle(
                                    color: ColorManager.lightGrey2,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16,
                                            color: ColorManager.lightGrey2),
                                        const SizedBox(width: 15),
                                        Text(controller.tournament.value.date,
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.lightGrey2)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AssetsManager.enter,
                                          height: 18,
                                          width: 18,
                                          colorFilter: const ColorFilter.mode(
                                              ColorManager.lightGrey2,
                                              BlendMode.srcIn),
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                            controller.tournament.value.amount
                                                .toString(),
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.lightGrey2)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(Icons.videogame_asset,
                                            size: 16,
                                            color: ColorManager.lightGrey2),
                                        const SizedBox(width: 15),
                                        Text(
                                            controller
                                                .tournament.value.platform,
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.lightGrey2)),
                                      ],
                                    ),
                                    const Divider(
                                        height: 20,
                                        color: ColorManager.lightGrey1),
                                    Row(
                                      children: [
                                        const Icon(Icons.group_rounded,
                                            size: 16,
                                            color: ColorManager.lightGrey2),
                                        const SizedBox(width: 15),
                                        Text(
                                            '+${controller.tournament.value.players.length} Participants',
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.lightGrey2)),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: ColorManager.lightGrey
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Obx(() => InkWell(
                                                onTap: () {
                                                  if (controller.tournament
                                                          .value.status ==
                                                      'closed') {
                                                    customDialog(
                                                        'Tournament Closed',
                                                        'This tournament is closed, you can not join it anymore.',
                                                        'Ok',
                                                        null, () {
                                                      Get.back();
                                                    }, null);
                                                  } else if (!controller
                                                      .canBuy.value) {
                                                    customDialog(
                                                        'Not Enough Coins',
                                                        'You do not have enough coins to join this game: ${controller.userController.coins.value}/${controller.tournament.value.amount} coins',
                                                        'Ok',
                                                        null, () {
                                                      Get.back();
                                                    }, null);
                                                  } else if (!controller
                                                      .isJoined.value) {
                                                    customDialog(
                                                        'Join Tournament',
                                                        'Are you sure you want to join this tournament? You will be charged ${controller.tournament.value.amount} coins.',
                                                        'Join',
                                                        'Cancel', () {
                                                      controller
                                                          .joinTournament();
                                                      Get.back();
                                                    }, () {
                                                      Get.back();
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  controller.isJoined.value
                                                      ? 'Joined'
                                                      : 'Accept',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        ColorManager.lightGrey2,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Tournament Stages',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.TOURNAMENT_STAGES,
                                arguments: controller.tournament.value,
                              );
                            },
                            child: const Text(
                              'Expand',
                              style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              controller.tournament.value.rounds.length,
                              (index) {
                            return FutureBuilder(
                                future: roundController.getRound(
                                    controller.tournament.value.rounds[index]),
                                builder: (context, round) {
                                  if (!round.hasData) {
                                    return Column(
                                        children: List.generate(
                                      5,
                                      (index) => const CustomLoading(
                                        heightFactor: 0.02,
                                        widthFactor: 0.9,
                                      ),
                                    ));
                                  }
                                  double opacity = (index + 1) /
                                      controller.tournament.value.rounds.length;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: ColorManager.primary
                                                  .withOpacity(opacity),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            "${round.data!.name}  •  ${round.data!.date}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager.primary
                                                    .withOpacity(opacity)),
                                          ),
                                        ],
                                      ),
                                      if (index !=
                                          controller.tournament.value.rounds
                                                  .length -
                                              1)
                                        Container(
                                          width: 2,
                                          height: 20,
                                          color: ColorManager.primary
                                              .withOpacity(opacity),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3.5),
                                        ),
                                    ],
                                  );
                                });
                          })),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: controller.tournament.value.status == 'closed'
                        ? Column(
                            children:
                                List.generate(controller.games.length, (index) {
                              return MatchCard(
                                game: controller.games[index],
                              );
                            }),
                          )
                        : DefaultTabController(
                            length: 3,
                            child: Column(
                              children: [
                                const TabBar(
                                  labelColor: ColorManager.black,
                                  indicatorColor: ColorManager.primary,
                                  tabs: [
                                    Tab(text: 'About'),
                                    Tab(text: 'Players'),
                                    Tab(text: 'Rules'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: Get.height * 0.45,
                                  child: TabBarView(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          controller
                                              .tournament.value.description,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Center(
                                          child: Column(
                                              children: List.generate(
                                                  controller.tournament.value
                                                      .players.length, (index) {
                                        return FutureBuilder(
                                            future: Profile.findUser(controller
                                                .tournament
                                                .value
                                                .players[index]),
                                            builder: (context, profile) {
                                              if (!profile.hasData) {
                                                return const CustomLoading(
                                                    heightFactor: .1,
                                                    widthFactor: .7);
                                              }

                                              return PlayerItem(
                                                profile: profile.data!,
                                              );
                                            });
                                      }))),
                                      Text(
                                        controller.tournament.value.rules,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
              ],
            );
          }),
    );
  }
}

class PlayerItem extends StatelessWidget {
  const PlayerItem({super.key, required this.profile});
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/user avatar (${profile.photo}).png',
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              // Text(team),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
