import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:bet_seed/backends/all_repos.dart';
import 'package:bet_seed/utils/colors.dart';
import 'package:bet_seed/utils/strings.dart';
import 'package:bet_seed/widgets/cust_button.dart';
import 'package:bet_seed/widgets/cust_text_field.dart';
import 'package:bet_seed/widgets/prog_indicator.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AllRepos _allRepos = AllRepos();

  String? _email, _password;
  GlobalKey<FormState> _signKey = GlobalKey();
  bool _obscure = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    Size med = MediaQuery.of(context).size;
    return LoadingOverlay(
      isLoading: _loading,
      progressIndicator: ProgIndicator(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            height: med.height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: transparent,
                          backgroundImage:
                              AssetImage('assets/images/logo_2.png'),
                        ),
                        SizedBox(width: 20),
                        Column(
                          children: [
                            Text(
                              'EZ Bet Tips ',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Admin App',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: GoogleFonts.aclonica().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Form(
                      key: _signKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustTextField(
                            width: double.infinity,
                            hintText: 'Enter Email',
                            validator: _allRepos.validateEmail,
                            onChanged: (String? val) {
                              setState(() {
                                _email = val;
                              });
                            },
                          ),
                          SizedBox(height: 5),
                          CustTextField(
                            width: double.infinity,
                            hintText: 'Enter Password',
                            obscureText: _obscure,
                            onChanged: (String? val) {
                              setState(() {
                                _password = val;
                              });
                            },
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscure = !_obscure;
                                });
                              },
                              icon: Icon(
                                _obscure ? IconlyLight.hide : IconlyLight.show,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          CustomButton(
                            title: 'Sign In',
                            onTap: () => _signFxn(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _signFxn() async {
    if (_signKey.currentState!.validate()) {
      _signKey.currentState!.save();
      setState(() {
        _loading = true;
      });
      try {
        Map data = {
          'email': _email,
          "password": _password,
        };
        await _allRepos.signIn(data, context).then((value) {
          if (value) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        });
      } catch (e) {
        _allRepos.showSnacky(DEFAULT_ERROR, false, context);
      }
      setState(() {
        _loading = false;
      });
    }
  }
}
