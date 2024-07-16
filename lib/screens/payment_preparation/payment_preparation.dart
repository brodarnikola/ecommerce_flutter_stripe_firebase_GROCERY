import 'package:flutter/material.dart';
import 'package:grocery_app/models/credit_cards_model.dart';
import 'package:grocery_app/models/locations_model.dart';
import 'package:grocery_app/models/vehicles_model.dart';
import 'package:grocery_app/providers/credit_cards_provider.dart';
import 'package:grocery_app/providers/locations_provider.dart';
import 'package:grocery_app/providers/vehicles_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class ParkingReservationScreen extends StatefulWidget {
  static const routeName = '/PaymentsScreen';

  @override
  _ParkingReservationScreenState createState() =>
      _ParkingReservationScreenState();
}

class _ParkingReservationScreenState extends State<ParkingReservationScreen> {
  bool loading = false;
  String snackMessage = "";
  bool addingVehicle = false;

  String selectedCard = "";
  String selectedVehicle = "";
  String selectedLocation = "";
  String selectedParkingSlotType = "";

  DateTime selectedStartTime = DateTime.now();
  DateTime selectedEndTime = DateTime.now();

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String _selectedItem = "Credit card 1";
  // String _selectedVehicle = "Vehicle 1";
  // String _selectedLocation = "Location 1";

  late VehiclesModel? _selectedVehicle;
  late CreditCardsModel? _selectedCreditCard;
  late LocationsModel? _selectedLocation;
  late ParkingTypesModel? _selectedParkingType;

  late List<VehiclesModel> vehiclesList;
  late List<CreditCardsModel> creditCardList;
  late List<LocationsModel> locationsList;
  late List<ParkingTypesModel> parkingTypesList;

  @override
  void initState() {
    super.initState();

    final vehiclesProvider =
        Provider.of<VehiclesProvider>(context, listen: false);
    // final vehiclesData = vehiclesProvider.getVehicles;

    final creditCardsProvider =
        Provider.of<CreditCardsProvider>(context, listen: false);
    // final creditCardData = creditCardsProvider.getCreditCards;

    final locationsProvider =
        Provider.of<LocationsProvider>(context, listen: false);

    locationsList = locationsProvider.getLocations.toList();
    parkingTypesList = locationsProvider.getParkingTypes.toList();

    vehiclesList = vehiclesProvider.getVehicles.toList();

    creditCardList = creditCardsProvider.getCreditCards.toList();

    if (vehiclesList.isNotEmpty) {
      _selectedVehicle = vehiclesList[0];
    }

    if (creditCardList.isNotEmpty) {
      _selectedCreditCard =
          creditCardList[0]; //.MaskedCreditCardNumber.toString();
    }

    if (locationsList.isNotEmpty) {
      _selectedLocation = locationsList[0];
    }

    if (parkingTypesList.isNotEmpty) {
      _selectedParkingType = parkingTypesList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? const CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (snackMessage != "")
                      SnackBar(
                        content: Text(snackMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                        onVisible: () {
                          setState(() {
                            snackMessage = "";
                          });
                        },
                      ),
                    if (addingVehicle)
                      AddVehicles(onSave: onCarSave, onCancel: onCarCancel)
                    else
                      const Text(
                        "New Payment",
                        style: const TextStyle(
                            fontSize: 22, color: Color(0xFF857765)),
                      ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField<CreditCardsModel>(
                          value: _selectedCreditCard,
                          onChanged: (CreditCardsModel? value) {
                            setState(() {
                              _selectedCreditCard = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select payment',
                            border: OutlineInputBorder(),
                          ),
                          items: creditCardList
                              .map<DropdownMenuItem<CreditCardsModel>>(
                                  (CreditCardsModel value) {
                            return DropdownMenuItem<CreditCardsModel>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value.MaskedCreditCardNumber),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField<VehiclesModel>(
                          value: _selectedVehicle,
                          onChanged: (VehiclesModel? value) {
                            setState(() {
                              _selectedVehicle = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select vehicle',
                            border: OutlineInputBorder(),
                          ),
                          items: vehiclesList
                              .map<DropdownMenuItem<VehiclesModel>>(
                                  (VehiclesModel value) {
                            return DropdownMenuItem<VehiclesModel>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value.Name),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField<LocationsModel>(
                          value: _selectedLocation,
                          onChanged: (LocationsModel? value) {
                            setState(() {
                              _selectedLocation = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select location',
                            border: OutlineInputBorder(),
                          ),
                          items: locationsList
                              .map<DropdownMenuItem<LocationsModel>>(
                                  (LocationsModel value) {
                            return DropdownMenuItem<LocationsModel>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value.Naziv ?? ""),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField<ParkingTypesModel>(
                          value: _selectedParkingType,
                          onChanged: (ParkingTypesModel? value) {
                            setState(() {
                              _selectedParkingType = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select location',
                            border: OutlineInputBorder(),
                          ),
                          items: parkingTypesList
                              .map<DropdownMenuItem<ParkingTypesModel>>(
                                  (ParkingTypesModel value) {
                            return DropdownMenuItem<ParkingTypesModel>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value.Naziv ?? ""),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                    DateTimePicker(
                      labelText: 'From',
                      selectedDate: selectedStartTime,
                      selectDate: (DateTime date) {
                        setState(() {
                          selectedStartTime = date;
                        });
                      },
                      key: const ObjectKey("DateTimePickerFrom"),
                    ),
                    DateTimePicker(
                      labelText: 'Until',
                      selectedDate: selectedEndTime,
                      selectDate: (DateTime date) {
                        setState(() {
                          selectedEndTime = date;
                        });
                      },
                      key: const ObjectKey("DateTimePickerUntil"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle payment activation
                      },
                      child: const Text("Pay and Activate One Click"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void onCarSave() {
    setState(() {
      addingVehicle = false;
    });
  }

  void onCarCancel() {
    setState(() {
      addingVehicle = false;
    });
  }
}

class AddVehicles extends StatelessWidget {
  final Function onSave;
  final Function onCancel;

  AddVehicles({required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add vehicle form
        ElevatedButton(
            onPressed: () {
              onSave();
            },
            child: Text("Save")),
        ElevatedButton(
            onPressed: () {
              onCancel();
            },
            child: Text("Cancel")),
      ],
    );
  }
}

class DateTimePicker extends StatelessWidget {
  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;

  DateTimePicker(
      {required Key key,
      required this.labelText,
      required this.selectedDate,
      required this.selectDate})
      : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
 
        developer.log("Picked date time is $pickedDateTime"); 
        selectDate(pickedDateTime);
      }
    }
    // if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(labelText: labelText),
        child: Text(DateFormat('dd-MM-yyyy HH:mm').format(
            selectedDate)), // which format I need to use to display date and time
      ),
    );
  }
}
