import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EarningsView extends GetView {
  const EarningsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EarningsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EarningsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
