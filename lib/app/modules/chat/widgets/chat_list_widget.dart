// ==================== ChatListHeader (সার্চ কন্ট্রোলার পাস করা হয়েছে) ====================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ChatListHeader extends StatelessWidget {
  final TextEditingController searchController;

  const ChatListHeader({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container( 
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        image: DecorationImage(
          image: AssetImage(Assets.images.appBarBackground.keyName),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  'My Chats',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            heightBox14,
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: searchController, // এখানে কন্ট্রোলার ব্যবহার হচ্ছে
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
