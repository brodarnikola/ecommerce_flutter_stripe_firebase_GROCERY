import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/consts/DIO_package/response.dart';
import 'package:grocery_app/fetch_screen.dart';
import 'package:grocery_app/models/login_registration_model.dart';
import 'package:grocery_app/providers/shared_pref_provider.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:provider/provider.dart';

import '../../consts/constants.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_widget.dart';

import 'dart:convert';
import 'dart:developer' as developer;

import 'package:grocery_app/models/album_model.dart';
import 'package:flutter/foundation.dart';

class AccountActivationScreen extends StatefulWidget {
  static const routeName = '/AccountActivationScreen';
  const AccountActivationScreen({Key? key}) : super(key: key);

  @override
  _AccountActivationScreenState createState() =>
      _AccountActivationScreenState();
}

class _AccountActivationScreenState extends State<AccountActivationScreen> {
  final _emailTextController = TextEditingController();
  final _confirmationCodeTextController = TextEditingController();
  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();
    _confirmationCodeTextController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void accountConfirmation() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email address', context: context);
    } else if (_confirmationCodeTextController.text.isEmpty) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct confirmation code',
          context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        var response = await UserNetworkService().accountConfirmation(
            _emailTextController.text.toLowerCase().trim(),
            _confirmationCodeTextController.text.trim());

        if (response.success && response.data != null) {
          final sharedPrefState =
              Provider.of<SharedPrefsProvider>(context, listen: false);

          print('Succefully account confirmation');
          developer.log("Succefully account confirmation in ${response}");
          developer
              .log("Succefully account confirmation in body ${response.data}");

          var loginResponse = await UserNetworkService()
              .loginUser(sharedPrefState.getEmail, sharedPrefState.getPassword);

          if (loginResponse.success && loginResponse.data != null) {
            print('Succefully logged in');
            developer.log("logged in  ${loginResponse}");
            developer.log("logged in body ${loginResponse.data}");

            // compute(parseLogin, response.body);

            saveData(loginResponse.data);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const FetchScreen(),
            ));
          } else {
            print('error in login 2');
            GlobalMethods.errorDialog(
                subtitle: 'Wrong username or password', context: context);
            setState(() {
              _isLoading = false;
            });
          }
        } else {
          GlobalMethods.errorDialog(
              subtitle: 'Wrong confirmation: ${response.message}',
              context: context);
          setState(() {
            _isLoading = false;
          });
        }
      } catch (error) {
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

  // void saveData(String responseBody) async {
  void saveData(Login responseBody) async {
    final sharedPrefState =
        Provider.of<SharedPrefsProvider>(context, listen: false);

    // final Map<String, dynamic> parsed = jsonDecode(responseBody); 

    setState(() {
      // sharedPrefState.setIsLoggedIn = true;
      // sharedPrefState.setUsername = "$firstName $lastName";
      // sharedPrefState.setEmail = email;
 
      sharedPrefState.setIsLoggedIn = true;
      sharedPrefState.setUsername = "${responseBody.firstName} ${responseBody.lastName}";
      sharedPrefState.setEmail = responseBody.email;
      sharedPrefState.setGUID = responseBody.userDeviceGUID;
      sharedPrefState.setBearerToken = responseBody.access_token;
    }); 
  }

  Album parseForgotPassword(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Album>((json) => Album.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constants.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constants.authImagesPaths.length,

              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const BackWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Account activation',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _confirmationCodeTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Confirmation code',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      accountConfirmation();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
