
import 'package:dio/dio.dart';
import 'package:expense_manager/core/constants/api_endpoints.dart';
import 'package:expense_manager/core/services/dio_client.dart';
import 'package:expense_manager/core/utils/error.dart';
import '../models/auth_response_model.dart';

class AuthRepository {
  final dio = DioClient().client;

  Future<AuthResponseModel> sendOtp(String phone) async {
    try {
      final res = await dio.post(
        ApiEndpoints.sendOtp,
        data:{"phone": phone},
      );
      return AuthResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      final message = ErrorHelper.getErrorMessage(e);
      throw Exception(message);
    } catch (e) {
      final message = ErrorHelper.getErrorMessage(e);

      throw Exception(message);
    }
  }

  // Future<AuthResponseModel> login(String phone, String otp) async {
  //   final res = await dio.post(
  //     "/auth/login/",
  //     data: FormData.fromMap({
  //       "phone": phone,
  //       "otp": otp,
  //     }),
  //   );

  //   return AuthResponseModel.fromJson(res.data);
  // }

  Future<AuthResponseModel> createAccount(String phone, String nickname) async {
    try {
      final res = await dio.post(
        ApiEndpoints.createAccount,
        data: FormData.fromMap({"phone": phone, "nickname": nickname}),
      );

      return AuthResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      final message = ErrorHelper.getErrorMessage(e);

      throw Exception(message);
    } catch (e) {
      final message = ErrorHelper.getErrorMessage(e);

      throw Exception(message);
    }
  }
}
