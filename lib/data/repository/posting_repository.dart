import 'dart:convert';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:canaryfarm/data/model/request/admin/posting_jual_request_model.dart';
import 'package:canaryfarm/data/model/response/burung_semua_tersedia_model.dart';
import 'package:canaryfarm/service/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PostingRepository {
  final ServiceHttpClient _serviceHttpClient;

  PostingRepository(this._serviceHttpClient);

  Future<Either<String, BurungSemuaTersediaModel>> addPostBurung(
    PostingJualRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        'admin/posting-jual',
        requestModel.toJson(),
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 201) {
        final profileResponse = BurungSemuaTersediaModel.fromJson(jsonResponse);
        log("Add Burung successful: ${profileResponse.message}");
        return Right(profileResponse);
      } else {
        log("Add burung failed: ${jsonResponse["message"]}");
        return Left(jsonResponse['message'] ?? "Add burung failed");
      }
    } catch (e) {
      log("Error in Add burung : $e");
      return Left("An error occurred while post burung: $e");
    }
  }

  Future<Either<String, BurungSemuaTersediaModel>> getAllBurung() async {
    try {
      final response = await _serviceHttpClient.get("admin/burung-semua");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final getAllBurung = BurungSemuaTersediaModel.fromJson(jsonResponse);
        return Right(getAllBurung);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? "Get All burung failed");
      }
    } catch (e) {
      return Left("An error occurred while getting all burung: $e");
    }
  }
}
