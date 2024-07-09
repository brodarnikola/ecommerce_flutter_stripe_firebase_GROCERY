
import 'package:flutter/material.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/vehicles/vehicle_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/orders_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart'; 

class VehiclesScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  @override
  void initState() {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    ordersProvider.fetchOrders();

    final vehiclesProvider = Provider.of<VehiclesProvider>(context, listen: false);
    vehiclesProvider.fetchVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;

    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;



    final vehiclesProvider = Provider.of<VehiclesProvider>(context);
    final vehiclesList = vehiclesProvider.getVehicles;

    return ordersList.isEmpty
        ? const EmptyScreen(
            title: 'You dont have any vehicles yet!',
            subtitle: 'Insert some vehicles :)',
            buttonText: 'Insert vehicle',
            imagePath: 'assets/images/cart.png',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 0,
              centerTitle: false,
              title: TextWidget(
                text: 'Your orders (${ordersList.length})',
                color: color,
                textSize: 24.0,
                isTitle: true,
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: ordersList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: ChangeNotifierProvider.value(
                    value: ordersList[index],
                    child: const VehicleWidget(),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 1,
                );
              },
            ));
  }
}
