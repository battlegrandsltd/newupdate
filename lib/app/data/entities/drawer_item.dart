import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';

class DrawerItem {
  late String title;
  late IconData icon;
  late String pageUrl;
  late bool lastItem;
  DrawerItem(
      {required this.title,
      required this.icon,
      required this.pageUrl,
      required this.lastItem});
}

List<DrawerItem> drawerItems = [
  DrawerItem(
      title: "Settings",
      icon: Icons.settings,
      pageUrl: Routes.SETTINGS,
      lastItem: false),
  DrawerItem(
      title: "Wallet",
      icon: Icons.account_balance_wallet_outlined,
      pageUrl: Routes.WALLET,
      lastItem: false),
  DrawerItem(
      title: "Messages",
      icon: Icons.message,
      pageUrl: Routes.MESSAGES,
      lastItem: false),
];
