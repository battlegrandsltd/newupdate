import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/games_controller.dart';
import 'package:playground/app/controllers/top_games_controller.dart';
import '../data/models/game.dart';
import '../modules/Main/controllers/main_controller.dart';
import '../modules/widgets/custom_loading.dart';
import '../modules/widgets/custom_search_field.dart';
import '../modules/widgets/open_match_card.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../routes/app_pages.dart';
import '../modules/widgets/game_item.dart';

class DiscoverView extends GetView {
  const DiscoverView({super.key});
  @override
  Widget build(BuildContext context) {
    MainController mainController = Get.find();
    TopGamesController topGamesController = Get.find();
    GamesController gamesController = Get.find();
    RxString sort = 'Prize - High to Low'.obs;
    List<String> sortOptions = [
      'Date - Latest',
      'Date - Oldest',
      'Prize - Low to High',
      'Prize - High to Low',
    ];
    RxString search = ''.obs;
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: Get.height * 0.36,
              floating: false,
              pinned: true,
              shadowColor: ColorManager.background1,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: SizedBox(
                height: Get.height * 0.04,
                child: Padding(
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
                        'Discover',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            Get.toNamed(Routes.NOTIFICATION);
                          },
                          child: SvgPicture.asset(AssetsManager.notification)),
                    ],
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: CustomSearchField(
                        search: search,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Top Games',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              search.value = '';
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorManager.lightGrey2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: topGamesController.topGames.map((game) {
                            return GameItem(
                              image: game.image,
                              title: game.name,
                              search: search,
                            );
                          }).toList()),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Obx(() => Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: Row(
                        children: [
                          const Text(
                            'Matches',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          PopupMenuButton(
                              color: ColorManager.background1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              onSelected: (value) {
                                sort.value = value.toString();
                              },
                              initialValue: sort.value,
                              itemBuilder: (context) {
                                return sortOptions.map((option) {
                                  return PopupMenuItem(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList();
                              },
                              child: Row(
                                children: [
                                  Obx(() => Text(
                                        sort.value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: ColorManager.lightGrey2,
                                        ),
                                      )),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: ColorManager.lightGrey2,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    if (search.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Search results for "${search.value}"',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    Expanded(
                        child: StreamBuilder(
                      stream: gamesController.getOpenGames('games'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView(
                              children: List.generate(
                            2,
                            (index) => const CustomLoading(
                              heightFactor: 0.3,
                              widthFactor: 0.9,
                            ),
                          ));
                        }
                        if (snapshot.hasError || snapshot.data == null) {
                          debugPrint(snapshot.error.toString());
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.black,
                                ),
                                Text(
                                  'No Matches available',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }

                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.black,
                                ),
                                Text(
                                  'No Matches available',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }

                        RxList<Game> games = (snapshot.data!).obs;
                        return Obx(() {
                          var filteredGames = games
                              .where((game) => game.name
                                  .toLowerCase()
                                  .contains(search.value.toLowerCase()))
                              .toList();

                          filteredGames.sort((a, b) {
                            if (sort.value == sortOptions[0]) {
                              return a.amount.compareTo(b.amount);
                            } else if (sort.value == sortOptions[1]) {
                              return b.amount.compareTo(a.amount);
                            } else if (sort.value == sortOptions[2]) {
                              return a.amount.compareTo(b.amount);
                            } else {
                              return b.amount.compareTo(a.amount);
                            }
                          });
                          if (filteredGames.isEmpty) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'No Matches available for this search',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                              itemCount: filteredGames.length,
                              itemBuilder: (context, index) {
                                Game game = filteredGames.elementAt(index);
                                return OpenMatchCard(
                                  game: game,
                                );
                              });
                        });
                      },
                    )),
                  ],
                )),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Get.toNamed(Routes.CREATE_MATCH);
                },
                backgroundColor: ColorManager.lightGrey2,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
