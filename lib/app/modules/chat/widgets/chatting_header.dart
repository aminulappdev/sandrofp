
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        image: DecorationImage(
          image: AssetImage(Assets.images.background.keyName),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CircleAvatar(
            
                      backgroundImage: AssetImage(
                          Assets.images.onboarding01.keyName),
                      radius: 20,),
                    widthBox10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aminul Islam',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Aminul is typing...',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFDD3A),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sandrofp/app/res/custom_style/custom_size.dart';

// class CustomChatAppBar extends StatefulWidget {
//   final String name;
//   final String activeStatus;
//   final String imagePath;
//   final bool isActive;
//   final VoidCallback actionOntap;
//   const CustomChatAppBar({
//     super.key,
//     required this.name,
//     required this.activeStatus,
//     required this.imagePath,
//     required this.isActive,
//     required this.actionOntap,
//   });

//   @override
//   State<CustomChatAppBar> createState() => _CustomChatAppBarState();
// }

// class _CustomChatAppBarState extends State<CustomChatAppBar> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 SizedBox(width: 8),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey.shade200,
//                     radius: 14,
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.black,
//                       size: 16,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 InkWell(
//                   onTap: () {},
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.transparent,
//                         backgroundImage: AssetImage(widget.imagePath),
//                         radius: 24.r,
//                       ),
//                       widthBox5,
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Sara',
//                             style: GoogleFonts.poppins(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Active now  ',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               CircleAvatar(
//                                 radius: 4,
//                                 backgroundColor: widget.isActive
//                                     ? Colors.green
//                                     : Colors.red,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             InkWell(
//               onTap: widget.actionOntap,
//               child: Icon(Icons.more_vert, size: 30.h, color: Colors.black),
//             ),
//           ],
//         ),
//         heightBox10,
        
//       ],
//     );
//   }
// }