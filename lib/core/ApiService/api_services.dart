import 'package:dio/dio.dart';
import 'package:marketi/core/Network/Apiconstant.dart';


// class ApiServices {
//   late Dio dio;

//   ApiServices() {
//     BaseOptions options = BaseOptions(
//       baseUrl: Apiconstant.baseUrl,
//       receiveDataWhenStatusError: true,
//     );
//     dio = Dio(options);
//   }

//   Future<List<dynamic>> getAll() async {
//     try {
//       Response response = await dio.get(Apiconstant.List_category);
//       print(response.data.toString());
//       return response.data['data'];
//     } catch (e) {
//       print(e.toString());
//     }
//     return [];
//   }
// }

class ApiServices {
  late Dio dio;

  ApiServices() {
    dio = Dio(
      BaseOptions(
        baseUrl: Apiconstant.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  Future<dynamic> get({
    required String endpoint,
  }) async {
    try {
      Response response = await dio.get(endpoint);

      return response.data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}