import 'package:flutter/material.dart';
import 'package:marketi/features/home/data/models/product_model.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,

    required this.addButton,
    this.productModel,
  });
  final ProductModel? productModel;
  final bool addButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //top part
              Container(
                height: 96,
                width: 145,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffD9E6FF),
                  // image: DecorationImage(image: AssetImage(imagePath)),
                ),
                //favorite icon
                child: Stack(
                   alignment: Alignment.center,

                  children: [
                    
                  productModel?.imageUrl != null
    ? Image.network(productModel!.imageUrl!)
    : const Icon(Icons.image_not_supported),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
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
                              Icons.favorite_border_outlined,
                              size: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 145,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text(
                          '${productModel!.price} LE',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                
                      Text(
                        '\u{2606} ${productModel!.rating} ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: 160,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    productModel!.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              addButton
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5, top: 5),
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
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
