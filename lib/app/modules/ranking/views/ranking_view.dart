import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/controllers/user_controller.dart';
import 'package:playground/app/data/models/profile.dart';
import 'package:playground/app/modules/widgets/custom_loading.dart';
import 'package:playground/app/resources/color_manager.dart';
import '../controllers/ranking_controller.dart';

class RankingView extends GetView<RankingController> {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background1,
      appBar: AppBar(
        backgroundColor: ColorManager.background1,
        title: const Text('Rankings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(ColorManager.transparent),
          ),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: FutureBuilder(
          future: controller.getProfiles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                  children: List.generate(
                5,
                (index) => const CustomLoading(
                  heightFactor: 0.06,
                  widthFactor: 0.9,
                ),
              ));
            }
            return buildIndividualsTab();
          }),
    );
  }

  Widget buildIndividualsTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: ColorManager.lightGrey1,
                borderRadius: BorderRadius.circular(16),
              ),
              child: PopupMenuButton(
                  color: ColorManager.background1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        child: Text('Wins',
                            style: TextStyle(color: ColorManager.lightGrey2)),
                      ),
                      const PopupMenuItem(
                        child: Text('Points',
                            style: TextStyle(color: ColorManager.lightGrey2)),
                      ),
                      const PopupMenuItem(
                        child: Text('Earnings',
                            style: TextStyle(color: ColorManager.lightGrey2)),
                      ),
                    ];
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Wins',
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
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return index > controller.profiles.length - 1
                      ? const SizedBox()
                      : LeaderItem(
                          rank: index + 1,
                          isTopRanker: index == 0,
                          user: controller.profiles[index]);
                }),
              )),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Obx(() => ListView(
                children: List.generate(controller.profiles.length, (index) {
                  UserController userController = Get.find<UserController>();
                  return buildRankedUserItem(
                      controller.profiles[index], index + 1,
                      isHighlighted: controller.profiles[index].uid ==
                          userController.uid.value,
                      isFaded: index % 2 != 0);
                }),
              )),
        ),
      ],
    );
  }

  Widget buildRankedUserItem(Profile user, int rank,
      {bool isHighlighted = false, bool isFaded = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isHighlighted ? ColorManager.primary : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //   ),
        // ],
      ),
      child: Row(
        children: [
          Text(
            '$rank -',
            style: TextStyle(
              color: isHighlighted ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/images/user avatar (${user.photo}).png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name,
                    style: TextStyle(
                        color: isHighlighted ? Colors.white : Colors.black)),
                Text('${user.gamesWon.length} Wins',
                    style: TextStyle(
                        color: isHighlighted ? Colors.white : Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderItem extends StatelessWidget {
  final int rank;
  final Profile user;
  final bool isTopRanker;

  const LeaderItem({
    super.key,
    required this.rank,
    this.isTopRanker = false,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: isTopRanker ? 50 : 40,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/images/user avatar (${user.photo}).png',
                  width: isTopRanker ? 100 : 80,
                  height: isTopRanker ? 100 : 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              left: 0,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: rank == 1
                    ? Colors.orange
                    : rank == 2
                        ? Colors.grey
                        : Colors.brown,
                child: Text(
                  '$rank',
                ),
              ),
            ),
            if (isTopRanker)
              const Positioned(
                right: 0,
                top: -4,
                left: 0,
                child: Icon(
                  Icons.whatshot_sharp,
                  color: Colors.orange,
                  size: 28,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('${user.gamesWon.length} Wins',
            style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
