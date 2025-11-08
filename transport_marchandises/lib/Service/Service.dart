import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/apiConfig.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: Duration(seconds: ApiConfig.connectTimeout),
        receiveTimeout: const Duration(seconds: ApiConfig.receiveTimeout),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  void setAuthorizationToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<dynamic> get(String path) async {
    final response = await dio.get(path);
    return response.data;
  }

  Future<dynamic> patch(String path, {Map<String, dynamic>? data}) async {
    final response = await dio.patch(path, data: data);
    return response.data;
  }

  // mes ajour image ou ajouter
  Future<dynamic> patchImage(
    path,
    Map<String, dynamic> imageProfileBytes,
  ) async {
    MultipartFile file = MultipartFile.fromBytes(
      imageProfileBytes["image_profile"],
      filename: "image_${DateTime.now().microsecondsSinceEpoch}.jpg",
    );
    imageProfileBytes["image_profile"] = file;
    FormData formData = FormData.fromMap(imageProfileBytes);
    final response = await dio.patch(
      path,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    return response.data;
  }

  Future<dynamic> delete(String path) async {
    final response = await dio.delete(path);
    return response.data;
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? data}) async {
    try {
      dynamic response;
      if (data != null && data["image_profile"] != null) {
        MultipartFile file = MultipartFile.fromBytes(
          data["image_profile"],
          filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        data["image_profile"] = file;
        FormData formData = FormData.fromMap(data);

        response = await dio.post(
          path,
          data: formData,
          options: Options(contentType: 'multipart/form-data'),
        );
      } else {
        response = await dio.post(
          path,
          data: data,
          options: Options(contentType: 'application/json'),
        );
      }

      return response.data;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
