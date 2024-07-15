// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:grocery_app/screens/google_maps/google_maps_example.dart';
import 'package:grocery_app/screens/google_maps/map_ui.dart';
import 'package:grocery_app/screens/google_maps/place_marker.dart';
import 'package:grocery_app/screens/vehicles/add_vehicle.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/services/utils.dart';
import 'package:grocery_app/widgets/text_widget.dart'; 

/// MapsDemo is the Main Application.
class MapsDemo extends StatelessWidget {
  /// Default Constructor
  static const routeName = '/GoogleMapsScreen';

  void _pushPage(BuildContext context, GoogleMapExampleAppPage page) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    return Scaffold(
        appBar: AppBar(title: const Text('GoogleMaps examples')),
        body: Column(
          children: [
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                          appBar: AppBar(title: Text("Google Maps title")),
                          body: const MapUiPage(),
                        )));
                // GlobalMethods.navigateTo(
                //     ctx: context, routeName: AddVehicleScreen.routeName);
              },
              child: TextWidget(
                text: "google maps with lots of options",
                textSize: 20,
                color: themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                isTitle: true,
              ),
            ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                          appBar: AppBar(title: Text("Google maps with markers")),
                          body: const PlaceMarkerPage(),
                        )));
                // GlobalMethods.navigateTo(
                //     ctx: context, routeName: AddVehicleScreen.routeName);
              },
              child: TextWidget(
                text: "Google maps with markers",
                textSize: 20,
                color: themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                isTitle: true,
              ),
            ), 
          ],
        )
        // ListView.builder(
        //   itemCount: _allPages.length,
        //   itemBuilder: (_, int index) => ListTile(
        //     leading: _allPages[index].leading,
        //     title: Text(_allPages[index].title),
        //     onTap: () => _pushPage(context, _allPages[index]),
        //   ),
        // ),
        );
  }
}

// void main() {
//   final GoogleMapsFlutterPlatform mapsImplementation =
//       GoogleMapsFlutterPlatform.instance;
//   if (mapsImplementation is GoogleMapsFlutterAndroid) {
//     mapsImplementation.useAndroidViewSurface = true;
//     initializeMapRenderer();
//   }
//   runApp(const MaterialApp(home: MapsDemo()));
// }

// Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

// /// Initializes map renderer to the `latest` renderer type for Android platform.
// ///
// /// The renderer must be requested before creating GoogleMap instances,
// /// as the renderer can be initialized only once per application context.
// Future<AndroidMapRenderer?> initializeMapRenderer() async {
//   if (_initializedRendererCompleter != null) {
//     return _initializedRendererCompleter!.future;
//   }

//   final Completer<AndroidMapRenderer?> completer =
//       Completer<AndroidMapRenderer?>();
//   _initializedRendererCompleter = completer;

//   WidgetsFlutterBinding.ensureInitialized();

//   final GoogleMapsFlutterPlatform mapsImplementation =
//       GoogleMapsFlutterPlatform.instance;
//   if (mapsImplementation is GoogleMapsFlutterAndroid) {
//     unawaited(mapsImplementation
//         .initializeWithRenderer(AndroidMapRenderer.latest)
//         .then((AndroidMapRenderer initializedRenderer) =>
//             completer.complete(initializedRenderer)));
//   } else {
//     completer.complete(null);
//   }

//   return completer.future;
// }
