import 'dart:async';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/repository/signin_repository.dart';
import 'package:demo_app/models/user_model.dart';

class SignInBloc {

  SignInRepository signInRepository;
  StreamController userController;

  StreamSink<APIResponse<UserModel>> get userInfoSink => userController.sink;
  Stream<APIResponse<UserModel>> get userInfoStream => userController.stream;

  SignInBloc() {
    signInRepository = SignInRepository();
    userController = StreamController<APIResponse<UserModel>>.broadcast();
  }

  signInUser(Map<String, dynamic> parameters) async {
    userInfoSink.add(APIResponse.loading('Processing...'));
    try {
      UserModel response = await signInRepository.signInUser(parameters);
      userInfoSink.add(APIResponse.done(response));
    } catch (error) {
      userInfoSink.add(APIResponse.error(error.toString()));
    }
  }

  dispose() {
    userController.close();
  }
}