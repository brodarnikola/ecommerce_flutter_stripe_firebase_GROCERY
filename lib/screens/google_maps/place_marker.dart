import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/services/global_methods.dart';

import 'dart:developer' as developer;

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class PlaceMarkerPage extends StatefulWidget {
  const PlaceMarkerPage({Key? key}) : super(key: key);

  @override
  State<PlaceMarkerPage> createState() => _PlaceMarkerPage();
}

class _PlaceMarkerPage extends State<PlaceMarkerPage>
    with WidgetsBindingObserver {
  static const LatLng center = LatLng(45.0838331, 13.6468675);
  MapType _mapType = MapType.normal;

  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  LatLng? markerPosition;

  bool _myLocationEnabled = false;
  bool _myLocationButtonEnabled = false;
  bool _isRequestingPermission = false;

  LatLng _initialcameraposition = const LatLng(25.0838331, 33.6468675);

  // ignore: use_setters_to_change_properties
  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    _initialcameraposition = _initialcameraposition;
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    developer.log("DID CHANGE APP location status: ");
    if (state == AppLifecycleState.resumed && !_isRequestingPermission) {
      checkLocationPermission();
    }
  }

  void checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      _add();
      _add();
      _add();
      setState(() {
        _myLocationButtonEnabled = true;
        _myLocationEnabled = true;
      });
    } else {
      _isRequestingPermission = true;
      requestLocationPermission();
      // Handle the case where the permission is not granted
    }
  }

  Future<LatLng> _getUserLocation() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      developer
          .log("GET USER location: ${position.latitude} ${position.longitude}");
      developer.log("GET USER controller: $controller");
      return LatLng(position.latitude, position.longitude);
    }
    return const LatLng(0.0, 0.0);
  }

  @override
  void initState() {
    super.initState();
    developer.log("INIT location status: ");
    // _initialcameraposition = LatLng(0.0, 0.0);
    WidgetsBinding.instance.addObserver(this);
    checkLocationPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserLocation();
    });
  }

  @override
  void dispose() {
    developer.log("DISPOSE location status: ");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    print("location status: $status");

    developer.log("location status: $status");

    await Permission.location.onDeniedCallback(() {
      GlobalMethods.warningDialog(
          title: "Enable location permission",
          subtitle: "Please enable location permissions",
          fct: () async {
            Navigator.pop(context);
          },
          context: context);
      // The user did not grant the permission
      return;
      // Your code
    }).onGrantedCallback(() {
      setState(() {
        _myLocationButtonEnabled = true;
        _myLocationEnabled = true;
      });
      _isRequestingPermission = false;
      _add();
      _add();
      _add();
    }).onPermanentlyDeniedCallback(() {
      GlobalMethods.warningDialog(
          title: "Enable location permission",
          subtitle:
              "You have permantely disabled location permission. Please enable location permissions to use this feature.",
          fct: () async {
            _isRequestingPermission = false;
            openAppSettings();
          },
          context: context);
      // The user did not grant the permission
      return;
      // Your code
    }).onRestrictedCallback(() {
      // The OS restricts access, for example because of parental controls.
      // Your code
    }).onLimitedCallback(() {
      // Your code
    }).onProvisionalCallback(() {
      // Your code
    }).request();

    // PermissionStatus status = await Permission.location.status;

    // print("location status: $status");

    // if (!status.isGranted) {
    //   PermissionStatus result = await Permission.location.request();
    //   if (!result.isGranted) {
    //     GlobalMethods.warningDialog(
    //         title: "Enable location permission",
    //         subtitle: "Please enable location permissions",
    //         fct: () async {
    //           Navigator.pop(context);
    //         },
    //         context: context);
    //     // The user did not grant the permission
    //     return;
    //   } else {
    //     // The user granted the permission
    //     // Please show me code, how to enable now my location button on google maps
    //     setState(() {
    //       _myLocationButtonEnabled = true;
    //       _myLocationEnabled = true;
    //     });
    //   }
    // }
    // else {
    //   setState(() {
    //     _myLocationButtonEnabled = true;
    //     _myLocationEnabled = true;
    //   });
    // }

    // The permission is granted, you can use the location services now
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _remove(MarkerId markerId) {
    setState(() {
      if (markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _mapType = MapType.values[(_mapType.index + 1) % MapType.values.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _getUserLocation(),
      builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: snapshot.data ?? const LatLng(0.0, 0.0),
                      zoom: 11.0,
                    ),
                    mapType: _mapType, // how to change map type on button click
                    myLocationEnabled: _myLocationEnabled,
                    myLocationButtonEnabled: _myLocationButtonEnabled,
                    markers: Set<Marker>.of(markers.values)),
                Positioned(
                  top: 60.0,
                  right: 5.0,
                  child: Column(
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: _onMapTypeButtonPressed,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.map, size: 36.0),
                      ),
                      const SizedBox(height: 10), // Add space between the buttons
                      FloatingActionButton(
                        onPressed: () {
                          if (markers.isNotEmpty) {
                            var firstMarker = markers.values.first;
                            controller?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: firstMarker.position,
                                  zoom: 11.0,
                                ),
                              ),
                            );
                          }
                          // Add your onPressed function here
                        },
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        backgroundColor: Colors
                            .blue, // Change color to distinguish from the other button
                        child: const Icon(Icons.image,
                            size: 36.0), // Change icon to 'image'
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final MarkerId? selectedId = selectedMarker;
  //   return Stack(
  //     children: <Widget>[
  //     Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         // Expanded(
  //             // child:
  // GoogleMap(
  //   onMapCreated: _onMapCreated,
  //   initialCameraPosition: const CameraPosition(
  //     target: LatLng(45.0838331, 13.6468675),
  //     zoom: 11.0,
  //   ),
  //   // mapType: _mapType, // how to change map type on button click
  //   //       mapType:  {
  //   //            final MapType nextType =
  //   // MapType.values[(_mapType.index + 1) % MapType.values.length];
  //   // setState(() {
  //   //   _mapType = nextType;
  //   // });
  //   //       },
  //   myLocationEnabled: _myLocationEnabled,
  //   myLocationButtonEnabled: _myLocationButtonEnabled,
  //   markers: Set<Marker>.of(markers.values),
  //             ),
  //         // Row(
  //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         //   children: <Widget>[
  //         //     TextButton(
  //         //       onPressed: _add,
  //         //       child: const Text('Add'),
  //         //     ),
  //         //     TextButton(
  //         //       onPressed:
  //         //           selectedId == null ? null : () => _remove(selectedId),
  //         //       child: const Text('Remove'),
  //         //     ),
  //         //   ],
  //         // ),
  //             Positioned(
  //               top: 10.0,
  //               left: 10.0,
  //               child: FloatingActionButton(
  //                 onPressed: _onMapTypeButtonPressed,
  //                 materialTapTargetSize: MaterialTapTargetSize.padded,
  //                 backgroundColor: Colors.green,
  //                 child: const Icon(Icons.map,
  //                     size: 36.0), // This is the icon for the button
  //               ),
  //             ),
  //     // Visibility(
  //     //   visible: markerPosition != null,
  //     //   child: Container(
  //     //     color: Colors.white70,
  //     //     height: 30,
  //     //     padding: const EdgeInsets.only(left: 12, right: 12),
  //     //     child: Row(
  //     //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     //       children: <Widget>[
  //     //         if (markerPosition == null)
  //     //           Container()
  //     //         else
  //     //           Expanded(child: Text('lat: ${markerPosition!.latitude}')),
  //     //         if (markerPosition == null)
  //     //           Container()
  //     //         else
  //     //           Expanded(child: Text('lng: ${markerPosition!.longitude}')),
  //     //       ],
  //     //     ),
  //     //   ),
  //     // ),
  //   ]);
  // }
}
