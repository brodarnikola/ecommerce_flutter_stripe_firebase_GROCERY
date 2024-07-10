import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/vehicles/vehicles_screen.dart';
import 'package:grocery_app/services/authentication_services.dart';
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

class AddVehicleScreen extends StatefulWidget {
  static const routeName = '/AddVehicleScreen';
  final String vehicleNameParam;
  final String vehiclePlateNumberParam;
  final int userDeviceVehicleIDParam;

  const AddVehicleScreen(
      {Key? key,
      this.vehicleNameParam = "",
      this.vehiclePlateNumberParam = "",
      this.userDeviceVehicleIDParam = 0})
      : super(key: key);

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _nameTextController = TextEditingController();
  final _plateNumberTextController = TextEditingController();

  late String vehicleName;
  late String vechiclePlateNumber;

  late int userDeviceVehicleID;
  late bool isNewVehicle = true;

  late VehiclesProvider vehiclesProvider;
  late String buttonText;

  @override
  void initState() {
    super.initState();

    vehicleName = widget.vehicleNameParam;
    vechiclePlateNumber = widget.vehiclePlateNumberParam;
    userDeviceVehicleID = widget.userDeviceVehicleIDParam;

    if (vehicleName.isNotEmpty &&
        vechiclePlateNumber.isNotEmpty &&
        userDeviceVehicleID != null) {
      _nameTextController.text = vehicleName;
      _plateNumberTextController.text = vechiclePlateNumber;

      isNewVehicle = false;
    }
 
    if(isNewVehicle) {
      buttonText = 'Add vehicle';
    } else {
      buttonText = 'Update vehicle';
    }
  }

  @override
  void didChangeDependencies() { 
    super.didChangeDependencies(); 
    vehiclesProvider = Provider.of<VehiclesProvider>(context); 
  }

//   Exception has occurred.
// FlutterError (dependOnInheritedWidgetOfExactType<_InheritedProviderScope<VehiclesProvider?>>() or dependOnInheritedElement() was called before _AddVehicleScreenState.initState() completed.
// When an inherited widget changes, for example if the value of Theme.of() changes, its dependent widgets are rebuilt.
// If the dependent widget's reference to the inherited widget is in a constructor or an initState() method, then the rebuilt dependent widget will not reflect the changes in the inherited widget.
// Typically references to inherited widgets should occur in widget build() methods. Alternatively, initialization based on inherited widgets can be placed in the didChangeDependencies method,
// which is called after initState and whenever the dependencies change thereafter.)

  @override
  void dispose() {
    _nameTextController.dispose();
    _plateNumberTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void addOrUpdateVehicle() async {
    if (_nameTextController.text.isEmpty) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a vehicle name', context: context);
    } else if (_nameTextController.text.isEmpty) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a vehicle plate number', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        var response = await AuthenticationServices().addOrUpdateVehicle(
            _nameTextController.text.toUpperCase().trim(),
            _plateNumberTextController.text.toLowerCase().trim(),
            userDeviceVehicleID,
            isNewVehicle,
            context);

        if (response.success && response.data != null) {
          print('Succefully add or update vehicle in');
          developer.log("Succefully add or update vehicle in  ${response}");
          developer
              .log("Succefully add or update vehicle in body ${response.data}");

          if( isNewVehicle ) { 
            vehiclesProvider.addVehicle(response.data);
          }    
          else { 
            vehiclesProvider.updateVehicle(response.data);  
          }

          late String toastMessage;
          if (isNewVehicle) {
            toastMessage = "Vehicle added successfully";
          } else {
            toastMessage = "Vehicle updated successfully";
          }

          Fluttertoast.showToast(
            msg: toastMessage,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const VehiclesScreen(),
          ));
        } else {
          // If the server did not return a 200 OK response,
          // then throw an exception.
          GlobalMethods.errorDialog(
              subtitle: 'Something is wrong. ${response.message}',
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

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    bool isNewVehicleValue = isNewVehicle;
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
                    text: 'Add vehicle',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _nameTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Name of vehicle',
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
                  TextField(
                    controller: _plateNumberTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Plate number',
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
                    buttonText: buttonText,
                    fct: () {
                      addOrUpdateVehicle();
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
