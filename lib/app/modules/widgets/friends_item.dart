import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/routes/app_pages.dart';

import '../../resources/color_manager.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.FRIENDS_PROFILE);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/user avatar.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tostro',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorManager.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '2330 XP',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorManager.lightGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              color: ColorManager.lightGrey1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
