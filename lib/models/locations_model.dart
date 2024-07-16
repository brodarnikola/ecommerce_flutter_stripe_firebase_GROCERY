import 'package:flutter/cupertino.dart';

class LocationsAndParkingTypesModel with ChangeNotifier {
  
  final List<ParkingTypesModel> parkingType;
  final List<LocationsModel> locations;

  LocationsAndParkingTypesModel(this.parkingType, this.locations);

  LocationsAndParkingTypesModel.fromJson(Map<String, dynamic> json)
      : parkingType = (json['TipSlot'] as List<dynamic>).map((item) => ParkingTypesModel.fromJson(item as Map<String, dynamic>)).toList(),
        locations = (json['RotoGaraze'] as List<dynamic>).map((item) => LocationsModel.fromJson(item as Map<String, dynamic>)).toList();
}

class ParkingTypesModel with ChangeNotifier {
  final int? TipSlotID, TipParkingSlotID, Success;
  final String? Naziv;
  final String? Message, ErrorMessage;
  // final Timestamp orderDate;
 
  //  {
  //           "TipSlotID": 0,
  //           "TipParkingSlotID": 2,
  //           "Naziv": "Ad hoc",
  //           "DaniTjedna": null,
  //           "Message": null,
  //           "ErrorMessage": null,
  //           "Success": 0
  //       },

  ParkingTypesModel(
      this.TipSlotID,
      this.TipParkingSlotID,
      this.Success,
      this.Naziv,
      this.Message,
      this.ErrorMessage
      // this.orderDate
      );

  ParkingTypesModel.fromJson(Map<String, dynamic> json)
      : TipSlotID = json['TipSlotID'] as int,
        TipParkingSlotID = json['TipParkingSlotID'] as int,
        Success = json['Success'] as int,
        Naziv = json['Naziv'] as String, 
        Message = json['Message'] != null ? json['Message'] as String : null,
        ErrorMessage = json['ErrorMessage'] != null ? json['ErrorMessage'] as String : null;
        // orderDate = json['orderDate'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'TipSlotID': TipSlotID,
        'TipParkingSlotID': TipParkingSlotID,
        'Success': Success,
        'Naziv': Naziv,
        'Message': Message,
        'ErrorMessage': ErrorMessage, 
        // 'orderDate': orderDate,
      };


  static List<ParkingTypesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ParkingTypesModel.fromJson(item as Map<String, dynamic>)).toList();
  }
} 


class LocationsModel with ChangeNotifier {
  final int? RotoGarazaID, ParkingTvrtkaID, Success;
  final String? Naziv;
  final String? Message, ErrorMessage;
  // final Timestamp orderDate;

  LocationsModel(
      this.RotoGarazaID,
      this.ParkingTvrtkaID,
      this.Success,
      this.Naziv,
      this.Message,
      this.ErrorMessage
      // this.orderDate
      );

  LocationsModel.fromJson(Map<String, dynamic> json)
      : RotoGarazaID = json['RotoGarazaID'] as int,
        ParkingTvrtkaID = json['ParkingTvrtkaID'] as int,
        Success = json['Success'] as int,
        Naziv = json['Naziv'] as String, 
        Message = json['Message'] != null ? json['Message'] as String : null,
        ErrorMessage = json['ErrorMessage'] != null ? json['ErrorMessage'] as String : null;
        // orderDate = json['orderDate'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'RotoGarazaID': RotoGarazaID,
        'ParkingTvrtkaID': ParkingTvrtkaID,
        'Success': Success,
        'Naziv': Naziv,
        'Message': Message,
        'ErrorMessage': ErrorMessage, 
        // 'orderDate': orderDate,
      };


  static List<ParkingTypesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ParkingTypesModel.fromJson(item as Map<String, dynamic>)).toList();
  }
} 

