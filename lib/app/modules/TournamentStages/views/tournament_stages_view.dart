import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/data/models/game.dart';
import 'package:playground/app/resources/color_manager.dart';
import 'package:playground/app/routes/app_pages.dart';
import '../../../data/models/profile.dart';
import '../controllers/tournament_stages_controller.dart';

class TournamentStagesView extends GetView<TournamentStagesController> {
  const TournamentStagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.rounds.length,
      child: Scaffold(
        backgroundColor: ColorManager.background1,
        appBar: AppBar(
          backgroundColor: ColorManager.background1,
          leading: IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
            ),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text('Tournament Stages',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 16,
                //       vertical: 8,
                //     ),
                //     decoration: BoxDecoration(
                //       color: ColorManager.lightGrey1,
                //       border: Border.all(color: ColorManager.primary),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: const Text(
                //       'View Leaderboard',
                //       style: TextStyle(color: ColorManager.primary),
                //     ),
                //   ),
                // ),
                TabBar(
                    isScrollable: true,
                    indicatorColor: ColorManager.primary,
                    tabs: List.generate(
                      controller.tournament.rounds.length,
                      (index) => Tab(
                        child: Text(
                          controller.rounds[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        body: TabBarView(
            children: List.generate(
          controller.rounds.length,
          (index) {
            final round = controller.rounds[index];
            return buildStageView(
              round.time ?? '00:00:00',
              controller.getGames(round.id),
            );
          },
        )),
      ),
    );
  }

  Widget buildStageView(String time, List<Game> games) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                // color: ColorManager.lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time, color: Colors.black),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final match = games[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.2),
                    //     spreadRadius: 2,
                    //     blurRadius: 5,
                    //   ),
                    // ],
                  ),
                  child: FutureBuilder(
                      future:
                          Profile.findPlayers(match.player_1, match.player_2),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.primary,
                            ),
                          );
                        }
                        return (snapshot.data!.isNotEmpty)
                            ? InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.MATCH_DETAIL,
                                      arguments: match);
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TeamItem(
                                      name: snapshot.data![0].name,
                                      result: match.status != "closed"
                                          ? 'Pending'
                                          : match.winner == match.player_1
                                              ? 'Won'
                                              : 'Lost',
                                      logo: snapshot.data![0].photo,
                                    ),
                                    const Divider(
                                      color: ColorManager.lightGrey,
                                      thickness: 1,
                                    ),
                                    (snapshot.data!.length > 1)
                                        ? TeamItem(
                                            name: snapshot.data![1].name,
                                            result: match.status != "closed"
                                                ? 'Pending'
                                                : match.winner == match.player_2
                                                    ? 'Won'
                                                    : 'Lost',
                                            logo: snapshot.data![1].photo,
                                          )
                                        : const TeamItem(
                                            name: "Waiting",
                                            result: "Pending",
                                            logo: "1")
                                  ],
                                ),
                              )
                            : const Text('Waiting for match to start');
                      }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TeamItem extends StatelessWidget {
  const TeamItem({
    super.key,
    required this.name,
    required this.result,
    required this.logo,
  });

  final String name;
  final String result;
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.orange,
          child: Image.asset(
            "assets/images/user avatar ($logo).png",
            height: 40,
            width: 40,
          ),
        ),
        const SizedBox(width: 8),
        Text(name),
        const Spacer(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            width: 80,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: result == 'Pending'
                  ? Colors.grey
                  : result == 'Won'
                      ? Colors.green
                      : Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(result, style: const TextStyle(color: Colors.white))),
      ],
    );
  }
}
