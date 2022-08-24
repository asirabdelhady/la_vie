import 'package:dio/dio.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/data/web_services/end_points.dart';

class DioHelper{

   static var token='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyMDA0OTdjYS0zNDYwLTQ3NDctYWI3YS04NTUyMWYyY2E0ZjkiLCJpYXQiOjE2NjEyNDQxODcsImV4cCI6MTY2MTQxNjk4N30.emRP0Sv4wjq9JjdRaXvDqN7oR1gpX6WZzCUZ_efyyGo';

   static  Dio dio= Dio(
       BaseOptions(
         baseUrl: BASEURL,
         receiveDataWhenStatusError: true,

         headers: {
           'Content-Type':'application/json',
           'Accept':'application/json',

         },
       )
   );

   /*static init(){
     dio= Dio(
       BaseOptions(
         baseUrl: 'https://lavie.orangedigitalcenteregypt.com',
         receiveDataWhenStatusError: true,
         headers: {
           'Content-Type':'application/json',
           'Authorization': 'Bearer: ${SharedKeys.token}',
         },

       )
     );
   }*/

   static Future<Response> getData({
     required String url,
     Map<String, dynamic>? query,
     dynamic token
   }) async{
     dio.options.headers={'Authorization': 'Bearer $token'};
     return await dio.get(url, queryParameters: query);
   }

   static Future<Response> postData({
     required String url,
     Map<String, dynamic>? query,
     dynamic token,
     required Map<String, dynamic>? data
   })async {
     dio.options.headers={'Authorization': 'Bearer $token'};
     return dio.post(url, queryParameters: query, data: data);
   }

}

