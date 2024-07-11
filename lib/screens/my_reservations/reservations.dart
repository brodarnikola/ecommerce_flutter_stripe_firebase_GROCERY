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
                    itemCount: vehiclesList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: ChangeNotifierProvider.value(
                          value: vehiclesList[index],
                          child: Column(
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
                                      '${GlobalMethods.getDateFromDateTimeString(vehiclesList[index].Pocetak ?? "")} - ${GlobalMethods.getTimeFromDateTimeString(vehiclesList[index].Pocetak ?? "")}',
                                  color: color,
                                  textSize: 18),
                              const SizedBox(
                                height: 2,
                              ),
                              TextWidget(
                                  text:
                                      '${GlobalMethods.getDateFromDateTimeString(vehiclesList[index].Kraj ?? "")} - ${GlobalMethods.getTimeFromDateTimeString(vehiclesList[index].Kraj ?? "")}',
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
