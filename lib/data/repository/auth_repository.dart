import 'dart:convert';

import 'package:canaryfarm/data/model/request/auth/login_request_model.dart';
import 'package:canaryfarm/data/model/request/auth/request_model.dart';
import 'package:canaryfarm/data/model/response/login_response_model.dart';
import 'package:canaryfarm/service/service_http_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dartz/dartz.dart';

class AuthRepository {
  final ServiceHttpClient _servicehttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._servicehttpClient);
  
  Future<Either<String, LoginResponseModel>>login(
    LoginRequestModel requestModel,
  ) async{
      try{
        final response = await _servicehttpClient.post(
        "login",
        body: requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200){
        final loginResponse = LoginResponseModel.fromMap(jsonResponse);
        await secureStorage.write(
          key: "authToken", 
          value: loginResponse.data!.token,
        );
        await secureStorage.write(
          key: "userRole", 
          value: loginResponse.data!.role,
        );
        return Right(loginResponse);
      }else{
        return Left(jsonResponse['message'] ?? 'An error occurred');
      }
    } catch(e){
      return Left('An error occurred: $e');
    }
  }
  Future<Either<String, String>> register(RegisterRequestModel requestModel) async{
    try{
      final response = await _servicehttpClient.post(
        "register",
        body: requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      final registerResponse = jsonResponse['message'];
      if (response.statusCode == 201){
        return Right(registerResponse);
      }else{
        return Left(jsonResponse['message'] ?? 'Registration failed');
      }
    } catch(e){
      return Left('An error occurred while registering: $e');
    }
  } 
}