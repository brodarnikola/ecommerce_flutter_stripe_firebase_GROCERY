import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/orders_model.dart';
import 'package:grocery_app/models/vehicles_model.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class VehicleWidget extends StatefulWidget {
  const VehicleWidget({Key? key}) : super(key: key);

  @override
  State<VehicleWidget> createState() => _VehicleWidgetState();
}

class _VehicleWidgetState extends State<VehicleWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    // final ordersModel = Provider.of<OrderModel>(context);
    // var orderDate = ordersModel.orderDate.toDate();
    // orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';

  final vehicleModel = Provider.of<VehiclesModel>(context);
    var orderDate = vehicleModel.DateTimeCreated; //.toDate();
    orderDateToShow =  "Awesome date"; // '${orderDate.day}/${orderDate.month}/${orderDate.year}';

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleModel = Provider.of<VehiclesModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    // final productProvider = Provider.of<ProductsProvider>(context);
    // final getCurrProduct = productProvider.findProdById(ordersModel.productId);
    return ListTile(
      subtitle:
          Text('Paid: \$${vehicleModel.Name}'), // .toStringAsFixed(2)}'),
      // onTap: () {
      //   GlobalMethods.navigateTo(
      //       ctx: context, routeName: ProductDetails.routeName);
      // },
      // leading: FancyShimmerImage(
      //   width: size.width * 0.2,
      //   imageUrl: getCurrProduct.productCategoryName,
      //   boxFit: BoxFit.fill,
      // ),
      title: TextWidget(
          text: '${vehicleModel.Ticket}',
          color: color,
          textSize: 18),
      trailing: TextWidget(text: orderDateToShow, color: color, textSize: 18),
    );
  }
}
