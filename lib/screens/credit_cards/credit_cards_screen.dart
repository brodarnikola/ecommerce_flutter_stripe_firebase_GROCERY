import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/providers/credit_cards_provider.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/screens/vehicles/vehicle_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class CreditCardsScreen extends StatefulWidget {
  static const routeName = '/CreditCardsScreen';

  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    // Size size = Utils(context).getScreenSize;

    final creditCardsProvider = Provider.of<CreditCardsProvider>(context);
    final creditCardsList = creditCardsProvider.getCreditCards;

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
            body: ListView.separated(
              itemCount: creditCardsList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: ChangeNotifierProvider.value(
                    value: creditCardsList[index],
                    child: CreditCardUi(
                      cardHolderFullName: 'John Doe',
                      cardNumber: creditCardsList[index].MaskedCreditCardNumber,
                      validThru: creditCardsList[index].TokenExp,
                      validFrom: '01/23',

                      topLeftColor: Colors.blue,
                      showBalance: true,
                      balance: 128.32434343,

                      enableFlipping: true, // 👈 Enables the flipping
                      cvvNumber: '123', // 👈 CVV number t
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
          );
  }
}
