
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
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
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                        width: 90,
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
                  ),
    
                  Column(
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
                        width: 90,
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
                  ),
    
                  Column(
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
                        width: 90,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
