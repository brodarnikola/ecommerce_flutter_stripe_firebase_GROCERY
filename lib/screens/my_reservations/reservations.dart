import 'package:flutter/material.dart';
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

class ReservationsScreen extends StatefulWidget {
  static const routeName = '/ReservationsScreen';

  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
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

    final reservationsProvider = Provider.of<ReservationsProvider>(context);
    final vehiclesList = reservationsProvider.getReservations;

    return vehiclesList.isEmpty
        ? const EmptyScreen(
            title: 'You dont have any reservations!',
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
                text: 'Your reservations (${vehiclesList.length})',
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
                    itemCount: vehiclesList.length,
                    itemBuilder: (ctx, index) {
                      return 
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey[300] ?? Colors.grey),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        //  padding: const EdgeInsets.all(20.0),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 2, vertical: 6),
                        child: ChangeNotifierProvider.value(
                          value: vehiclesList[index],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text:
                                      '${vehiclesList[index].RotoGarazaNaziv}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text: '${vehiclesList[index].Registracija}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text: '${vehiclesList[index].TipSlotNaziv}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      'From ${GlobalMethods.getDateFromDateTimeString(vehiclesList[index].Pocetak ?? "")} - ${GlobalMethods.getTimeFromDateTimeString(vehiclesList[index].Pocetak ?? "")}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      'Until ${GlobalMethods.getDateFromDateTimeString(vehiclesList[index].Kraj ?? "")} - ${GlobalMethods.getTimeFromDateTimeString(vehiclesList[index].Kraj ?? "")}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      'Amount: ${(vehiclesList[index].PlaceniIznos ?? 1) / 100} EUR',
                                  color: color,
                                  textSize: 18),
                            ],
                          ),
                          // child: VehicleWidget( index: index), // Pass the index as a named argument
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: color,
                        thickness: 1,
                      );
                    },
                  )
                ])));
  }
}
