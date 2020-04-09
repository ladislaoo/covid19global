// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) => List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
    String country;
    String slug;
    String iso2;

    Countries({
        this.country,
        this.slug,
        this.iso2,
    });

    factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        country: json["Country"],
        slug: json["Slug"],
        iso2: json["ISO2"],
    );

    Map<String, dynamic> toJson() => {
        "Country": country,
        "Slug": slug,
        "ISO2": iso2,
    };
}
