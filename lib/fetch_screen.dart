import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/consts/constants.dart';
import 'package:grocery_app/consts/firebase_consts.dart';
import 'package:grocery_app/providers/cart_provider.dart';
import 'package:grocery_app/providers/credit_cards_provider.dart';
import 'package:grocery_app/providers/orders_provider.dart';
import 'package:grocery_app/providers/shared_pref_provider.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/providers/wishlist_provider.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/services/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'providers/products_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  List<String> images = Constants.authImagesPaths;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(microseconds: 5), () async {

      final sharedPrefState =
          Provider.of<SharedPrefsProvider>(context, listen: false);

      final vehiclesProvider =
          Provider.of<VehiclesProvider>(context, listen: false);
      final creditCardsProvider =
          Provider.of<CreditCardsProvider>(context, listen: false);

      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      final orderProvider = Provider.of<OrdersProvider>(context, listen: false);
      final User? user = authInstance.currentUser;
      if (user == null) {
        await productsProvider.fetchProducts();
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
        orderProvider.clearLocalOrders();
      } else {
        await productsProvider.fetchProducts();
        await cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
        await orderProvider.fetchOrders();
      }
 
      print("Is logged in user AWESOME: ${sharedPrefState.isLoggedInUser()}");

      if(  
        sharedPrefState.getIsLoggedInValue == true  ) {

        await vehiclesProvider.fetchVehicles();
        await creditCardsProvider.fetchCreditCards();

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const BottomBarScreen(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => const LoginScreen(),
        ));
      } 

      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool? isLoggedIn = prefs.getBool(isLoggedIn as String);

      //   if(prefs.getBool(isLoggedIn) == true) {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (ctx) => const BottomBarScreen(),
      //     ));
      //   }
      //   else {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (ctx) => const LoginScreen(),
      //     ));
      //   }

      // if (!mounted) return;
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (ctx) => const BottomBarScreen(),
      // ));
    });
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
