import 'dart:convert';

import 'package:toko_klontong_gema/data/remote/endpoint/endpoint.dart';
import 'package:toko_klontong_gema/data/remote/exceptions/exception_handler.dart';
import 'package:toko_klontong_gema/features/product/domain/models/product_crud_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductCrudModel>> requestProduct() async {
    try {
      final response = await http
          .get(Uri.parse(Endpoints.baseURL))
          .timeout(const Duration(seconds: Endpoints.connectionTimeout));

      final List<dynamic> data = json.decode(response.body);
      // print("${response.statusCode} | REPOSITORY RESPONSE => $data");
      if (response.statusCode == 200) {
        final List<ProductCrudModel> products =
            data.map((json) => ProductCrudModel.fromJson(json)).toList();
        return products;
      } else {
        throw ErrorHandlers.getErrorMessage(response);
      }
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }
  }
}
