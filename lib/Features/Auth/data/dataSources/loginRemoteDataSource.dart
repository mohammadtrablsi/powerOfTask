
import 'package:power_of_task/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entites/LoginEntity.dart';
import '../models/LoginModel.dart';



abstract class LoginRemoteDataSource {
  Future<LoginEntity> makeLogin({required Map<String, dynamic> request});
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final ApiService apiService;

  LoginRemoteDataSourceImpl(this.apiService);

  @override
  Future<LoginEntity> makeLogin(
      {required Map<String, dynamic> request}) async {
    var response = await apiService.post(
        data: request, endPoint: 'https://dummyjson.com/auth/login');
    LoginEntity entity;
    entity = LoginModel.fromJson(response);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', entity.id);
    print("iddddddddddddddddddddddddddddddddddd${entity.id}");
    return entity;
  }

}
