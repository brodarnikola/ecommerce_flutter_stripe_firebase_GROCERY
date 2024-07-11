import 'package:flutter/material.dart';
import 'package:grocery_app/providers/transactions_provider.dart';
import 'package:grocery_app/providers/reservations_provider.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/loading_manager.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/screens/vehicles/vehicle_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  static const routeName = '/TransactionsScreen';

  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    // Size size = Utils(context).getScreenSize;

    final paymentsProvider = Provider.of<TransactionsProvider>(context);
    final paymentsList = paymentsProvider.getTransactions;

    return paymentsList.isEmpty
        ? const EmptyScreen(
            title: 'You dont have any transactions!',
            subtitle: '',
            buttonText: 'Back',
            imagePath: 'assets/images/cart.png',
            route: '/UserScreen',
            navigateBack: true,
          )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your transactions (${paymentsList.length})',
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
                    padding: const EdgeInsets.all(5),
                    itemCount: paymentsList.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey[300] ?? Colors.grey),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        //  padding: const EdgeInsets.all(20.0),
                        child: ChangeNotifierProvider.value(
                          value: paymentsList[index],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: '${paymentsList[index].parkingTvrtkaNaziv} - ${paymentsList[index].garazaNaziv}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      '${paymentsList[index].registracija}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      '${paymentsList[index].parkingTvrtkaNaziv}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      'From ${GlobalMethods.getDateFromDateTimeString(paymentsList[index].start ?? "")} - ${GlobalMethods.getTimeFromDateTimeString(paymentsList[index].start ?? "")}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      'Until ${GlobalMethods.getDateFromDateTimeString(paymentsList[index].end ?? "")} - ${GlobalMethods.getTimeFromDateTimeString(paymentsList[index].end ?? "")}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      'Amount: ${(paymentsList[index].amount ?? 1) / 100} EUR',
                                  color: color,
                                  textSize: 18),
                            ],
                          ),
                          // child: VehicleWidget( index: index), // Pass the index as a named argument
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                      // return Divider(
                      //   color: color,
                      //   thickness: 0,
                      // );
                    },
                  )
                ])));
  }
}
