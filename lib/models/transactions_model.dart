import 'package:flutter/cupertino.dart';

// class PaymentsModel with ChangeNotifier {
//   final int? RezervacijaID, RotoGarazaID, TipSlotID, PlaceniIznos;
//   final String? Pocetak, Kraj;
//   final String? Registracija, TipSlotNaziv, RotoGarazaNaziv;
//   // final Timestamp orderDate;

//   PaymentsModel(
//       this.RezervacijaID,
//       this.RotoGarazaID,
//       this.TipSlotID,
//       this.Registracija,
//       this.RotoGarazaNaziv,
//       this.TipSlotNaziv,
//       this.Pocetak,
//       this.Kraj,
//       this.PlaceniIznos
//       // this.orderDate
//       );

//   PaymentsModel.fromJson(Map<String, dynamic> json)
//       : RezervacijaID = json['RezervacijaID'] as int,
//         RotoGarazaID = json['RotoGarazaID'] as int,
//         TipSlotID = json['TipSlotID'] as int,
//         TipSlotNaziv = json['TipSlotNaziv'] != null ? json['TipSlotNaziv'] as String : null,
//         RotoGarazaNaziv = json['RotoGarazaNaziv'] != null ? json['RotoGarazaNaziv'] as String : null,
//         Pocetak = json['Pocetak'] != null ? json['Pocetak'] as String : null,
//         Kraj = json['Kraj'] != null ? json['Kraj'] as String : null,
//         Registracija = json['Registracija'] != null ? json['Registracija'] as String : null,
//         PlaceniIznos = json['PlaceniIznos'] != null ? json['PlaceniIznos'] as int : null;
//         // orderDate = json['orderDate'] as Timestamp;

//   Map<String, dynamic> toJson() => {
//         'RezervacijaID': RezervacijaID,
//         'RotoGarazaID': RotoGarazaID,
//         'TipSlotID': TipSlotID,
//         'TipSlotNaziv': TipSlotNaziv,
//         'Pocetak': Pocetak,
//         'Kraj': Kraj,
//         'Registracija': Registracija,
//         'RotoGarazaNaziv': RotoGarazaNaziv, 
//         'PlaceniIznos': PlaceniIznos, 
//         // 'orderDate': orderDate,
//       };


//   static List<PaymentsModel> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((item) => PaymentsModel.fromJson(item as Map<String, dynamic>)).toList();
//   }
// } 

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

class TransactionResponse with ChangeNotifier {
  final String? message;
  final int? code, status;
  final List<TransactionModel> transactions;

  TransactionResponse(this.message, this.code, this.status, this.transactions);

  TransactionResponse.fromJson(Map<String, dynamic> json)
      : message = json['Message'],
        code = json['Code'],
        status = json['Status'],
        transactions = (json['Transactions'] as List<dynamic>).map((item) => TransactionModel.fromJson(item as Map<String, dynamic>)).toList();
}


class TransactionModel with ChangeNotifier {
  final String? transactionID, registracija, reklamacijskiBroj, parkingTvrtkaNaziv, garazaNaziv, tipSlotNaziv, description, shortStart, shortEnd, cardType, maskedCreditCardNumber, errDescription, transDescription, valutaKratkoIme, invoiceNumber, invoiceEmailAddress, tipStatusaPlacanja, created;
  final int? tipStatusaPlatneTransakcijeID, tipSlotID, cardTypeID, secondsLeft, quantity;
  final double? amount, tipSlotPrice;
  final String? tipSlotValuta;

  String? start, end;

  TransactionModel(
      this.transactionID,
      this.tipStatusaPlatneTransakcijeID,
      this.registracija,
      this.reklamacijskiBroj,
      this.parkingTvrtkaNaziv,
      this.garazaNaziv,
      this.tipSlotNaziv,
      this.tipSlotID,
      this.description,
      this.amount,
      this.start,
      this.shortStart,
      this.end,
      this.shortEnd,
      this.cardType,
      this.cardTypeID,
      this.secondsLeft,
      this.tipSlotPrice,
      this.tipSlotValuta,
      this.maskedCreditCardNumber,
      this.errDescription,
      this.transDescription,
      this.valutaKratkoIme,
      this.invoiceNumber,
      this.invoiceEmailAddress,
      this.tipStatusaPlacanja,
      this.created,
      this.quantity);

  TransactionModel.fromJson(Map<String, dynamic> json)
      : transactionID = json['TransactionID'],
        tipStatusaPlatneTransakcijeID = json['TipStatusaPlatneTransakcijeID'],
        registracija = json['Registracija'],
        reklamacijskiBroj = json['ReklamacijskiBroj'],
        parkingTvrtkaNaziv = json['ParkingTvrtkaNaziv'],
        garazaNaziv = json['GarazaNaziv'],
        tipSlotNaziv = json['TipSlotNaziv'],
        tipSlotID = json['TipSlotID'],
        description = json['Description'],
        amount = json['Amount'].toDouble(),
        start = json['Start'],
        shortStart = json['ShortStart'],
        end = json['End'],
        shortEnd = json['ShortEnd'],
        cardType = json['CardType'],
        cardTypeID = json['CardTypeID'],
        secondsLeft = json['SecondsLeft'],
        tipSlotPrice = json['TipSlotPrice'].toDouble(),
        tipSlotValuta = json['TipSlotValuta'],
        maskedCreditCardNumber = json['MaskedCreditCardNumber'],
        errDescription = json['ErrDescription'],
        transDescription = json['TransDescription'],
        valutaKratkoIme = json['ValutaKratkoIme'],
        invoiceNumber = json['InvoiceNumber'],
        invoiceEmailAddress = json['InvoiceEmailAddress'],
        tipStatusaPlacanja = json['TipStatusaPlacanja'],
        created = json['Created'],
        quantity = json['Quantity'];

  static List<TransactionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => TransactionModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}