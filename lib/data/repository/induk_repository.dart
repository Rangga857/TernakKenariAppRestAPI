import 'dart:convert';

import 'package:canaryfarm/data/model/request/admin/induk_request_model.dart';
import 'package:canaryfarm/data/model/response/get_all_induk_response.dart';
import 'package:canaryfarm/service/service_http_client.dart';
import 'package:dartz/dartz.dart';

class IndukRepository {
  final ServiceHttpClient _serviceHttpClient;

  IndukRepository(this._serviceHttpClient);

  Future<Either<String, GetAllIndukResponse>> addInduk(
    IndukRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/induk",
        requestModel.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profilResponse = GetAllIndukResponse.fromJson(jsonResponse);
        return Right(profilResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding induk: $e");
    }
  }

  Future<Either<String, GetAllIndukResponse>> getAllInduk() async {
    try {
      final response = await _serviceHttpClient.get("admin/induk");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profilResponse = GetAllIndukResponse.fromJson(jsonResponse);
        return Right(profilResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while getting all induk: $e");
    }
  }
}
