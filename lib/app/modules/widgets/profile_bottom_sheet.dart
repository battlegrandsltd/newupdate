import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: ColorManager.lightGrey,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        color: ColorManager.black, fontSize: 16)),
              ],
            ),
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


// class FeedItem extends StatelessWidget {
//   const FeedItem({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.time,
//     required this.likes,
//     required this.comments,
//   });
//   final String title;
//   final String description;
//   final String image;
//   final String time;
//   final String likes;
//   final String comments;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(bottom: 8),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundImage: AssetImage(image),
//               ),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text(
//                     time,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Text(
//           description,
//           style: const TextStyle(
//             fontSize: 16,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             IconButton(
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(Colors.transparent),
//               ),
//               icon: const Icon(
//                 Icons.favorite_border_outlined,
//                 color: ColorManager.lightGrey,
//               ),
//               onPressed: () {},
//             ),
//             Text(likes,
//                 style: const TextStyle(
//                     fontSize: 16, color: ColorManager.lightGrey)),
//             const SizedBox(width: 16),
//             IconButton(
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(Colors.transparent),
//               ),
//               icon: const Icon(
//                 Icons.chat_bubble_outline_outlined,
//                 color: ColorManager.lightGrey,
//               ),
//               onPressed: () {},
//             ),
//             Text(comments,
//                 style: const TextStyle(
//                     fontSize: 16, color: ColorManager.lightGrey)),
//             const Spacer(),
//             IconButton(
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.all(Colors.transparent),
//               ),
//               icon: const Icon(
//                 Icons.share_outlined,
//                 color: ColorManager.lightGrey,
//               ),
//               onPressed: () {},
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }


