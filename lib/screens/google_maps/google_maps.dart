// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter/material.dart';
import 'package:grocery_app/screens/google_maps/google_maps_example.dart';
import 'package:grocery_app/screens/google_maps/place_marker.dart';
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
                          appBar:
                              AppBar(title: Text("Google maps with markers")),
                          body: const PlaceMarkerPage(),
                        )));
              },
              child: TextWidget(
                text: "Google maps with markers",
                textSize: 20,
                color: themeState ? Colors.grey.shade300 : Colors.grey.shade800,
                isTitle: true,
              ),
            ),
          ],
        ));
  }
}
