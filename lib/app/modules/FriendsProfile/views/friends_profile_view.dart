import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../widgets/custom_search_field.dart';
import '../../widgets/friends_item.dart';
import '../../widgets/medal_item.dart';
import '../controllers/friends_profile_controller.dart';

class FriendsProfileView extends GetView<FriendsProfileController> {
  const FriendsProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    RxString search = ''.obs;
    return Scaffold(
      backgroundColor: ColorManager.background1,
      body: ListView(
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
                      Icons.arrow_back_rounded,
                      color: ColorManager.black,
                    ),
                    onTap: () {
                      Get.back();
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
                  color: ColorManager.lightGrey,
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      ColorManager.lightGrey1,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.more_horiz_rounded,
                      color: ColorManager.lightGrey),
                  onPressed: () {
                    // showBottomSheet();
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'assets/images/user avatar (1).png'), // Replace with your image path
                      ),
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
                        child: const Text(
                          '2330 XP',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'John',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Texas, USA',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Friends',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.2),
                    //     spreadRadius: 2,
                    //     blurRadius: 5,
                    //     offset: const Offset(0, 3),
                    //   ),
                    // ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Master',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 100 / 3000,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text(
                            'XP: 100',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '/3000',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Next lvl: ',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Master',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManager.cup,
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(width: 4),
                              const Column(
                                children: [
                                  Text(
                                    '7',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
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
                              const Column(
                                children: [
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
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
                              const Column(
                                children: [
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Badges',
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
          DefaultTabController(
            length: 4,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.2),
                //     spreadRadius: 2,
                //     blurRadius: 5,
                //     offset: const Offset(0, -3),
                //   ),
                // ],
              ),
              height: Get.height * 0.45,
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Column(
                children: [
                  const TabBar(
                    labelColor: ColorManager.primary,
                    unselectedLabelColor: Colors.black,
                    dividerColor: ColorManager.lightGrey1,
                    tabs: [
                      Tab(text: 'About'),
                      Tab(text: 'Games'),
                      Tab(text: 'Medals'),
                      Tab(text: 'Friends'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            'Hi, I am Tosan, lover of Video games. Happy to connect with fellow gamers out there. My favourite Mobile Game is Call of Duty Mobile.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CustomSearchField(
                                search: search,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text.rich(
                                    TextSpan(
                                      text: 'You have played ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorManager.lightGrey,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '78',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: ColorManager.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
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
                                                    color: ColorManager
                                                        .lightGrey2)),
                                          ),
                                          const PopupMenuItem(
                                            child: Text('Low to High',
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .lightGrey2)),
                                          ),
                                          const PopupMenuItem(
                                            child: Text('High to Low',
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .lightGrey2)),
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
                              const SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // MatchCard(
                                    //     title: "COD",
                                    //     time: "12th June 2021",
                                    //     player1: "Tostro",
                                    //     player2: "John",
                                    //     result: "Win",
                                    //     gameImage:
                                    //         "assets/images/Game Banner.png"),
                                    // MatchCard(
                                    //     title: "PUBG",
                                    //     time: "12th June 2021",
                                    //     player1: "Tostro",
                                    //     player2: "Smith",
                                    //     result: "Loss",
                                    //     gameImage:
                                    //         "assets/images/Game Banner.png"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SingleChildScrollView(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              MedalItem(
                                title: 'Master',
                                description: 'Play 100 games',
                                icon: 'assets/images/medal avatar.png',
                                xp: '2330',
                              ),
                              MedalItem(
                                title: 'The Pacifier',
                                description: 'Win 50 games',
                                icon: 'assets/images/medal avatar.png',
                                xp: '3000',
                              ),
                              MedalItem(
                                title: 'The Supreme',
                                description: 'Win 100 games',
                                icon: 'assets/images/medal avatar.png',
                                xp: '5000',
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSearchField(
                                search: search,
                              ),
                              const SizedBox(height: 8),
                              const Text.rich(
                                TextSpan(
                                  text: 'You have ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ColorManager.lightGrey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '450',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorManager.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' friends.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorManager.lightGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Column(
                                children: [
                                  FriendItem(),
                                  FriendItem(),
                                  FriendItem(),
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
        ],
      ),
    );
  }
}
