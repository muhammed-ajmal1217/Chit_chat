import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneReqProvider extends ChangeNotifier {
  TextEditingController phoneController = TextEditingController();
  Country selectedCountry = Country(
        phoneCode: "91",
        countryCode: "IN",
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: "India",
        example: "India",
        displayName: "India",
        displayNameNoCountryCode: "IN",
        e164Key: "");
  newCountry(value) {
    phoneController.text = value;
    notifyListeners();
  }
  onselectValue(newValue){
    selectedCountry = newValue;
    notifyListeners();
  }
}