import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import '../models/response/auth_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      await AuthLocalDatasource()
          .saveAuthData(AuthResponseModel.fromJson(response.body));
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left("Login Gagal");
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http
        .post(url, headers: {'Authorization': 'Bearer ${authData?.token}'});
    if (response.statusCode == 200) {
      await AuthLocalDatasource().removeAuthData();
      return const Right("Logout Berhasil");
    } else {
      return const Left("Logout Gagal");
    }
  }
}
