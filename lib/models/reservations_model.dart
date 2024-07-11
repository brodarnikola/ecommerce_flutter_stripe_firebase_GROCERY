import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ReservationsModel with ChangeNotifier {
  final int? RezervacijaID, RotoGarazaID, TipSlotID, PlaceniIznos;
  final String? Pocetak, Kraj;
  final String? Registracija, TipSlotNaziv, RotoGarazaNaziv;
  // final Timestamp orderDate;

  ReservationsModel(
      this.RezervacijaID,
      this.RotoGarazaID,
      this.TipSlotID,
      this.Registracija,
      this.RotoGarazaNaziv,
      this.TipSlotNaziv,
      this.Pocetak,
      this.Kraj,
      this.PlaceniIznos
      // this.orderDate
      );

  ReservationsModel.fromJson(Map<String, dynamic> json)
      : RezervacijaID = json['RezervacijaID'] as int,
        RotoGarazaID = json['RotoGarazaID'] as int,
        TipSlotID = json['TipSlotID'] as int,
        TipSlotNaziv = json['TipSlotNaziv'] != null ? json['TipSlotNaziv'] as String : null,
        RotoGarazaNaziv = json['RotoGarazaNaziv'] != null ? json['RotoGarazaNaziv'] as String : null,
        Pocetak = json['Pocetak'] != null ? json['Pocetak'] as String : null,
        Kraj = json['Kraj'] != null ? json['Kraj'] as String : null,
        Registracija = json['Registracija'] != null ? json['Registracija'] as String : null,
        PlaceniIznos = json['PlaceniIznos'] != null ? json['PlaceniIznos'] as int : null;
        // orderDate = json['orderDate'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'RezervacijaID': RezervacijaID,
        'RotoGarazaID': RotoGarazaID,
        'TipSlotID': TipSlotID,
        'TipSlotNaziv': TipSlotNaziv,
        'Pocetak': Pocetak,
        'Kraj': Kraj,
        'Registracija': Registracija,
        'RotoGarazaNaziv': RotoGarazaNaziv, 
        'PlaceniIznos': PlaceniIznos, 
        // 'orderDate': orderDate,
      };


  static List<ReservationsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ReservationsModel.fromJson(item as Map<String, dynamic>)).toList();
  }
} 

//  [{RezervacijaID: 75, RotoGarazaID: 18, TipSlotID: 1, TipSlotNaziv: Rezervacija - bez punjača, RotoGarazaNaziv: Garaža Zagreb, Registracija: ck201gl, Pocetak: 2024-07-11T09:00:00, Kraj: 2024-07-11T10:00:00, PlaceniIznos: 93}]


// [
//     {
//         "RezervacijaID": 75,
//         "RotoGarazaID": 18,
//         "TipSlotID": 1,
//         "TipSlotNaziv": "Rezervacija - bez punjača",
//         "RotoGarazaNaziv": "Garaža Zagreb",
//         "Registracija": "ck201gl",
//         "Pocetak": "2024-07-11T09:00:00",
//         "Kraj": "2024-07-11T10:00:00",
//         "PlaceniIznos": 93
//     }
// ]
