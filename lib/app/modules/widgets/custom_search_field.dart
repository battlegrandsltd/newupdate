import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/color_manager.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.search,
  });
  final RxString search;
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: search.value);
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: const Icon(Icons.search, color: Colors.grey),
        hintStyle: const TextStyle(
          fontSize: 16,
          color: ColorManager.lightGrey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: ColorManager.lightGrey.withOpacity(0.3),
      ),
      onChanged: (val) {
        search.value = val;
      },
    );
  }
}