//  "Adresa": "10253 Gudci",
//             "Slotovi": null,
//             "RotoGarazaID": 18,
//             "ParkingTvrtkaID": 1,
//             "Naziv": "Garaža Zagreb",
//             "MjestoID": 25,
//             "Active": 1,
//             "InProduction": 1,
//             "CamSystemEndPoint": "http://10.12.12.9",
//             "CamSystemUsername": "username",
//             "CamSystemPassword": "password5",
//             "CamSystemPort": 82,
//             "CamSystemTimeout": 5000,
//             "RPSystemEndPoint": "http://markoja.ipt.hr",
//             "RPSystemUsername": "TestUname",
//             "RPSystemPassword": "TestPass",
//             "RPSystemPort": 80,
//             "RPSystemTimeout": 5000,
//             "CamSystemMaxBrojPokusaja": 5,
//             "CamSystemOdgodaNovogPokusajaSekundi": 10,
//             "RPSystemMaxBrojPokusaja": 5,
//             "RPSystemOdgodaNovogPokusajaSekundi": 10,
//             "BojaSemaforaID": 1,
//             "CrveniSemaforParkingTransakcijaID": null,
//             "CrveniSemaforOpis": "",
//             "NenaplatniPeriodZaIzlazakMinuta": 20,
//             "MinimalnaRezervacijaTipJediniceMjereID": 1,
//             "SemaforVrijemeZadnjeIzmjene": "2023-05-31T12:28:53.34",
//             "RezervacijskiGrafDefaultnaKolicina": 48,
//             "CamSystemCheckCameraRoute": "/checkcamera",
//             "CamSystemProcessFinishedRoute": "/processfinished",
//             "CamSystemScanRoute": "/scan",
//             "CamSystemUnparkingVehicleRoute": "/vehicleunparking",
//             "RPDeliverVehicleRoute": "/api/delivervehicle",
//             "RPLowerBarrierRoute": "/api/lowerbarrier",
//             "RPParkVehicleRoute": "/api/parkvehicle",
//             "RPPrepareSlotRoute": "/api/prepareslot",
//             "RPRaiseBarrierRoute": "/api/raisebarrier",
//             "RPProcessFinishedRoute": "/api/parkingfinished",
//             "RPSetMessageRoute": "",
//             "CamSystemEmailAlertList": "hrvoje.rajic@ipt.hr;vedran.selendic@ipt.hr;sabina@pstilia.hr",
//             "RPEmailAlertList": "hrvoje.rajic@ipt.hr;vedran.selendic@ipt.hr;sabina@pstilia.hr",
//             "UrlVehicleArrived": "http://markoja.ipt.hr/api/rpm/vehiclearrived",
//             "UrlSlotPrepared": "http://markoja.ipt.hr/api/rpm/slotprepared",
//             "UrlScanned": "http://markoja.ipt.hr/api/rpm/scanned",
//             "UrlVehicleParked": "http://markoja.ipt.hr/api/rpm/vehicleparked",
//             "UrlVehicleDelivered": "http://markoja.ipt.hr/api/rpm/vehicledelivered",
//             "UrlBarrierLowered": "http://markoja.ipt.hr/api/rpm/barrierlowered",
//             "UrlBarrierRaised": "http://markoja.ipt.hr/api/rpm/barrierraised",
//             "RedSemaphoreOnNoScannedIn": 1,
//             "RedSemaphoreOnNoScannedOut": 1,
//             "ReservationReminderMinutesBefore": 10,
//             "ScanInTimeoutSeconds": 90,
//             "ScanOutTimeoutSeconds": 90,
//             "PeriodiGodine": null,
//             "Cjenik": null,
//             "CamSystemCrveniSemaforOnMaxBrojPokusaja": 1,
//             "RPSystemCrveniSemaforOnMaxBrojPokusaja": 1,
//             "ReservationInBuffer": 0,
//             "ReservationOutBuffer": 0,
//             "ReservationAdHocCancelationPeriod": 0,
//             "RedSemaphoreServiceStartMinutes": 0,
//             "RedSemaphoreServiceEndMinutes": 0,
//             "SetMessagageFromWeb": 1,
//             "CancelPreviousOccupancyWithSamePlateAsJustArrived": 0,
//             "IdleMessageNoError": "Garaža je spremna za novu aktivnost / Garage ready for new activity",
//             "MessagePermanentError": "Garaža trenutno nije u funkciji / Garage currenty is not in function",
//             "IdleMessageAutomaticallySetSeconds": 0,
//             "IdleMessageSet": 0,
//             "SetCSProcessFinishedFromWeb": 1,
//             "DisplayPoruke": null,
//             "TimeoutKoraci": null,
//             "DisplayPorukaIFrameURL": "https://sentinem.com/wgt/rotary/display.php",
//             "Message": null,
//             "ErrorMessage": null,
//             "Success": 0
