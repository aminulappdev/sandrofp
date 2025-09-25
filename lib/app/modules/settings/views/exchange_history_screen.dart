import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/completed_history.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/declined_history.dart';
import 'package:sandrofp/app/modules/settings/views/all_history/pending_history.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ExchangeHistoryScreen extends StatefulWidget {
  const ExchangeHistoryScreen({super.key});

  @override
  State<ExchangeHistoryScreen> createState() => _ExchangeHistoryScreenState();
}

class _ExchangeHistoryScreenState extends State<ExchangeHistoryScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exchange History',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: Color(0xffFFFFFF).withValues(alpha: 0.05),
              imagePath: Assets.images.notification.keyName,
              onTap: () {},
            ),
            widthBox10,
            CircleAvatar(
              backgroundImage: AssetImage(Assets.images.onboarding01.keyName),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            heightBox12,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = 0;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Text(
                        'Completed',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == 0
                              ? const Color.fromARGB(255, 32, 71, 48)
                              : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      heightBox4,
                      selectedIndex == 0
                          ? Container(
                              height: 1,
                              width: 90,
                              color: const Color.fromARGB(255, 32, 71, 48),
                            )
                          : Container(),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Text(
                        'Pending',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == 1
                              ? const Color.fromARGB(255, 32, 71, 48)
                              : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      heightBox4,
                      selectedIndex == 1
                          ? Container(
                              height: 1,
                              width: 60,
                              color: const Color.fromARGB(255, 32, 71, 48),
                            )
                          : Container(),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Text(
                        'Declined',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == 2
                              ? const Color.fromARGB(255, 32, 71, 48)
                              : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      heightBox4,
                      selectedIndex == 2
                          ? Container(
                              height: 1,
                              width: 70,
                              color: const Color.fromARGB(255, 32, 71, 48),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),

            heightBox16,
            if (selectedIndex == 0) ...{
              CompletedHistory(),
            } else if (selectedIndex == 1) ...{
              PendingHistory(),
            } else if (selectedIndex == 2) ...{
              DeclinedHistory(),
            },
          ],
        ),
      ),
    );
  }
}
