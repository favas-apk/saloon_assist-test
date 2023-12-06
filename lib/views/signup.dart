/* // ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/controllers/authenticationControllers.dart';
import 'package:saloon_assist/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey;
  // RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    // bool isTab = Responsive.isTablet(context);
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const Expanded(
            child: SizedBox(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      //    height: MediaQuery.of(context).size.height / 3,
                      //  fit: BoxFit.contain,
                      //color: Colors.white,
                      backgroundImage: AssetImage('assets/login.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: isMobile
                  ? const EdgeInsets.all(15)
                  : const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Consumer<AuthenticationProvider>(
                  builder: (context, val, child) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: isMobile
                                ? const EdgeInsets.all(5.0)
                                : const EdgeInsets.all(20.0),
                            child: Text('Login Here', style: headStyle),
                          ),
                        ),
                        const Divider(),
                        space(context),
                        TextFormField(
                          onChanged: (value) {
                            val.setUserName(value);
                          },
                          validator: (value) {
                            if (value == '' || value == null) {
                              return 'Username required !!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: secondaryColor,
                              ),
                              hintText: 'Enter Username'),
                        ),
                        SizedBox(
                          height: isMobile
                              ? MediaQuery.of(context).size.height * .02
                              : MediaQuery.of(context).size.height * .03,
                        ),
                        TextFormField(
                          obscureText: val.isVisible,
                          onChanged: (value) {
                            val.setPassword(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'Password required !!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.vpn_key,
                                color: secondaryColor,
                              ),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    val.showPasword();
                                  },
                                  child: Icon(!val.isVisible
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye)),
                              hintText: 'Enter Password'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account ? signup "),
                                InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      "here",
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: isMobile
                                ? MediaQuery.of(context).size.height * .05
                                : MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Consumer<AuthenticationProvider>(
                              builder: (context, value, child) =>
                                  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shape: const StadiumBorder(),
                                    backgroundColor: primaryColor),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await value.login(context);
                                  } else {}
                                },
                                child: Text(
                                  'LOGIN',
                                  style: whiteText,
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),

                        /* const Expanded(
                            child: SizedBox(),
                          ) */
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
 */