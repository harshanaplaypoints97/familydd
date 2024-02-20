import 'package:familydriver/Api/Register_Api_End_Point.dart';
import 'package:familydriver/constant/App_color.dart';
import 'package:familydriver/screens/widgets/Rouned_boutton.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AutovalidateMode switched = AutovalidateMode.disabled;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey6 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey7 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey8 = GlobalKey<FormState>();

  final _vehicleTypeController = TextEditingController();
  final _userRoleController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerEmailController = TextEditingController();
  final _customerPhonenumberController = TextEditingController();
  final _customerPasswordController = TextEditingController();
  final _vehiclenumberController = TextEditingController();
  final _nicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        Text(
                          'Your journey begins with a simple sign-up',
                          style: TextStyle(
                            color: AppColors.drivercardnotactive,
                            fontSize: 18,
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/logo.png'),
                          height: 150,
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.logingbox,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey1,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        autovalidateMode: switched,
                                        controller: _customerNameController,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                          hintText: "Name",
                                          filled: true,
                                          fillColor: AppColors.secondaryColor,
                                          contentPadding: EdgeInsets.all(11.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 248, 249, 249),
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  AppColors.drivercardnotactive,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ' Name is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey2,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        autovalidateMode: switched,
                                        controller: _customerEmailController,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                          hintText: "Email",
                                          filled: true,
                                          fillColor: AppColors.secondaryColor,
                                          contentPadding: EdgeInsets.all(11.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  AppColors.drivercardnotactive,
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  AppColors.drivercardnotactive,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Email is required';
                                          }
                                          // Check if the input follows the email format
                                          if (!RegExp(
                                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                              .hasMatch(value)) {
                                            return 'Enter a valid email';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey3,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        autovalidateMode: switched,
                                        controller:
                                            _customerPhonenumberController,
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                          hintText: "Phone Number",
                                          filled: true,
                                          fillColor: AppColors.secondaryColor,
                                          contentPadding: EdgeInsets.all(11.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 248, 249, 249),
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  AppColors.drivercardnotactive,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Phone Number required';
                                          }
                                          if (value.length != 10 ||
                                              int.tryParse(value) == null) {
                                            return 'Phone Number must be 10 digits';
                                          }
                                          //only 10 input numbers validation
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey8,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        autovalidateMode: switched,
                                        controller: _nicController,
                                        keyboardType: TextInputType
                                            .text, // Allow text input for letter in NIC
                                        style: const TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                          hintText: "NIC Number",
                                          filled: true,
                                          fillColor: AppColors.secondaryColor,
                                          contentPadding: EdgeInsets.all(11.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 248, 249, 249),
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  AppColors.drivercardnotactive,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'NIC Number required';
                                          }
                                          // Regular expression to match exactly 9 numbers with only one letter or exactly 10 numbers
                                          if (!RegExp(r'^\d{9}[A-Z]$|^\d{10}$')
                                              .hasMatch(value)) {
                                            return 'Invalid NIC Number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),

                                  Form(
                                    key: _formKey4,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        autovalidateMode: switched,
                                        controller: _customerPasswordController,
                                        keyboardType: TextInputType.name,
                                        style: const TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                        ),
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: AppColors.primaryColor,
                                          ),
                                          hintText: "Password",
                                          filled: true,
                                          fillColor: AppColors.secondaryColor,
                                          contentPadding: EdgeInsets.all(11.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 248, 249, 249),
                                              width: 2.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  AppColors.drivercardnotactive,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password is required';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        maxLength: 8,
                                        // Display input as dots
                                      ),
                                    ),
                                  ),

                                  // Add other Form widgets similarly
                                  Form(
                                    key: _formKey6,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5),
                                          DropdownButtonFormField<String>(
                                            autovalidateMode: switched,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _userRoleController.text =
                                                    value.toString();
                                              });
                                              // Handle the selected value here if needed
                                              print('Selected value: $value');
                                            },
                                            decoration: InputDecoration(
                                              hintStyle: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize: 14,
                                                color: AppColors.primaryColor,
                                              ),
                                              hintText: 'Select Role',
                                              filled: true,
                                              fillColor:
                                                  AppColors.secondaryColor,
                                              contentPadding:
                                                  EdgeInsets.all(11.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 248, 249, 249),
                                                  width: 2.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: AppColors
                                                      .drivercardnotactive,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            items: ["Driver", "Customer"]
                                                .map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select an option';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _userRoleController.text == "Driver"
                                      ? Form(
                                          key: _formKey5,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: TextFormField(
                                              autovalidateMode: switched,
                                              controller:
                                                  _vehiclenumberController,
                                              keyboardType: TextInputType.name,
                                              style: const TextStyle(
                                                fontFamily: 'inter',
                                                fontSize: 14,
                                                color: AppColors.primaryColor,
                                              ),
                                              decoration: InputDecoration(
                                                hintStyle: TextStyle(
                                                  fontFamily: 'inter',
                                                  fontSize: 14,
                                                  color: AppColors.primaryColor,
                                                ),
                                                hintText: "Vehicle Number",
                                                filled: true,
                                                fillColor:
                                                    AppColors.secondaryColor,
                                                contentPadding:
                                                    EdgeInsets.all(11.0),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 248, 249, 249),
                                                    width: 2.0,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: AppColors
                                                        .drivercardnotactive,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Vehicle Number is required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  _userRoleController.text == "Driver"
                                      ? Form(
                                          key: _formKey7,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5),
                                                DropdownButtonFormField<String>(
                                                  autovalidateMode: switched,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _vehicleTypeController
                                                              .text =
                                                          value.toString();
                                                    });
                                                    print(
                                                        'Selected value: $value');
                                                  },
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                      fontFamily: 'inter',
                                                      fontSize: 14,
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                    hintText: ' Vehicle Type',
                                                    filled: true,
                                                    fillColor: AppColors
                                                        .secondaryColor,
                                                    contentPadding:
                                                        EdgeInsets.all(11.0),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5.0),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 248, 249, 249),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5.0),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: AppColors
                                                            .drivercardnotactive,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  items: ["Auto", "Manual"]
                                                      .map((String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please select an option';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox(
                                    width: 200, // Set the desired width
                                    child: RoundedButton(
                                        color: AppColors.drivercardactive,
                                        buttonText: "Sign in",
                                        onPress: () async {
                                          setState(() {
                                            switched = AutovalidateMode.always;
                                          });

                                          try {
                                            if (_customerNameController.text !=
                                                    "" &&
                                                _customerEmailController.text !=
                                                    "" &&
                                                _customerPhonenumberController.text !=
                                                    "" &&
                                                _customerPasswordController
                                                        .text !=
                                                    "" &&
                                                _userRoleController.text !=
                                                    "") if (_userRoleController.text ==
                                                "Driver") {
                                              RegisterApi.register(
                                                  _customerNameController.text,
                                                  _customerEmailController.text,
                                                  _customerPhonenumberController
                                                      .text,
                                                  _customerPasswordController
                                                      .text,
                                                  _userRoleController.text,
                                                  "",
                                                  _vehiclenumberController.text,
                                                  _vehicleTypeController.text,
                                                  context);
                                            } else {
                                              RegisterApi.register(
                                                  _customerNameController.text,
                                                  _customerEmailController.text,
                                                  _customerPhonenumberController
                                                      .text,
                                                  _customerPasswordController
                                                      .text,
                                                  _userRoleController.text,
                                                  "",
                                                  "",
                                                  "",
                                                  context);
                                            }

                                            // If login is successful, you can navigate to the next screen or perform other actions
                                          } catch (e) {
                                            // Handle any errors during the login process
                                          } finally {
                                            setState(() {
                                              isLoading =
                                                  false; // Set isLoading to false when the login process is complete
                                            });
                                          }
                                        }),
                                  ),

                            //
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
