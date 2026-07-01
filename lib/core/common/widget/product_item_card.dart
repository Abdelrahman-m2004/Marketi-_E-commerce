import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.productName,
    required this.addButton,
  });
  final String imagePath;
  final String price;
  final String rating;
  final String productName;
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
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top part
              Container(
                height: 96,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffD9E6FF),
                  // image: DecorationImage(image: AssetImage(imagePath)),
                ),
                //favorite icon
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(imagePath),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 65),
                      child: Text(
                        '$price LE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      '\u{2606} $rating ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  productName,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),

              addButton? Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 5
                  ),
                child: Container(
                 
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Color(0xff3F80FF), width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 56,
                      vertical: 3,
                    ),
                    child: Center(
                      child: Text('Add',
                      style: TextStyle(
                        color: Color(0xff3F80FF),
                        fontSize: 14
                      ),
                      ),
                    ),
                  ),
                ),
              ):SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
