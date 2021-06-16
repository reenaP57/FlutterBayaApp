import 'package:demo_app/blocs/signup_bloc.dart';
import 'package:demo_app/models/user_model.dart';
import 'package:demo_app/repository/country_repository.dart';
import 'package:demo_app/utils/alertview.dart';
import 'package:demo_app/utils/constant.dart';
import 'package:demo_app/utils/generic_class/generic_button.dart';
import 'package:demo_app/utils/generic_class/generic_textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:demo_app/utils/extend_string.dart';
import 'package:http/http.dart' as http;
import 'package:demo_app/models/country_model.dart';
import 'package:demo_app/blocs/country_bloc.dart';
import 'package:demo_app/networking/api_response.dart';
import 'package:demo_app/utils/loading_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isRememberMe = false;
  bool isTermsConditions = false;

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var pwdController = TextEditingController();
  var confirmPwdController = TextEditingController();
  var mobileNoController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  CountryRepository countryRepository = CountryRepository();
  CountryModel selectedCountry;

  CountryBloc countryBloc;
  SignUpBloc signUpBloc;

  @override
  void initState() {
    super.initState();
    // countryBloc = CountryBloc();
    signUpBloc = SignUpBloc();
    selectedCountry = countryRepository.countryList.countryList.first;

    // APIRequest().isConnected().then((isConnected) {
    //   if (isConnected) {
    //     setState(() {
    //       // countryList = APIRequest().getContryList();
    //     });
    //   } else {
    //     /// Internet not avilable
    //   }
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      resizeToAvoidBottomInset: false,
      body: signUpView(),
    );
  }

  // Widget streamBuilderView() {
  //   return RefreshIndicator(
  //       child: Center(
  //           child: StreamBuilder<APIResponse<CountryListModel>>(
  //               stream: countryBloc.countryListStream,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasData) {
  //                   switch (snapshot.data.status) {
  //                     case Status.Loading:
  //                       return LoadingView(loadingMessage: 'Loading...');
  //                     case Status.Done:
  //                       countryList = snapshot.data.data;
  //                       return signUpView();
  //                     case Status.Error:
  //                       return Text(snapshot.data.message);
  //                   }
  //                 }
  //               })),
  //       onRefresh: () => countryBloc.fetchCountryList());
  // }

  Widget signUpView() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/LRF/bg.jpg'), fit: BoxFit.cover)),
      child: Center(
        child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: fNameController,
                        decoration: CommonTextField().appDecorationStyle(
                            'First Name',
                            'First Name',
                            FontWeight.normal,
                            FontWeight.normal,
                            14.0,
                            13.0,
                            Colors.grey,
                            Colors.red,
                            5),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return messageBlankFName;
                          } else if (value.isValidName()) {}
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: lNameController,
                      decoration: CommonTextField().appDecorationStyle(
                          'Last Name',
                          'Last Name',
                          FontWeight.normal,
                          FontWeight.normal,
                          14.0,
                          13.0,
                          Colors.grey,
                          Colors.red,
                          5),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return messageBlankLName;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: CommonTextField().appDecorationStyle(
                          'Email',
                          'Email',
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
                        } else if (value.isValidEmail() == false) {
                          return messageInValidEmail;
                        }
                      },
                    ),
                  ),
                  mobileNumberField(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: pwdController,
                      decoration: CommonTextField().appDecorationStyle(
                          'Password',
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
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: confirmPwdController,
                      decoration: CommonTextField().appDecorationStyle(
                          'Confirm Password',
                          'Confirm Password',
                          FontWeight.normal,
                          FontWeight.normal,
                          14.0,
                          13.0,
                          Colors.grey,
                          Colors.red,
                          5),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return messageBlankConfirmPassword;
                        } else if (value != pwdController.text) {
                          return messageDoesNotMatchPassword;
                        }
                      },
                    ),
                  ),
                  rememberMe(),
                  termsConditionView(),
                  CommonButton().appButton(
                      screenWidth(context) - 40,
                      screenWidth(context) * 55 / 375,
                      EdgeInsets.only(
                          left: 20.0,
                          top: screenWidth(context) * 30 / 375,
                          right: 20.0,
                          bottom: 0.0),
                      'Sign Up',
                      Colors.white,
                      20,
                      FontWeight.bold, () {
                    if (formKey.currentState.validate()) {
                      print('Click on Register');
                      signupUser();
                    }
                  }),
                ],
              ),
            )),
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
      value: selectedCountry,
      onChanged: (selectedCountry) {
        setState(() {
          this.selectedCountry = selectedCountry;
        });
      },
    ));
  }

  // Widget countryDropdownField() {
  //   return Flexible(
  //     // child: SizedBox(
  //     // width: (screenWidth(context) * 70 / 375),
  //     // height: (screenWidth(context) * 45 / 375),
  //     child: FutureBuilder<CountryListModel>(
  //         future: countryList,
  //         builder: (context, snapshot) {
  //           switch (snapshot.connectionState) {
  //             case ConnectionState.done:
  //               {
  //                 if (snapshot.hasData) {
  //                   if (snapshot.data.countryList.length > 0) {
  //                     return DropdownButtonFormField<CountryModel>(
  //                       items: snapshot.data.countryList.map((newValue) {
  //                         return DropdownMenuItem<CountryModel>(
  //                           value: newValue,
  //                           child: Text(
  //                             newValue.countryCode,
  //                             style: CommonTextField().commonTextStyle(
  //                                 Colors.grey, 14, FontWeight.normal),
  //                           ),
  //                         );
  //                       }).toList(),
  //                       onChanged: (changedValue) {
  //                         setState(() {
  //                           selectedCountry = changedValue;
  //                         });
  //                       },
  //                       value: selectedCountry,
  //                     );
  //                   }
  //                 }
  //                 break;
  //               }
  //
  //             case ConnectionState.waiting:
  //               {
  //                 print('Waiting ============');
  //                 break;
  //               }
  //
  //             case ConnectionState.none:
  //               {
  //                 print('None=========');
  //                 break;
  //               }
  //
  //             case ConnectionState.active:
  //               {
  //                 print('Active=========');
  //                 break;
  //               }
  //           }
  //         }),
  //     // ),
  //   );
  // }

  Widget mobileNumberField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Container(
        height: (screenWidth(context) * 45 / 375),
        child: Row(
          children: [
            countryDropdownField(),
            Container(
              width: 10,
            ),
            Expanded(
                child: TextFormField(
              controller: mobileNoController,
              decoration: CommonTextField().appDecorationStyle(
                  'Mobile Number',
                  'Mobile Number',
                  FontWeight.normal,
                  FontWeight.normal,
                  14.0,
                  13.0,
                  Colors.grey,
                  Colors.red,
                  5),
              validator: (String value) {
                if (value.isEmpty) {
                  return messageBlankMobileNo;
                } else if (value.length != 10) {
                  return messageValidMobileNo;
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget rememberMe() {
    return Row(
      children: [
        Checkbox(
            value: isRememberMe,
            onChanged: (bool value) {
              setState(() {
                isRememberMe = value;
              });
            }),
        Text(
          'Remember Me',
          style: CommonTextField()
              .commonTextStyle(Colors.grey, 14, FontWeight.normal),
        )
      ],
    );
  }

  Widget termsConditionView() {
    return Row(
      children: [
        Checkbox(
            value: isTermsConditions,
            onChanged: (bool value) {
              setState(() {
                isTermsConditions = value;
              });
            }),
        Flexible(
            child: Text(
          'I Agree with the Terms & Conditions for the Baya App.',
          style: CommonTextField()
              .commonTextStyle(Colors.grey, 14, FontWeight.normal),
        ))
      ],
    );
  }

  signupUser() {
    Map<String, dynamic> params = {
      'firstName': fNameController.text,
      'lastName': lNameController.text,
      'email': emailController.text,
      'mobileNo': mobileNoController.text,
      'countryId': selectedCountry.countryID.toString(),
      'password': confirmPwdController.text
    };

    LoadingView().showLoaderWithTitle(true, context);
    signUpBloc.signUpUser(params);

    signUpBloc.signUpUserStream.listen((snapShot) {
      switch (snapShot.status) {
        case Status.Loading:
          return LoadingView(
            loadingMessage: snapShot.message,
          );
        case Status.Done:
          LoadingView().showLoaderWithTitle(false, context);
          if ((snapShot.data.meta as UserMeta).status != 0) {
            AlertView().showAlertView(
                context, (snapShot.data.meta as UserMeta).message, () {});
          } else {
            print('Else');
          }
          break;
        case Status.Error:
          AlertView().showAlertView(
              context, snapShot.message, () {});
          ;
      }
    });
  }
}
