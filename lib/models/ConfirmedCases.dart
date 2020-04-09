// To parse this JSON data, do
//
//     final confirmedCases = confirmedCasesFromJson(jsonString);

import 'dart:convert';

List<ConfirmedCases> confirmedCasesFromJson(String str) => List<ConfirmedCases>.from(json.decode(str).map((x) => ConfirmedCases.fromJson(x)));

String confirmedCasesToJson(List<ConfirmedCases> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConfirmedCases {
    Country country;
    CountryCode countryCode;
    String lat;
    String lon;
    int cases;
    Status status;
    DateTime date;

    ConfirmedCases({
        this.country,
        this.countryCode,
        this.lat,
        this.lon,
        this.cases,
        this.status,
        this.date,
    });

    factory ConfirmedCases.fromJson(Map<String, dynamic> json) => ConfirmedCases(
        country: countryValues.map[json["Country"]],
        countryCode: countryCodeValues.map[json["CountryCode"]],
        lat: json["Lat"],
        lon: json["Lon"],
        cases: json["Cases"],
        status: statusValues.map[json["Status"]],
        date: DateTime.parse(json["Date"]),
    );

    Map<String, dynamic> toJson() => {
        "Country": countryValues.reverse[country],
        "CountryCode": countryCodeValues.reverse[countryCode],
        "Lat": lat,
        "Lon": lon,
        "Cases": cases,
        "Status": statusValues.reverse[status],
        "Date": date.toIso8601String(),
    };
}

enum Country { MEXICO }

final countryValues = EnumValues({
    "Mexico": Country.MEXICO
});

enum CountryCode { MX }

final countryCodeValues = EnumValues({
    "MX": CountryCode.MX
});

enum Status { CONFIRMED }

final statusValues = EnumValues({
    "confirmed": Status.CONFIRMED
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
