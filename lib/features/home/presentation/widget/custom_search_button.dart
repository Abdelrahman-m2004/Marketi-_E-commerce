import 'package:flutter/material.dart';

// class CustomSearchButton extends StatelessWidget {

//   const CustomSearchButton({super.key,  this.ontap});
//   final VoidCallback? ontap;
//   @override
//   Widget build(BuildContext context) {
//     return  GestureDetector(
//       onTap: ontap,
//       child: Container(
//         height: 44,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(
//             width: 1.5,
//             color: Color(0xffD9E6FF),
//           ),
//         ),
//         child: Row(
//           //  mainAxisAlignment:MainAxisAlignment.spaceBetween,
//           children: [

//           Padding(
//             padding: const EdgeInsets.only(left: 10,right: 25),
//             child: Icon(Icons.search,size: 24,),
//           ),
//           Text('What are you looking for ? ',
//           style: TextStyle(
//             fontWeight: FontWeight(400),
//             fontSize: 16,
//             color: Color(0xff929BAB),
//           ),),
//           Spacer(),
//            Padding(
//              padding: const EdgeInsets.only(right: 10),
//              child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(
//             width: 1,
//             color: Color(0xffD9E6FF),
//           ),
//               ),
//               child: Icon(Icons.tune_sharp,size: 24,color: Color(0xff3F80FF),)),
//            ),
//         ],),
//       ),
//     );
//   }
// }

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({
    super.key,
    this.ontap,
    required this.readOnly,
    this.searchController,
    this.onChanged,
  });
  final VoidCallback? ontap;
  final bool readOnly;
  final TextEditingController? searchController;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        if (!readOnly && onChanged != null) {
          onChanged!(value);
        }
      },
      readOnly: readOnly,
      onTap: ontap,
      decoration: InputDecoration(
        hintText: 'What are you looking for?',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: Color(0xff929BAB),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        prefixIcon: const Icon(Icons.search, size: 32),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffD9E6FF)),
            ),
            child: const Icon(Icons.tune_sharp, color: Color(0xff3F80FF)),
          ),
        ),
        enabledBorder: searchBorder(borderColor: Color(0xffD9E6FF)),
        focusedBorder: searchBorder(borderColor: Color(0xff3F80FF)),
      ),
    );
  }
}

OutlineInputBorder searchBorder({required Color borderColor}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide(color: borderColor, width: 1.5),
  );
}
