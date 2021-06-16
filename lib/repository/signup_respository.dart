import 'package:demo_app/models/user_model.dart';
import 'package:demo_app/networking/api_request_helper.dart';

class SignUpRepository {
  APIRequestHelper helper = APIRequestHelper();

  Future<UserModel> signUpUser(Map<String, dynamic> parameters) async {
    var response = await helper.push(APITag.signUp, parameters);
    return UserModel.fromJson(response);
  }
}
