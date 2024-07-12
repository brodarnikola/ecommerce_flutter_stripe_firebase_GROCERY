import 'package:flutter/material.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/screens/vehicles/vehicle_widget.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class VehiclesScreen extends StatefulWidget {
  static const routeName = '/VehiclesScreen';

  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    // Size size = Utils(context).getScreenSize;

    final vehiclesProvider = Provider.of<VehiclesProvider>(context);
    final vehiclesList = vehiclesProvider.getVehicles;

    return vehiclesList.isEmpty
        ? const EmptyScreen(
            title: 'You dont have any vehicles yet!',
            subtitle: 'Insert some vehicles :)',
            buttonText: 'Insert vehicle',
            imagePath: 'assets/images/cart.png',
            route: '/AddVehicleScreen',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your vehicles (${vehiclesList.length})',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: Column(
              children: [
                Expanded(
                    child: ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemCount: vehiclesList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 6),
                      child: ChangeNotifierProvider.value(
                        value: vehiclesList[index],
                        child: VehicleWidget(
                            index: index), // Pass the index as a named argument
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 0);
                  },
                  // separatorBuilder: (BuildContext context, int index) {
                  //   return Divider(
                  //     color: color,
                  //     thickness: 1,
                  //   );
                  // },
                )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
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
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: AddVehicleScreen.routeName);
                  },
                  child: TextWidget(
                    text: "Add vehicle",
                    textSize: 20,
                    color: themeState
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
                    isTitle: true,
                  ),
                ),
              ],
            ));
  }
}
