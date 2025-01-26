import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/widgets/custom_button.dart';
import 'package:playground/app/modules/widgets/custom_loading.dart';
import 'package:playground/app/resources/assets_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/profile.dart';
import '../../../resources/color_manager.dart';
import '../../widgets/custom_dialog.dart';
import '../controllers/match_detail_controller.dart';

class MatchDetailView extends GetView<MatchDetailController> {
  const MatchDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController linkController = TextEditingController();
    return Obx(
      () => Scaffold(
        backgroundColor: ColorManager.background1,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: (controller.isLoading.value)
            ? Center(
                child: Column(
                children: [
                  SizedBox(height: Get.width * 0.2),
                  const CustomLoading(heightFactor: .3, widthFactor: .8),
                  SizedBox(height: Get.width * 0.05),
                  const CustomLoading(heightFactor: .4, widthFactor: .8),
                ],
              ))
            : ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          controller.game.value.image,
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
                            10,
                            (index) => ColorManager.background1
                                .withOpacity((index + 1) * 0.1),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
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
                              const Spacer(),
                              if (!controller.isTournament.value)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 8, top: 32),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            ColorManager.black.withOpacity(0.2),
                                          ),
                                        ),
                                        icon: Icon(controller.isBookmarked.value
                                            ? Icons.notifications_rounded
                                            : Icons.notifications_none_rounded),
                                        color: ColorManager.white,
                                        onPressed: controller.toggleBookmark,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: ColorManager.shadow,
                              //     blurRadius: 10,
                              //     spreadRadius: 5,
                              //   ),
                              // ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.game.value.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "one-on-one",
                                  style: TextStyle(
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
                                        Text(controller.game.value.date,
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
                                            controller.game.value.amount
                                                .toString(),
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.lightGrey2)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.emoji_events,
                                          size: 16,
                                          color: ColorManager.lightGrey2,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                            (controller.game.value.amount * 2)
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
                                        Text(controller.game.value.platform,
                                            style: const TextStyle(
                                                color:
                                                    ColorManager.lightGrey2)),
                                      ],
                                    ),
                                    if (!controller.isTournament.value)
                                      Column(
                                        children: [
                                          const Divider(
                                              height: 20,
                                              color: ColorManager.lightGrey1),
                                          FutureBuilder(
                                              future: Profile.findUser(
                                                  controller
                                                      .game.value.creator!),
                                              builder: (context, snapshot) {
                                                if (!snapshot.hasData) {
                                                  return const CustomLoading(
                                                      heightFactor: .02,
                                                      widthFactor: .7);
                                                }
                                                return Row(
                                                  children: [
                                                    Image.asset(
                                                        "assets/images/user avatar (${snapshot.data!.photo}).png",
                                                        height: 20,
                                                        width: 20),
                                                    const SizedBox(width: 10),
                                                    Text(snapshot.data!.name,
                                                        style: const TextStyle(
                                                            color: ColorManager
                                                                .black)),
                                                    const Spacer(),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      decoration: BoxDecoration(
                                                        color: ColorManager
                                                            .lightGrey
                                                            .withOpacity(0.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: InkWell(
                                                        onTap: controller
                                                            .toggleButton,
                                                        child: Text(
                                                          controller
                                                              .getButtonText(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            color: ColorManager
                                                                .lightGrey2,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
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
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: ColorManager.shadow,
                      //     blurRadius: 10,
                      //     spreadRadius: 5,
                      //   ),
                      // ],
                    ),
                    child: controller.isJoined.value
                        ? controller.game.value.status == 'open' &&
                                controller.isCreator.value
                            ? const Center(
                                child: Text('Waiting for people to join...',
                                    style: TextStyle(
                                        color: ColorManager.lightGrey2,
                                        fontWeight: FontWeight.bold)),
                              )
                            : Column(
                                children: [
                                  FutureBuilder(
                                      future: Profile.findPlayers(
                                          controller.game.value.player_1,
                                          controller.game.value.player_2),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: ColorManager.primary,
                                              ),
                                            ),
                                          );
                                        }
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            const Text('VS',
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: ColorManager.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                        );
                                      }),
                                  const SizedBox(height: 10),
                                  const Text('Final Result',
                                      style: TextStyle(
                                          color: ColorManager.black,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10),
                                  controller.game.value.status == 'closed'
                                      ? Column(
                                          children: [
                                            Text(
                                                controller.game.value.winner ==
                                                        controller
                                                            .userController
                                                            .uid
                                                            .value
                                                    ? 'You Won'
                                                    : 'You Lost',
                                                style: TextStyle(
                                                    color: controller.game.value
                                                                .winner ==
                                                            controller
                                                                .userController
                                                                .uid
                                                                .value
                                                        ? ColorManager.green
                                                        : ColorManager.error,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            const Text('Video Evidence',
                                                style: TextStyle(
                                                    color: ColorManager.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    launchUrl(Uri.parse(
                                                        controller.game.value
                                                                .link_1 ??
                                                            ''));
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.link_rounded,
                                                          color: ColorManager
                                                              .lightGrey2),
                                                      SizedBox(width: 10),
                                                      Text('Link #01',
                                                          style: TextStyle(
                                                              color: ColorManager
                                                                  .lightGrey2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    launchUrl(Uri.parse(
                                                        controller.game.value
                                                                .link_2 ??
                                                            ''));
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.link_rounded,
                                                          color: ColorManager
                                                              .lightGrey2),
                                                      SizedBox(width: 10),
                                                      Text('Link #02',
                                                          style: TextStyle(
                                                              color: ColorManager
                                                                  .lightGrey2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : controller.result.value != ''
                                          ? Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .access_time_rounded,
                                                          size: 16,
                                                          color: ColorManager
                                                              .lightGrey2),
                                                      SizedBox(width: 5),
                                                      Text('Under Review...',
                                                          style: TextStyle(
                                                              color: ColorManager
                                                                  .lightGrey2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text(
                                                        'Your Submitted Result:',
                                                        style: TextStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    Container(
                                                      width: Get.width * 0.2,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: controller.result
                                                                    .value ==
                                                                'Won'
                                                            ? ColorManager.green
                                                            : controller.result
                                                                        .value ==
                                                                    'Draw'
                                                                ? ColorManager
                                                                    .lightGrey
                                                                : ColorManager
                                                                    .error,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(5),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            controller
                                                                .result.value,
                                                            style: const TextStyle(
                                                                color:
                                                                    ColorManager
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text(
                                                        'Your Submitted Link:',
                                                        style: TextStyle(
                                                          color: ColorManager
                                                              .black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    SizedBox(
                                                      width: Get.width * 0.3,
                                                      child: InkWell(
                                                        onTap: () {
                                                          launchUrl(Uri.parse(
                                                              controller
                                                                  .link.value));
                                                        },
                                                        child: Text(
                                                            controller
                                                                .link.value,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                color:
                                                                    ColorManager
                                                                        .primary,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .access_time_rounded,
                                                        size: 16,
                                                        color: ColorManager
                                                            .lightGrey2),
                                                    SizedBox(width: 5),
                                                    Text('02:00:00',
                                                        style: TextStyle(
                                                            color: ColorManager
                                                                .black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Form(
                                                  key: formKey,
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Text('Video Evidence',
                                                              style: TextStyle(
                                                                  color:
                                                                      ColorManager
                                                                          .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      const Text(
                                                          "Take a video recording of the game being played and upload it to any social media platform. Once uploaded, paste the video link below. In the event of any dispute, the video will be used as evidence",
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style: TextStyle(
                                                              color: ColorManager
                                                                  .lightGrey2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const SizedBox(
                                                          height: 10),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorManager
                                                              .lightGrey
                                                              .withOpacity(0.3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .link_rounded,
                                                                color: ColorManager
                                                                    .lightGrey2),
                                                            const SizedBox(
                                                                width: 10),
                                                            Expanded(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    linkController,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      'Paste Video Link',
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                ),
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Please enter a valid link';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CustomButton(
                                                            width: Get.width *
                                                                0.26,
                                                            height: 40,
                                                            onPressed:
                                                                () async {
                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                await customDialog(
                                                                  'Confirm Result',
                                                                  'Are you sure you want to submit this result?',
                                                                  'Yes',
                                                                  'No',
                                                                  () async {
                                                                    await controller
                                                                        .updateStatus(
                                                                      'Won',
                                                                      linkController
                                                                          .text,
                                                                    );
                                                                    Get.back();
                                                                  },
                                                                  () {
                                                                    Get.back();
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            backgroundColor:
                                                                ColorManager
                                                                    .green,
                                                            foregroundColor:
                                                                ColorManager
                                                                    .white,
                                                            title: 'Won',
                                                          ),
                                                          CustomButton(
                                                            width: Get.width *
                                                                0.26,
                                                            height: 40,
                                                            onPressed:
                                                                () async {
                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                await customDialog(
                                                                  'Confirm Result',
                                                                  'Are you sure you want to submit this result?',
                                                                  'Yes',
                                                                  'No',
                                                                  () async {
                                                                    await controller.updateStatus(
                                                                        'Draw',
                                                                        linkController
                                                                            .text);
                                                                    Get.back();
                                                                  },
                                                                  () {
                                                                    Get.back();
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            backgroundColor:
                                                                ColorManager
                                                                    .lightGrey,
                                                            foregroundColor:
                                                                ColorManager
                                                                    .white,
                                                            title: 'Draw',
                                                          ),
                                                          CustomButton(
                                                            width: Get.width *
                                                                0.26,
                                                            height: 40,
                                                            onPressed:
                                                                () async {
                                                              if (formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                await customDialog(
                                                                  'Confirm Result',
                                                                  'Are you sure you want to submit this result?',
                                                                  'Yes',
                                                                  'No',
                                                                  () async {
                                                                    await controller.updateStatus(
                                                                        'Lost',
                                                                        linkController
                                                                            .text);
                                                                    Get.back();
                                                                  },
                                                                  () {
                                                                    Get.back();
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            backgroundColor:
                                                                ColorManager
                                                                    .error,
                                                            foregroundColor:
                                                                ColorManager
                                                                    .white,
                                                            title: 'Lost',
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                ],
                              )
                        : DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                const TabBar(
                                  labelColor: ColorManager.black,
                                  indicatorColor: ColorManager.primary,
                                  tabs: [
                                    Tab(text: 'About'),
                                    Tab(text: 'Rules'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: Get.height * 0.45,
                                  child: TabBarView(
                                    children: [
                                      SingleChildScrollView(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          controller.game.value.description,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          controller.game.value.rules,
                                          style: const TextStyle(
                                            color: ColorManager.black,
                                          ),
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
        floatingActionButton:
            (controller.isCreator.value && controller.isAvailable.value) ||
                    (controller.isTournament.value)
                ? null
                : FloatingActionButton(
                    onPressed: controller.chat,
                    backgroundColor: ColorManager.primary,
                    child: SvgPicture.asset(
                      AssetsManager.messages,
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        ColorManager.white,
                        BlendMode.srcIn,
                      ),
                    )),
      ),
    );
  }
}
