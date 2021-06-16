import 'dart:async';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/repository/signup_respository.dart';
import 'package:demo_app/models/user_model.dart';

class SignUpBloc {

  SignUpRepository signUpRepository;
  StreamController signUpController;

  StreamSink<APIResponse<UserModel>> get signUpUserInfo => signUpController.sink;
  Stream<APIResponse<UserModel>> get signUpUserStream => signUpController.stream;

  SignUpBloc() {
    signUpRepository = SignUpRepository();
    signUpController = StreamController<APIResponse<UserModel>>.broadcast();
  }

  signUpUser(Map<String, dynamic> parameters) async {

    signUpUserInfo.add(APIResponse.loading ('Processing'));
    try {
      UserModel response = await signUpRepository.signUpUser(parameters);
      signUpUserInfo.add(APIResponse.done(response));
    } catch (error) {
      signUpUserInfo.add(APIResponse.error(error.toString()));
    }
  }

  dispose() {
    signUpController.close();
  }
}