import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_app/models/country_model.dart';
import 'package:demo_app/models/user_model.dart';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/repository/country_repository.dart';
import 'package:demo_app/utils/alertview.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/loading_view.dart';
import 'package:demo_app/view/LRF/forgot_password_screen.dart';
import 'package:demo_app/view/LRF/signup_screen.dart';
import 'package:demo_app/view/tabbar/tab_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:demo_app/utils/generic_class/generic_button.dart';
import 'package:flutter/rendering.dart';
import 'package:demo_app/blocs/country_bloc.dart';
import 'package:demo_app/blocs/signin_bloc.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // Future<CountryListModel> countryList;
  CountryRepository countryRepository = CountryRepository();
  CountryModel selectedCountry;

  var emailController = TextEditingController();
  var pwdController = TextEditingController();

  var isSelectedRememberMe = false;
  var formKey = GlobalKey<FormState>();

  CountryBloc bloc;
  SignInBloc signInBloc;

  @override
  void initState() {
    super.initState();
    // bloc = CountryBloc();
    signInBloc = SignInBloc();
    selectedCountry = countryRepository.countryList.countryList.first;

    emailController.text = 'sejal.mindinventory@gmail.com';
    pwdController.text = "mind@123";
    // setState(() {
    //   countryList = bloc.fetchCountryList();
    // });

    // APIRequest().isConnected().then((isConnected) {
    //   if (isConnected) {
    //     setState(() {
    //       countryList = APIRequest().getContryList();
    //     });
    //   }
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: signInView(),
    );
  }

  // Widget streamBuilderView() {
  //   return RefreshIndicator(
  //       child: Center(
  //           child: StreamBuilder<APIResponse<CountryListModel>>(
  //               stream: bloc.countryListStream,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasData) {
  //                   switch (snapshot.data.status) {
  //                     case Status.Loading:
  //                       return LoadingView(loadingMessage: 'Loading...');
  //                     case Status.Done:
  //                       countryList = snapshot.data.data;
  //                       return signInView();
  //                     case Status.Error:
  //                       return Text(snapshot.data.message);
  //                   }
  //                 }
  //               })),
  //       onRefresh: () => bloc.fetchCountryList());
  // }

  Widget signInView() {
    return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              appLogo(),
              mobileNumberField(),
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: pwdController,
                    decoration: CommonTextField().appDecorationStyle(
                        'Enter Password',
                        'Password',
                        FontWeight.normal,
                        FontWeight.normal,
                        14.0,
                        13.0,
                        Colors.grey,
                        Colors.red,
                        5),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return messageBlankPassword;
                      }
                    },
                  )),
              rememberMeView(),
              CommonButton().appButton(
                  screenWidth(context) - 40,
                  screenWidth(context) * 55 / 375,
                  EdgeInsets.only(
                      left: 20.0,
                      top: screenWidth(context) * 30 / 375,
                      right: 20.0,
                      bottom: 0.0),
                  'Sign In',
                  Colors.white,
                  20,
                  FontWeight.bold, () {
                print('Sign In Clicked');
                if (formKey.currentState.validate()) {
                  userSignIn();
                }
              }),
              newUserSignUpView(),
            ],
          ),
        ));
  }

  Widget appLogo() {
    return Center(
      child: Image(
        image: AssetImage('images/LRF/baya_logo.png'),
        width: 200,
        height: 200,
      ),
    );
  }

  Widget mobileNumberField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        child: Row(
          children: [
            countryDropdownField(),
            Container(
              width: 10,
            ),
            Expanded(
                child: TextFormField(
              controller: emailController,
              decoration: CommonTextField().appDecorationStyle(
                  'Enter mobile number or email',
                  'Mobile No/Email',
                  FontWeight.normal,
                  FontWeight.normal,
                  14.0,
                  13.0,
                  Colors.grey,
                  Colors.red,
                  5),
              validator: (String value) {
                if (value.isEmpty) {
                  return messageBlankEmail;
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget countryDropdownField() {
    return Flexible(
        child: DropdownButtonFormField<CountryModel>(
      items: countryRepository.countryList.countryList.map((item) {
        return DropdownMenuItem<CountryModel>(
          value: item,
          child: Text(
            item.countryCode,
            style: CommonTextField()
                .commonTextStyle(Colors.grey, 14, FontWeight.normal),
          ),
        );
      }).toList(),
      value: this.selectedCountry,
      onChanged: (selectedCountry) {
        setState(() {
          this.selectedCountry = selectedCountry;
        });
      },
    ));
  }

  // Widget countryDropdownField() {
  //   return Flexible(
  //     child: FutureBuilder<CountryListModel>(
  //         future: countryList,
  //         builder: (context, snapshot) {
  //           switch (snapshot.connectionState) {
  //             case ConnectionState.done:
  //               {
  //                 if (snapshot.hasData &&
  //                     snapshot.data.countryList.length > 0) {
  //                   return DropdownButtonFormField<CountryModel>(
  //                     items: snapshot.data.countryList.map((item) {
  //                       return DropdownMenuItem<CountryModel>(
  //                         value: item,
  //                         child: Text(
  //                           item.countryCode,
  //                           style: CommonTextField().commonTextStyle(
  //                               Colors.grey, 14, FontWeight.normal),
  //                         ),
  //                       );
  //                     }).toList(),
  //                     value: selectedCountry,
  //                     onChanged: (selectedCountry) {
  //                       setState(() {
  //                         this.selectedCountry = selectedCountry;
  //                       });
  //                     },
  //                   );
  //                 }
  //               }
  //           }
  //         }),
  //   );
  // }

  Widget rememberMeView() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Checkbox(
                    value: isSelectedRememberMe,
                    onChanged: (bool value) {
                      setState(() {
                        isSelectedRememberMe = value;
                      });
                    }),
                Text('Remember Me'),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {
                redirectOnForgotPasswordScreen();
              },
              child: Text(
                'Forgot Password?',
                style: CommonTextField()
                    .commonTextStyle(Colors.green, 14, FontWeight.w400),
              )),
        )
      ],
    );
  }

  Widget newUserSignUpView() {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SignUpView();
            }));
          },
          child: Text(
            'New User? Sign Up',
            style: CommonTextField()
                .commonTextStyle(Colors.grey, 14, FontWeight.w500),
          )),
    );
  }

  void redirectOnForgotPasswordScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ForgotPasswordView();
    }));
  }

  void userSignIn() {
    Map<String, dynamic> params = {
      'userName': emailController.text,
      'password': pwdController.text,
      'countryId': selectedCountry.countryID,
      'type': '1',
      'deviceInfo': {
        'platform': 'IOS',
        'deviceVersion': 'Iphone X',
        'deviceOS': '14.0',
        'appVersion': '3.0'
      }
    };

    LoadingView().showLoaderWithTitle(true, context);
    signInBloc.signInUser(params);

    final subscription = signInBloc.userInfoStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.Loading:
          break;
        case Status.Done:
          LoadingView().showLoaderWithTitle(false, context);
          if ((snapshot.data.meta as UserMeta).status == 0) {
            //...Store User Token in Share Preferences
            storeUserToken((snapshot.data.meta as UserMeta).token);

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabPages()));
          }
          break;
        case Status.Error:
          return AlertView().showAlertView(context, snapshot.message, () {});
      }
    });
  }

  storeUserToken(String token) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('UserToken', token);
  }
}
