import 'package:chitchat/controller/auth_provider.dart';
import 'package:chitchat/controller/phone_request_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/main_widgets/bacground_ellipse.dart';
import 'package:chitchat/main_widgets/main_auth_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneRequestPage extends StatefulWidget {
  const PhoneRequestPage({super.key});

  @override
  State<PhoneRequestPage> createState() => _PhoneRequestPageState();
}

class _PhoneRequestPageState extends State<PhoneRequestPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final phoneReqPro = Provider.of<PhoneReqProvider>(context);
    phoneReqPro.phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneReqPro.phoneController.text.length));

    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(children: [
          Ellipses(),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.06,
              left: width * 0.05,
              right: width * 0.05,
            ),
            child: Consumer<AuthenticationProvider>(
              builder: (context, authPro, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  goBackArrow(context),
                  spacingHeight(height * 0.01),
                  titlesofAuth(
                      screenHeight: height,
                      title: 'Hello\nPlease Enter\nyour\nPhonenumber '),
                  spacingHeight(height * 0.02),
                  TextFormField(
                    controller: phoneReqPro.phoneController,
                    onChanged: (value) {},
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: 'Enter your number',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: phoneReqPro.phoneController.text.length > 9
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
                                  searchTextStyle: TextStyle(
                                      color: Colors.white,
                                      height: 0.5,
                                      fontStyle: FontStyle.italic),
                                  bottomSheetHeight: 500,
                                  backgroundColor:
                                      Color.fromARGB(255, 13, 13, 14)),
                              context: context,
                              onSelect: (newValue) {
                                phoneReqPro.onselectValue(newValue);
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 15, left: 15, right: 5),
                            child: Text(
                              "${phoneReqPro.selectedCountry.flagEmoji}"
                              '+'
                              "${phoneReqPro.selectedCountry.phoneCode}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )),
                  ),
                  spacingHeight(height * 0.02),
                  textFields(
                      text: 'Name', fontSize: 13, controller: nameController),
                  spacingHeight(height * 0.02),
                  textFields(
                      text: 'E-mail',
                      fontSize: 13,
                      controller: emailController),
                  spacingHeight(height * 0.04),
                  MainButtons(
                      screenHeight: height,
                      screenWidth: width,
                      text: 'Send request',
                      onPressed: () => authPro.signinWithPhone(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: '+'+ phoneReqPro.selectedCountry.phoneCode +
                              phoneReqPro.phoneController.text.trim(),
                          context: context)),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
