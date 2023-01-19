import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/firebase/firebase_services.dart';
import 'package:chatapp/screens/widgets/custom_button_widget.dart';
import 'package:chatapp/screens/components/components.dart';
import 'package:chatapp/screens/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const route = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool is_login = true;
  String? email;
  String? password;
  bool _loading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              logo(),
              const SizedBox(height: 75),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(is_login ? 'Sign In' : 'Sign Up',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        hint: 'email',
                        onChanged: (data) {
                          email = data;
                        },
                        validator: (data) {
                          if (data!.isEmpty){
                            return 'email is required';
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hint: 'password',
                        onChanged: (data) {
                          password = data;
                        },
                        validator: (data) {
                          if (data!.isEmpty){
                            return 'password is required';
                          }
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      CustomButtonWidget(
                        label: is_login ? 'Sign In' : 'Sign Up',
                        onPressed: () async {
                          setState(() {
                            _loading = true;
                          });
                          if (formKey.currentState!.validate()){
                            if (is_login) {
                              await FireBaseServices.signInWithEmailAndPassword(
                                  context, email!, password!);
                            } else {
                              await FireBaseServices.createUserWithEmailAndPassword(
                                  context, email!, password!);
                              setState(() {
                                is_login = true;
                              });
                            }
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                      ),
                      haveAccountOrNot(
                        is_login: is_login,
                        onPressed: () {
                          setState(
                            () {
                              is_login = !is_login;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
