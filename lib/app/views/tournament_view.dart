import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/tournament_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/tournament.dart';
import 'package:playground/app/modules/Main/controllers/main_controller.dart';
import 'package:playground/app/modules/widgets/open_match_card.dart';
import 'package:playground/app/resources/assets_manager.dart';
import 'package:playground/app/routes/app_pages.dart';
import '../resources/color_manager.dart';

class TournamentView extends GetView {
  const TournamentView({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    TournamentController tournamentController = Get.find();
    UserController userController = Get.find();
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: ColorManager.transparent,
                    border: Border.all(
                      color: ColorManager.primary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    child: const Icon(
                      Icons.menu,
                      color: ColorManager.primary,
                    ),
                    onTap: () {
                      mainController.isDrawerOpen
                          ? mainController.closeDrawer(context)
                          : mainController.openDrawer(context);
                    },
                  ),
                ),
                const Spacer(),
                const Text(
                  'Tournaments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  color: ColorManager.transparent,
                  highlightColor: ColorManager.transparent,
                  splashColor: ColorManager.transparent,
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(ColorManager.transparent),
                  ),
                  icon: const SizedBox(),
                  onPressed: () {
                    // Get.toNamed(Routes.CREATE_MATCH);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Joined',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: userController.tournamentsPlayed.isEmpty
                      ? [
                          Center(
                            child: SizedBox(
                              height: 200,
                              width: Get.width,
                              child: const Center(
                                child: Text(
                                  'No tournaments joined',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorManager.lightGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      : List.generate(
                          userController.tournamentsPlayed.length,
                          (index) {
                            Tournament? tournament =
                                tournamentController.findTournament(
                                    userController.tournamentsPlayed[index]);
                            return tournament == null
                                ? const SizedBox()
                                : JoinedTournamentCard(
                                    tournament: tournament,
                                  );
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        width: Get.width * 0.6,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.RANKING);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      AssetsManager.tournament_filled,
                                      colorFilter: const ColorFilter.mode(
                                          ColorManager.white, BlendMode.srcIn),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Rankings',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorManager.lightGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.GAMES);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: const Icon(Icons.videogame_asset,
                                        color: ColorManager.white),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'My Games',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: ColorManager.lightGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'New',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: (tournamentController.tournaments.isEmpty)
                            ? const [
                                SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Text(
                                      'No tournaments available',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorManager.lightGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(
                                tournamentController.tournaments.length,
                                (index) {
                                  return OpenTournamentCard(
                                    tournament:
                                        tournamentController.tournaments[index],
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class JoinedTournamentCard extends StatelessWidget {
  final Tournament tournament;

  const JoinedTournamentCard({
    super.key,
    required this.tournament,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TOURNAMENT_DETAIL, arguments: tournament);
      },
      child: Container(
          width: Get.width * 0.8,
          height: 80,
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorManager.white),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(tournament.image),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * 0.3,
                    child: Text(
                      tournament.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    tournament.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorManager.lightGrey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  tournament.players.isNotEmpty
                      ? Text(
                          '${tournament.players.length} Participants',
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorManager.lightGrey,
                          ),
                        )
                      : const SizedBox(),
                  Text(
                    tournament.amount.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorManager.lightGrey,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
