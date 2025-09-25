import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/common_widgets/category_widget.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/common_widgets/straight_liner.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  CircleIconWidget(
                    imagePath: Assets.images.cross.path,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              heightBox4,
              Text(
                'Please choose categories so that app can suggests you to find er appropriate products',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              heightBox20,
              Text(
                'Location',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,

              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Change',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              heightBox40,

              Text(
                '0.3km',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),

              SfSlider(
                activeColor: AppColors.greenColor,
                min: 0.0,
                max: 100.0,
                value: 50.0,
                interval: 20,
                showTicks: false,
                showLabels: false,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  setState(() {});
                },
              ),

              Text(
                'Categories',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Row(
                children: [
                  CategoryWidget(onTap: () {}, label: 'All'),
                  widthBox10,
                  CategoryWidget(onTap: () {}, label: 'Furniture'),
                  widthBox10,
                  CategoryWidget(
                    bgColor: Colors.black,
                    textColor: Colors.white,
                    onTap: () {},
                    label: 'Clothing',
                  ),
                ],
              ),

              heightBox20,
              StraightLiner(),
              heightBox20,

              Text(
                'Collection Type',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Row(
                children: [
                  CategoryWidget(onTap: () {}, label: 'All'),
                  widthBox10,
                  CategoryWidget(onTap: () {}, label: 'Men'),
                  widthBox10,
                  CategoryWidget(
                    bgColor: Colors.black,
                    textColor: Colors.white,
                    onTap: () {},
                    label: 'Women',
                  ),
                  widthBox10,
                  CategoryWidget(onTap: () {}, label: 'Other'),
                ],
              ),

              heightBox20,
              StraightLiner(),
              heightBox20,

              Text(
                'Collection',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Row(
                children: [
                  CategoryWidget(onTap: () {}, label: 'All'),
                  widthBox10,
                  CategoryWidget(onTap: () {}, label: 'Furniture'),
                  widthBox10,
                  CategoryWidget(
                    bgColor: Colors.black,
                    textColor: Colors.white,
                    onTap: () {},
                    label: 'Clothing',
                  ),
                ],
              ),

              heightBox20,
              StraightLiner(),
              heightBox20,

              Text(
                'Brand',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              heightBox8,
              Row(
                children: [
                  CategoryWidget(onTap: () {}, label: 'All'),
                  widthBox10,
                  CategoryWidget(onTap: () {}, label: 'Men'),
                  widthBox10,
                  CategoryWidget(
                    bgColor: Colors.black,
                    textColor: Colors.white,
                    onTap: () {},
                    label: 'Women',
                  ),
                  widthBox10,
                  CategoryWidget(onTap: () {}, label: 'Other'),
                ],
              ),

              heightBox40,
              CustomElevatedButton(title: 'Filter', onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
