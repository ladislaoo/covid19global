import 'package:covid19global/models/Countries.dart';
import 'package:covid19global/models/SummaryCases.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class CountryModel with ChangeNotifier{

  List<Countries> _countries;
  //List<Country> _country;
  Country _countrySelected;

  //

  //getter
  Country get countrySelected =>_countrySelected;

  setCountrySelected(Country country){
    _countrySelected=country;
    notifyListeners();
  }
  List<Countries> get countries => _countries;

  setCountry(List<Countries> countries){
    _countries=countries;
    notifyListeners();
  }

  Future<List<Countries>> fetchData() async {
    List<Countries> _countries = new List<Countries>();
    final response = await http.get("https://api.covid19api.com/countries");
      if(response.statusCode  ==  200){
        _countries = countriesFromJson(response.body);
        _countries.sort((a, b) => a.country.compareTo(b.country));
        return _countries;
      }else {
        print("Exception occured: ");
        throw Exception("Failed");
      }
       
  }
  Future<List<Country>> fetchSummaryData(bool asc) async {
    List<Country> _countries = new List<Country>();
    final response = await http.get("https://api.covid19api.com/summary");
      if(response.statusCode  ==  200){
        
        SummaryCases summaryCases= summaryCasesFromJson(response.body);
        
        _countries=summaryCases.countries;
        if(asc){
          _countries.sort((a, b) => a.totalConfirmed.compareTo(b.totalConfirmed));//Ascending
        }else{
           _countries.sort((b, a) => a.totalConfirmed.compareTo(b.totalConfirmed));//Descending
        }
      


        
        return _countries;
      }else {
        print("Exception occured: ");
        throw Exception("Failed");
      }
       
  }

  //https://api.covid19api.com/summary
}