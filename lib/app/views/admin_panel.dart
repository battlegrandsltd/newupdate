import 'package:flutter/material.dart';

import 'package:playground/app/views/Admin_Home.dart';
import 'package:playground/app/views/admin_tournaments.dart';

import 'package:playground/app/views/withdrawal_request.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('A D M I N'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.gamepad_outlined), text: 'Tournaments'),
              Tab(icon: Icon(Icons.attach_money_outlined), text: 'Withdrawals'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const AdminHome(),
            TournamentList(),
            const WithdrawalRequest(),
          ],
        ),
      ),
    );
  }
}
