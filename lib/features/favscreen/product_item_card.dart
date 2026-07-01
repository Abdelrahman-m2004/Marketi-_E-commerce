import 'package:flutter/material.dart';
import 'package:marketi/core/Fonts/AppFonts.dart';
import 'package:marketi/features/favscreen/favmodels/productFavModel.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.FavProduct,
    required this.addButton,
  });
  final productFavModel FavProduct;
  final bool addButton;

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.25, vertical: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffD9E6FF).withValues(alpha: 0.6),
              blurRadius: 9,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top part
              Container(
                height: hight * 0.13,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffD9E6FF),
                ),
                //favorite icon
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 24,
                              width: 24,

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),

                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite,
                                  size: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(
                          FavProduct.imagePath,
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Row(
                  children: [
                    Text('${FavProduct.price} LE', style: AppFonts.bodyMedium),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                    Text(
                      '\u{2606} ${FavProduct.rating} ',
                      style: AppFonts.captionBold,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(FavProduct.productName, style: AppFonts.bodyMedium),
              ),

              addButton
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Color(0xff3F80FF),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 56,
                            vertical: 3,
                          ),
                          child: Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Color(0xff3F80FF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
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
