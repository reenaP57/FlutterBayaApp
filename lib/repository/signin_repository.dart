import 'package:demo_app/networking/api_request_helper.dart';
import 'package:demo_app/models/user_model.dart';

class SignInRepository {
  APIRequestHelper helper = APIRequestHelper();

  Future<UserModel> signInUser(Map<String, dynamic> parameters) async {
    var response = await helper.pushMultiFormData(APITag.login, parameters);
    return UserModel.fromJson(response);
  }
}
