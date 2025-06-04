import 'package:canaryfarm/data/model/request/auth/request_model.dart';

sealed class RegisterEvent {}

class RegisterRequested extends RegisterEvent {
  final RegisterRequestModel requestModel;

  RegisterRequested({required this.requestModel});
}
