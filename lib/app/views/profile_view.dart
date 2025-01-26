import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/medal_controller.dart';
import 'package:playground/app/controllers/top_games_controller.dart';
import 'package:playground/app/controllers/tournament_controller.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/controllers/games_controller.dart';
import 'package:playground/app/modules/widgets/custom_button.dart';
import 'package:playground/app/modules/widgets/medal_item.dart';
import 'package:playground/app/resources/assets_manager.dart';
import 'package:playground/app/routes/app_pages.dart';

import '../data/models/medal.dart';
import '../modules/Main/controllers/main_controller.dart';
import '../modules/widgets/custom_search_field.dart';
import '../modules/widgets/match_card.dart';
import '../modules/widgets/open_match_card.dart';
import '../modules/widgets/profile_bottom_sheet.dart';
import '../resources/color_manager.dart';

class ProfileView extends GetView<UserController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find<MainController>();
    UserController userController = Get.find<UserController>();
    RxString search_1 = ''.obs;
    RxString search_2 = ''.obs;
    RxBool gamesBookmarked = true.obs;

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: Get.height * 0.55,
              floating: false,
              pinned: true,
              shadowColor: ColorManager.background1,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Container(
                width: Get.width,
                height: 56,
                color: ColorManager.transparent,
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
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(ColorManager.lightGrey1),
                      ),
                      icon: const Icon(Icons.more_horiz_rounded,
                          color: ColorManager.lightGrey),
                      onPressed: () {
                        showBottomSheet();
                      },
                    ),
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Column(
                  children: [
                    const SizedBox(height: 56),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                child: Obx(() => CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                        "assets/images/user avatar (${userController.photo.value}).png",
                                      ),
                                    )),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorManager.lightGrey1,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Obx(() => Text(
                                        '${userController.xp.value} XP',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => Text(
                                    userController.name.value,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  )),
                              const SizedBox(width: 8),
                              Obx(() => Text(
                                    '(${userController.title.value})',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Obx(() => Text(
                                    userController.location.value,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            width: Get.width * 0.2,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.yellow,
                                  size: 14,
                                ),
                                Obx(() => Text(
                                      userController.coins.value.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 158,
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView(
                              children: [
                                Obx(() => Text(
                                      "Level ${userController.level.value}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    )),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: userController.xp.value / 3000,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Obx(() => Text(
                                          'XP: ${userController.xp.value}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    const Text(
                                      '/3000',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Next lvl: ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Obx(() => Text(
                                          (userController.level.value + 1)
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        )),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    color: ColorManager.lightGrey,
                                    thickness: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AssetsManager.cup,
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 4),
                                        Column(
                                          children: [
                                            Obx(() => Text(
                                                  userController
                                                      .gamesPlayed.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            const Text(
                                              'Played',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AssetsManager.flag,
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 4),
                                        Column(
                                          children: [
                                            Obx(() => Text(
                                                  userController.gamesWon.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            const Text(
                                              'Wins',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AssetsManager.badge,
                                          height: 24,
                                          width: 24,
                                        ),
                                        const SizedBox(width: 4),
                                        Column(
                                          children: [
                                            Obx(() => Text(
                                                  userController.medals.length
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                            const Text(
                                              'Medals',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
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
                  ],
                ),
              ),
            ),
          ];
        },
        body: DefaultTabController(
          length: 4,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            height: Get.height * 0.30,
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Column(
              children: [
                const TabBar(
                  labelColor: ColorManager.primary,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'Matches'),
                    Tab(text: 'BookMarks'),
                    Tab(text: 'Games'),
                    Tab(text: 'Medals'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildMatchesTab(userController, search_1),
                      _buildBookmarksTab(userController, gamesBookmarked),
                      _buildGamesTab(userController, search_2),
                      _buildMedalsTab(userController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMatchesTab(UserController userController, RxString search_1) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomSearchField(search: search_1),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Obx(() => Text.rich(
                      TextSpan(
                        text: 'You created ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorManager.lightGrey,
                        ),
                        children: [
                          TextSpan(
                            text: userController.gamesCreated.length.toString(),
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
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            child: Column(
              children:
                  List.generate(userController.gamesCreated.length, (index) {
                GamesController gamesController = Get.find<GamesController>();

                var game = gamesController
                    .findGame(userController.gamesCreated[index]);
                return game == null ? const SizedBox() : MatchCard(game: game);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarksTab(
      UserController userController, RxBool gamesBookmarked) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      width: Get.width * .4,
                      height: 40,
                      title: "Games",
                      onPressed: () {
                        gamesBookmarked.value = true;
                      },
                      foregroundColor: !gamesBookmarked.value
                          ? ColorManager.primary
                          : ColorManager.lightGrey1,
                      backgroundColor: gamesBookmarked.value
                          ? ColorManager.primary
                          : ColorManager.lightGrey1,
                    ),
                    CustomButton(
                      width: Get.width * .4,
                      height: 40,
                      title: "Tournaments",
                      onPressed: () {
                        gamesBookmarked.value = false;
                      },
                      foregroundColor: gamesBookmarked.value
                          ? ColorManager.primary
                          : ColorManager.lightGrey1,
                      backgroundColor: !gamesBookmarked.value
                          ? ColorManager.primary
                          : ColorManager.lightGrey1,
                    ),
                  ],
                ),
              ),
              gamesBookmarked.value == true
                  ? SingleChildScrollView(
                      child: Column(
                        children: userController.gamesBookmarked.isEmpty
                            ? [
                                const Padding(
                                  padding: EdgeInsets.only(top: 32.0),
                                  child: Text(
                                    'No games bookmarks yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(
                                userController.gamesBookmarked.length, (index) {
                                GamesController gamesController =
                                    Get.find<GamesController>();

                                var game = gamesController.findGame(
                                    userController.gamesBookmarked[index]);
                                return game == null
                                    ? const SizedBox()
                                    : OpenMatchCard(
                                        game: game,
                                      );
                              }),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: userController.tournamentsBookmarked.isEmpty
                            ? [
                                const Padding(
                                  padding: EdgeInsets.only(top: 32.0),
                                  child: Text(
                                    'No tournament bookmarks yet',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorManager.lightGrey,
                                    ),
                                  ),
                                ),
                              ]
                            : List.generate(
                                userController.tournamentsBookmarked.length,
                                (index) {
                                TournamentController tournamentController =
                                    Get.find<TournamentController>();

                                var tournament = tournamentController
                                    .findTournament(userController
                                        .tournamentsBookmarked[index]);
                                return tournament == null
                                    ? const SizedBox()
                                    : OpenTournamentCard(
                                        tournament: tournament,
                                      );
                              }),
                      ),
                    ),
            ],
          ),
        ));
  }

  Widget _buildGamesTab(UserController userController, RxString search_2) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CustomSearchField(
            search: search_2,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
                Obx(() => Text.rich(
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
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
              child: Column(
            children: List.generate(userController.gamesPlayed.length, (index) {
              GamesController gamesController = Get.find<GamesController>();

              var game =
                  gamesController.findGame(userController.gamesPlayed[index]);
              return game == null
                  ? const SizedBox()
                  : MatchCard(
                      game: game,
                    );
            }),
          )),
        ],
      ),
    );
  }

  Widget _buildMedalsTab(UserController userController) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: userController.medals.isEmpty
            ? [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'No medals yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorManager.lightGrey,
                    ),
                  ),
                ),
              ]
            : List.generate(userController.medals.length, (index) {
                MedalController medalController = Get.find<MedalController>();
                Medal medal =
                    medalController.findMedal(userController.medals[index]);
                return MedalItem(
                  title: medal.name,
                  description: medal.description,
                  icon: medal.icon,
                  xp: medal.xp.toString(),
                );
              }),
      ),
    );
  }
}

void showBottomSheet() async {
  await Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: ColorManager.background1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          BottomSheetItem(
            title: 'Edit Profile',
            icon: Icons.edit,
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE);
            },
          ),
          BottomSheetItem(
            title: 'Interests',
            icon: Icons.star_border_outlined,
            onTap: () {
              editInterest();
            },
          ),
          // BottomSheetItem(
          //   title: 'QR Code',
          //   icon: Icons.qr_code,
          //   onTap: () {},
          // ),
          // BottomSheetItem(
          //   title: 'Share Profile',
          //   icon: Icons.share,
          //   onTap: () {},
          // ),
          // BottomSheetItem(
          //   title: 'Discover Players',
          //   icon: Icons.people_alt_outlined,
          //   onTap: () {},
          // ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.lightGrey1,
                foregroundColor: ColorManager.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(Get.width, 40),
                elevation: 0,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        ],
      ),
    ),
  );
}

Future<dynamic> editInterest() {
  TopGamesController topGamesController = Get.find<TopGamesController>();
  UserController userController = Get.find<UserController>();
  List<String> interests = userController.interests;
  return Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Edit Interests',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.black,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 16),
          const Text('Select game categories you are interested in',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.black,
              )),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.6,
            ),
            itemCount:
                topGamesController.topGames.length, // Number of interests
            itemBuilder: (context, index) {
              RxBool isInterested = interests
                  .contains(topGamesController.topGames[index].name)
                  .obs;
              return GestureDetector(
                onTap: () {
                  if (isInterested.value) {
                    userController.removeInterest(
                        topGamesController.topGames[index].name);
                  } else {
                    userController
                        .addInterest(topGamesController.topGames[index].name);
                  }
                  isInterested.value = !isInterested.value;
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(topGamesController.topGames[index].image,
                            height: 50),
                        Obx(() => Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isInterested.value
                                      ? ColorManager.primary
                                      : ColorManager.lightGrey1,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  isInterested.value ? Icons.check : Icons.add,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(topGamesController.topGames[index].name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: ColorManager.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(Get.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    ),
    backgroundColor: ColorManager.background1,
  );
}
