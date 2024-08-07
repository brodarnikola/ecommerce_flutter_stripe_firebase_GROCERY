import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/providers/credit_cards_provider.dart';
import 'package:grocery_app/providers/transactions_provider.dart';
import 'package:grocery_app/providers/reservations_provider.dart';
import 'package:grocery_app/providers/shared_pref_provider.dart';
import 'package:grocery_app/providers/orders_provider.dart';
import 'package:grocery_app/providers/products_provider.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:grocery_app/providers/viewed_prod_provider.dart';
import 'package:grocery_app/screens/auth/account_activation.dart';
import 'package:grocery_app/screens/credit_cards/credit_cards_screen.dart';
import 'package:grocery_app/screens/google_maps/google_maps.dart';
import 'package:grocery_app/screens/my_reservations/reservations.dart';
import 'package:grocery_app/screens/transactions/transactions.dart';
import 'package:grocery_app/screens/user.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/screens/vehicles/vehicles_screen.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently.dart';
import 'package:provider/provider.dart';

import '.env';

import 'consts/theme_data.dart';
import 'fetch_screen.dart';
import 'inner_screens/cat_screen.dart';
import 'inner_screens/feeds_screen.dart';
import 'inner_screens/product_details.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/auth/forget_pass.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/wishlist/wishlist_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = PUBLIC_KEY;
  //     "Your publishable Key";
  Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefsProvider sharedPrefProvider = SharedPrefsProvider();

  Completer<AndroidMapRenderer?>? _initializedRendererCompleter;
 
  @override
  void initState() {
    getCurrentAppTheme();

    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
      initializeMapRenderer();
    }

    super.initState();
  }
 
  void getCurrentAppTheme() async {
    sharedPrefProvider.setDarkTheme =
        await sharedPrefProvider.darkThemePrefs.getTheme();

    if (await sharedPrefProvider.isLoggedInUser()) {
      // call here only once when the app starts and setup usernmae and email
      sharedPrefProvider.getUsernameValue();
      sharedPrefProvider.getEmailValue();
      sharedPrefProvider.getPasswordValue();
      sharedPrefProvider.getGUIDValue();
      sharedPrefProvider.getBearerTokenValue();
    }
  }

  Future<AndroidMapRenderer?> initializeMapRenderer() async {
    if (_initializedRendererCompleter != null) {
      return _initializedRendererCompleter!.future;
    }

    final Completer<AndroidMapRenderer?> completer =
        Completer<AndroidMapRenderer?>();
    _initializedRendererCompleter = completer;

    WidgetsFlutterBinding.ensureInitialized();

    final GoogleMapsFlutterPlatform mapsImplementation =
        GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      unawaited(mapsImplementation
          .initializeWithRenderer(AndroidMapRenderer.latest)
          .then((AndroidMapRenderer initializedRenderer) =>
              completer.complete(initializedRenderer)));
    } else {
      completer.complete(null);
    }

    return completer.future;
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              )),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  body: Center(
                child: Text('An error occured'),
              )),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return sharedPrefProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishlistProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ViewedProdProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => OrdersProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => VehiclesProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CreditCardsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ReservationsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => TransactionsProvider(),
              ),
            ],
            child: Consumer<SharedPrefsProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: Styles.themeData(themeProvider.getDarkTheme, context),
                  home: const FetchScreen(),
                  routes: {
                    OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                    FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                    ProductDetails.routeName: (ctx) => const ProductDetails(),
                    WishlistScreen.routeName: (ctx) => const WishlistScreen(),
                    OrdersScreen.routeName: (ctx) => const OrdersScreen(),
                    ViewedRecentlyScreen.routeName: (ctx) =>
                        const ViewedRecentlyScreen(),
                    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                    LoginScreen.routeName: (ctx) => const LoginScreen(),
                    ForgetPasswordScreen.routeName: (ctx) =>
                        const ForgetPasswordScreen(),
                    AccountActivationScreen.routeName: (ctx) =>
                        const AccountActivationScreen(),
                    MapsDemo.routeName: (ctx) =>
                        MapsDemo(),
                    VehiclesScreen.routeName: (ctx) => const VehiclesScreen(),
                    AddVehicleScreen.routeName: (ctx) =>
                        const AddVehicleScreen(),
                    CreditCardsScreen.routeName: (ctx) =>
                        const CreditCardsScreen(),
                    ReservationsScreen.routeName: (ctx) =>
                        const ReservationsScreen(),
                    TransactionsScreen.routeName: (ctx) =>
                        const TransactionsScreen(),
                    CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                  });
            }),
          );
        });
  }
}

// class PaymentDemo extends StatelessWidget {
//   const PaymentDemo({Key? key}) : super(key: key);
//   Future<void> initPayment(
//       {required String email,
//       required double amount,
//       required BuildContext context}) async {
//     try {
//       // 1. Create a payment intent on the server
//       final response = await http.post(
//           Uri.parse(
//               'Your function'),
//           body: {
//             'email': email,
//             'amount': amount.toString(),
//           });

//       final jsonResponse = jsonDecode(response.body);
//       log(jsonResponse.toString());
//       // 2. Initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: jsonResponse['paymentIntent'],
//         merchantDisplayName: 'Grocery Flutter course',
//         customerId: jsonResponse['customer'],
//         customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
//         // testEnv: true,
//         // merchantCountryCode: 'SG',
//       ));
//       await Stripe.instance.presentPaymentSheet();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Payment is successful'),
//         ),
//       );
//     } catch (errorr) {
//       if (errorr is StripeException) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured ${errorr.error.localizedMessage}'),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('An error occured $errorr'),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: ElevatedButton(
//         child: const Text('Pay 20\$'),
//         onPressed: () async {
//           await initPayment(
//               amount: 50.0, context: context, email: 'email@test.com');
//         },
//       )),
//     );
//   }
// }
