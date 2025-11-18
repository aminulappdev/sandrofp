import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/modules/home/widget/feature_row.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart' show Assets;

class ExchangeCard extends StatelessWidget {
  final bool isShowButton;
  final bool isShowHeader;

  final String? exchangeName;
  final String? requestsForm;
  final String? requestsTo;
  final String? requestsDate;
  final String? approvedDate;
  final VoidCallback? onTap;
  const ExchangeCard({
    super.key,
    this.isShowButton = false,
    this.isShowHeader = false,
    this.exchangeName,
    this.requestsForm,
    this.requestsTo,
    this.requestsDate,
    this.approvedDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isShowHeader
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Processing Details',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        heightBox4,
                        Text(
                          'On time we got your exchange offer',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        heightBox16,
                      ],
                    )
                  : Container(),
              FeatureRow(
                title: 'Exchange Name',
                widget: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFFFCEB),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      exchangeName ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffCCB12E),
                      ),
                    ),
                  ),
                ),
              ),
              heightBox20,
              FeatureRow(
                title: 'Request from:',
                widget: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF3F3F5),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        CrashSafeImage(
                          Assets.images.person.keyName,
                          height: 14,
                          width: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        widthBox8,
                        Text(
                          requestsForm ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              heightBox20,
              FeatureRow(
                title: 'Request to:',
                widget: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF3F3F5),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        CrashSafeImage(
                          Assets.images.person.keyName,
                          height: 14,
                          width: 14,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        widthBox8,
                        Text(
                          requestsTo ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              heightBox20,
              FeatureRow(
                title: 'Request date:',
                widget: Text(
                  requestsDate ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              heightBox20,
              FeatureRow(
                title: 'Approval date:',
                widget: Text(
                  approvedDate ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

              heightBox10,
              isShowButton
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        title: 'View Details',
                        onPress: () {
                          onTap;
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
