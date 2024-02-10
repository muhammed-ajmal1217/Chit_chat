import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/mainwidgets/bacground_ellipse.dart';
import 'package:chitchat/mainwidgets/main_auth_button.dart';
import 'package:chitchat/views/otpscreen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneRequestPage extends StatefulWidget {
  const PhoneRequestPage({super.key});

  @override
  State<PhoneRequestPage> createState() => _PhoneRequestPageState();
}

class _PhoneRequestPageState extends State<PhoneRequestPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
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
    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: backroundGradient()),
        child: Stack(children: [
          Ellipses(),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.06,
              left: width * 0.05,
              right: width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                goBackArrow(context),
                spacingHeight(height * 0.01),
                titlesofAuth(
                    screenHeight: height,
                    title: 'Hello\nPlease Enter\nyour\nPhonenumber '),
                spacingHeight(height *0.02),
                TextFormField(
                  controller: phoneController,
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Enter your number',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: phoneController.text.length > 9
                          ? Icon(
                              Icons.done_sharp,
                              color: Colors.green,
                            )
                          : null,
                      prefixIcon: InkWell(
                        onTap: () {
                          showCountryPicker(
                            countryListTheme: CountryListThemeData(
                                borderRadius: BorderRadius.circular(20),
                                textStyle: TextStyle(color: Colors.white),
                                searchTextStyle: TextStyle(
                                    color: Colors.white,
                                    backgroundColor: Colors.white,
                                    height: 0.5,
                                    fontStyle: FontStyle.italic),
                                bottomSheetHeight: 500,
                                backgroundColor:
                                    Color.fromARGB(255, 33, 44, 149)),
                            context: context,
                            onSelect: (newValue) {
                              setState(() {
                                selectedCountry = newValue;
                              });
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 15, left: 15, right: 5),
                          child: Text(
                            "${selectedCountry.flagEmoji}"
                            '+'
                            "${selectedCountry.phoneCode}",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )),
                ),
                spacingHeight(height*0.02),
                textFields(text: 'Name', fontSize: 13),
                spacingHeight(height*0.02),
                textFields(text: 'E-mail', fontSize: 13),
                spacingHeight(height*0.04),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OtpScreen(),
                      ));
                    },
                    child: MainButtons(
                      screenHeight: height,
                      text: 'Send request',
                      onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(),)),
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}