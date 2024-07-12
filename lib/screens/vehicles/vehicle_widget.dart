import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/models/vehicles_model.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/services/authentication_services.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class VehicleWidget extends StatefulWidget {
  final int index; // Declare index as a final variable
  // how to pass the index to the widget
  const VehicleWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<VehicleWidget> createState() => _VehicleWidgetState();
}

class _VehicleWidgetState extends State<VehicleWidget> {
  late String orderDateToShow;

  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index; // Initialize index in initState
  }

  @override
  void didChangeDependencies() {
    // final ordersModel = Provider.of<OrderModel>(context);
    // var orderDate = ordersModel.orderDate.toDate();
    // orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';

    final vehicleModel = Provider.of<VehiclesModel>(context);
    var orderDate = vehicleModel.DateTimeCreated; //.toDate();
    orderDateToShow =
        "Awesome date"; // '${orderDate.day}/${orderDate.month}/${orderDate.year}';

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var vehicleModel = Provider.of<VehiclesModel>(context);

    final vehiclesProvider = Provider.of<VehiclesProvider>(context);

    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300] ?? Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //  padding: const EdgeInsets.all(20.0),
        // Padding(
        //   padding: const EdgeInsets.symmetric(
        //       horizontal: 2, vertical: 6),
        child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddVehicleScreen(
                    vehicleNameParam: vehicleModel.Name,
                    vehiclePlateNumberParam: vehicleModel.Ticket,
                    userDeviceVehicleIDParam: vehicleModel.UserDeviceVehicleID,
                  ),
                ),
              );
            },
            title: TextWidget(
                text: '${vehicleModel.Name}', color: color, textSize: 18),
            subtitle: Text(vehicleModel.Ticket),
            trailing: IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: 'Delete this vehicle?',
                    subtitle: 'Are you sure?',
                    fct: () async {
                      var vehicleList = await AuthenticationServices()
                          .deleteVehicle(vehicleModel.Ticket,
                              vehicleModel.UserDeviceVehicleID, context);
                      if (vehicleList.success) {
                        vehiclesProvider.deleteVehicle(index);
                      }
                    },
                    context: context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
            // trailing: TextWidget(text: orderDateToShow, color: color, textSize: 18),
            ));
  }
}
