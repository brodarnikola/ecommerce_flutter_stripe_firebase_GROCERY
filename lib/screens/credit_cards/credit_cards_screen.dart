import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/providers/credit_cards_provider.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/screens/vehicles/vehicle_widget.dart';
import 'package:grocery_app/services/authentication_services.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

import 'dart:developer' as developer;

class CreditCardsScreen extends StatefulWidget {
  static const routeName = '/CreditCardsScreen';

  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  late CreditCardsProvider creditCardsProvider;
  late List<CreditCardsModel> creditCardsList;
  bool _isLoading = false;

  @override
  void initState() {
    creditCardsProvider =
        Provider.of<CreditCardsProvider>(context, listen: false);
    creditCardsList = creditCardsProvider.getCreditCards;
    super.initState();
  }

  void deleteCreditCard(int userDeviceCardID) async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await AuthenticationServices()
          .deleteCreditCard(userDeviceCardID, context);

      if (response.success && response.data != null) {
        print('Succefully delete credit card in');
        developer.log("Succefully delete credit card in  ${response}");
        developer
            .log("Succefully delete credit card in body ${response.data}");

        Fluttertoast.showToast(
          msg: "Credit card deleted successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        creditCardsProvider.deleteCreditCard(userDeviceCardID);
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
    // }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    // Size size = Utils(context).getScreenSize;

    creditCardsProvider = Provider.of<CreditCardsProvider>(context);
    creditCardsList = creditCardsProvider.getCreditCards;

    return creditCardsList.isEmpty
        ? const EmptyScreen(
            title: 'You dont have any credit card yet!',
            subtitle: 'Reserve or pay parking :)',
            buttonText: 'Pay parking',
            imagePath: 'assets/images/cart.png',
            // route: '/AddVehicleScreen',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your credit cards (${creditCardsList.length})',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: LoadingManager(
                isLoading: _isLoading,
                child: Stack(children: [
                  ListView.separated(
                    itemCount: creditCardsList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: ChangeNotifierProvider.value(
                          value: creditCardsList[index],
                          child: Column(
                            children: [
                              CreditCardUi(
                                cardHolderFullName: 'John Doe',
                                cardNumber: creditCardsList[index]
                                    .MaskedCreditCardNumber,
                                validThru: creditCardsList[index].TokenExp,
                                validFrom: '01/23',

                                topLeftColor: Colors.blue,
                                showBalance: true,
                                balance: 128.32434343,

                                enableFlipping: true, // 👈 Enables the flipping
                                cvvNumber: '123', // 👈 CVV number t
                              ),
                              const SizedBox(
                                height: 10,
                              ), 
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: color,
                                    ),
                                  ),
                                  // onPrimary: color,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                ),
                                onPressed: () {
                                  GlobalMethods.warningDialog(
                                      title: 'Deactivate credit card',
                                      subtitle:
                                          'Are you sure you want to deactivate one click payment?',
                                      fct: () async {
                                        deleteCreditCard(creditCardsList[index]
                                            .UserDeviceCardID);
                                      },
                                      context: context);
                                },
                                child: TextWidget(
                                  text: "Deactivate one click payment",
                                  textSize: 20,
                                  color: themeState
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade800,
                                  isTitle: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: color,
                        thickness: 1,
                      );
                    },
                  ),
                ])));
  }
}
