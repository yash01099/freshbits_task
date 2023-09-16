import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_list.dart';
import 'api_utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:freshbits_task/screens/product_detail/model/product_detail_response_model.dart';
import 'package:freshbits_task/screens/products/model/products_response_model.dart';

enum EnumDioMethod {
  get,
  put,
  post,
  delete,
}

class Api {
  Api._();

  static Future<Dio> _getDio(EnumDioMethod enumDioMethod) async {
    Dio dio = Dio();

    dio.options.baseUrl = ApiList.baseUrl;
    dio.options.method = enumDioMethod.toString().split(".").last;

    dio.options.contentType = Headers.jsonContentType;
    if (!kIsWeb) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };
    }

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 70,
      ),
    );
    return dio;
  }

  static Future<List<ProductsResponseModel>> getProducts() async {
    try {
      Response response = await _getDio(EnumDioMethod.get).then((dio) {
        return dio.request(ApiList.products);
      });
      return productsResponseModelFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      ApiUtils.handleApiError(e);
      throw e.response?.data;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<ProductDetailResponseModel> getProductDetail(int id) async {
    try {
      Response response = await _getDio(EnumDioMethod.get).then((dio) {
        return dio.request(ApiList.productDetail(id));
      });
      return ProductDetailResponseModel.fromJson(response.data);
    } on DioError catch (e) {
      ApiUtils.handleApiError(e);
      throw e.response?.data;
    } catch (e) {
      throw e.toString();
    }
  }
}
