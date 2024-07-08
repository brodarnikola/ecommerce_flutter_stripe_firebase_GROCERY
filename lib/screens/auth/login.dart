import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/login_model.dart';
import 'package:grocery_app/providers/shared_pref_provider.dart';
import 'package:grocery_app/screens/auth/forget_pass.dart';
import 'package:grocery_app/screens/auth/register.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts/constants.dart';
import '../../consts/firebase_consts.dart';
import '../../fetch_screen.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/google_button.dart';
import '../../widgets/text_widget.dart';

import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        loginUser();
      }
      // on FirebaseException catch (error) {
      //   GlobalMethods.errorDialog(
      //       subtitle: '${error.message}', context: context);
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
      catch (error) {
        print('error in login 2 $error');
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> loginUser() async {
    Map<String, String> loginData = {
      "grant_type": "password",
      "source": "mobileapp",
      'username': _emailTextController.text.toLowerCase().trim(),
      'password': _passTextController.text,
      'uuid': _emailTextController.text
          .toLowerCase()
          .trim(), // "87f05e5908172913", // "e751f0284458d01d", // database.get("DeviceUUID"), // --> e751f0284458d01d  za account ipavelic1@gmail.com
      "deviceOS": "android",
      "notificationRegID":
          "eyJt_vSrRu2sxIQkTK_GSn%3AAPA91bGcxo7a2MvikhTta22e63R7696Z0hxv7hLbVHULjLmaSwN_OovuBRYWuBmXNtXcFHU4rm",
      "languageID": "1"
    };

    String loginRequestText =
        loginData.entries.map((e) => '${e.key}=${e.value}').join('&');

    print('start operation logged in 22');
    developer.log(loginRequestText);

    // String bodyData = json.encode(data);
    final response =
        await http.post(Uri.parse('${Constants.BASE_URL}/token'),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Access-Control-Allow-Origin": "*"
            },
            body: loginRequestText // bodyData,
            );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print('Succefully logged in');
      developer.log("logged in  ${response}");
      developer.log("logged in body ${response.body}");

      // compute(parseLogin, response.body);

      saveData(response.body);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const FetchScreen(),
      ));
    } else {
      print('error in login 1');
      GlobalMethods.errorDialog(
          subtitle: 'Wrong username or password', context: context);
      setState(() {
        _isLoading = false;
      });
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // throw Exception('Failed to load album');
    }
  }

  User parseLogin(String responseBody) {
    developer.log("start computing login response");
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    developer.log(parsed);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  void saveData(String responseBody) async {
    
    final sharedPrefState =
        Provider.of<SharedPrefsProvider>(context, listen: false);
    
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    final String firstName = parsed['firstName'];
    final String lastName = parsed['lastName'];
    final String email = parsed['email'];

    setState(() {
      sharedPrefState.setIsLoggedIn = true;
      sharedPrefState.setUsername = "$firstName $lastName";
      sharedPrefState.setEmail = email;
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool(isLoggedIn, true);
    // await prefs.setString(usernameSP, username);
    // await prefs.setString(emailSP, email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(children: [
          Swiper(
            duration: 800,
            autoplayDelay: 8000,
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                Constants.authImagesPaths[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
            itemCount: Constants.authImagesPaths.length,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 120.0,
                  ),
                  TextWidget(
                    text: 'Welcome Back',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    text: "Sign in to continue",
                    color: Colors.white,
                    textSize: 18,
                    isTitle: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                            controller: _emailTextController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          //Password

                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              _submitFormOnLogin();
                            },
                            controller: _passTextController,
                            focusNode: _passFocusNode,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid password';
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  )),
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context,
                            routeName: ForgetPasswordScreen.routeName);
                      },
                      child: const Text(
                        'Forget password?',
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthButton(
                    fct: _submitFormOnLogin,
                    buttonText: 'Login',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const GoogleButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextWidget(
                        text: 'OR',
                        color: Colors.white,
                        textSize: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthButton(
                    fct: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FetchScreen(),
                        ),
                      );
                    },
                    buttonText: 'Continue as a guest',
                    primary: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          children: [
                        TextSpan(
                            text: '  Sign up',
                            style: const TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GlobalMethods.navigateTo(
                                    ctx: context,
                                    routeName: RegisterScreen.routeName);
                              }),
                      ]))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
