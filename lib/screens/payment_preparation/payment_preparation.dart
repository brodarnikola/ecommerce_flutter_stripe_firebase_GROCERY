import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String _selectedVehicle = "Vehicle 1";
  String _selectedLocation = "Location 1";

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
                        child: DropdownButtonFormField<String>(
                          value: _selectedItem,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedItem = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select payment',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            'Credit card 1',
                            'Credit card 2',
                            'Credit card 3',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedVehicle,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedVehicle = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select vehicle',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            'Vehicle 1',
                            'Vehicle 2',
                            'Vehicle 3',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                         Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectedLocation,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedLocation = value!;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Select location',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            'Location 1',
                            'Location 2',
                            'Location 3',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 10),
                                  Text(value),
                                ],
                              ),
                            );
                          }).toList(),
                        )),
                    DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    // DropdownButton<String>(
                    //   hint: const Text('Select Location'),
                    //   value: selectedLocation,
                    //   items: <String>['Location 1', 'Location 2', 'Location 3']
                    //       .map<DropdownMenuItem<String>>((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       selectedLocation = newValue ?? "";
                    //     });
                    //   },
                    // ),
                    // DropdownButtonFormField<Object>(
                    //   decoration:
                    //       const InputDecoration(labelText: 'Credit/Debit Card'),
                    //   items: [], // Add your card items here
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedCard = "awesome value";
                    //     });
                    //   },
                    // ),
                    DropdownButtonFormField<Object>(
                      decoration: const InputDecoration(labelText: 'Vehicle'),
                      items: [], // Add your vehicle items here
                      onChanged: (value) {
                        setState(() {
                          selectedVehicle = "awesome value";
                        });
                      },
                    ),
                    DropdownButtonFormField<Object>(
                      decoration: const InputDecoration(labelText: 'Location'),
                      items: [], // Add your location items here
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = "awesome value";
                        });
                      },
                    ),
                    DropdownButtonFormField<Object>(
                      decoration:
                          const InputDecoration(labelText: 'Parking Slot Type'),
                      items: [], // Add your parking slot type items here
                      onChanged: (value) {
                        setState(() {
                          selectedParkingSlotType = "awesome value";
                        });
                      },
                    ),
                    DateTimePicker(
                      labelText: 'From',
                      selectedDate: selectedStartTime,
                      selectDate: (DateTime date) {
                        setState(() {
                          selectedStartTime = date;
                        });
                      },
                      key: const ObjectKey("DateTimePicker1"),
                    ),
                    DateTimePicker(
                      labelText: 'To',
                      selectedDate: selectedEndTime,
                      selectDate: (DateTime date) {
                        setState(() {
                          selectedEndTime = date;
                        });
                      },
                      key: const ObjectKey("DateTimePicker2"),
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(labelText: labelText),
        child: Text(DateFormat.yMd().format(selectedDate)),
      ),
    );
  }
}
