import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DrawerMenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final String pageUrl;
  final Widget? trailing;

  const DrawerMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.pageUrl,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      trailing: trailing,
      onTap: () {
        Get.toNamed(pageUrl);
      },
    );
  }
}
