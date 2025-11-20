import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/product/widgets/status_bar.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class StatusCard extends StatelessWidget {
  final String? status;
  const StatusCard({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Status',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'On time we got your exchange',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  CircleAvatar(
                    backgroundColor: Color(0xffEBF2EE),
                    radius: 25,
                    child: CrashSafeImage(
                      Assets.images.fileExchanged.keyName,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
              heightBox20,
              StatusBar(
                firstName: 'You have Exchanged',
                firstBgColor: const Color(0xffEBF2EE),
                firtsIconColor: null,
                firstIconPath: Assets.images.group02.keyName,
                secondName: status == 'decline'
                    ? 'Approval denied'
                    : status == 'rejected'
                    ? 'Approval rejected'
                    : 'Waiting for approval',
                secondBgColor: status == 'decline' || status == 'rejected'
                    ? Color(0xffFFE6E6)
                    : status == 'requested'
                    ? const Color(0xffECECEC)
                    : const Color(0xffEBF2EE),
                secondIconColor: status == 'decline' || status == 'rejected'
                    ? Color(0xffBF0000)
                    : status == 'requested'
                    ?  Colors.grey
                    : null,
                secondIconPath: Assets.images.group02.keyName,
                thirdName: 'Let’s get exchange',
                thirdBgColor: status == 'approved' || status == 'accepted'
                    ? const Color(0xffEBF2EE)
                    : Color(0xffECECEC),
                thirdIconColor: status == 'approved' || status == 'accepted' ? null : Colors.grey,
                thirdIconPath: Assets.images.group02.keyName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StageWidget extends StatelessWidget {
  const StageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xffEBF2EE),
          radius: 25,
          child: CrashSafeImage(
            Assets.images.group02.keyName,
            height: 20,
            width: 20,
          ),
        ),
        heightBox4,
        SizedBox(
          width: 60,
          child: Text(
            'You have Exchanged',
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class FlowWidget extends StatelessWidget {
  const FlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 45, height: 1, color: Color(0xffECECEC)),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffEBF2EE),
          ),
        ),
      ],
    );
  }
}
