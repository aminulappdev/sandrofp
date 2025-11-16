// app/modules/cart/widget/product_cart.dart
import 'package:crash_safe_image/crash_safe_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/res/app_colors/app_colors.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class ProductCart extends StatelessWidget {
  final String? productName;
  final String? description;
  final String? productPrice;
  final String? productImage;
  final String? address;
  final String? distance;
  final int quantity;
  final Function(int)? onQuantityChanged;

  const ProductCart({
    super.key,
    this.productName,
    this.productPrice,
    this.productImage,
    this.address,
    this.distance,
    this.quantity = 1,
    this.onQuantityChanged,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 138,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                productImage ?? '',
                height: 138,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),

            widthBox12,

            // Product Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Address + Distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CrashSafeImage(
                                Assets.images.location.keyName,
                                height: 12,
                                width: 12,
                              ),
                              widthBox8,
                              Expanded(
                                child: Text(
                                  address ?? 'Unknown location',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff595959),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffEBF2EE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${distance ?? '0'} km',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    heightBox8,

                    // Product Name
                    Text(
                      productName ?? 'Unknown Product',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    heightBox4,
                    Text(
                      description ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    heightBox8,

                    // Price + Quantity Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price with Banana
                        Row(
                          children: [
                            CrashSafeImage(
                              Assets.images.banana.keyName,
                              height: 16,
                              width: 16,
                            ),
                            widthBox8,
                            Text(
                              '($productPrice)',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffBFA62C),
                              ),
                            ),
                          ],
                        ),

                        // Quantity Selector
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
