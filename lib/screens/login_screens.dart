import 'package:aplikasi_ujikom/const/firebase_const.dart';
import 'package:aplikasi_ujikom/global_methods.dart';
import 'package:aplikasi_ujikom/model/user_model.dart';
import 'package:aplikasi_ujikom/provider/user_provider.dart';
import 'package:aplikasi_ujikom/screens/btm_bar.dart';
import 'package:aplikasi_ujikom/screens/forget_password.dart';
import 'package:aplikasi_ujikom/screens/home_screens.dart';
import 'package:aplikasi_ujikom/screens/registrasi_screens.dart';
import 'package:aplikasi_ujikom/screens/validasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passFocusNode = FocusNode();
  var _obscureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  Future<void> _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    User? user = FirebaseAuth.instance.currentUser;
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());

        // ignore: use_build_context_synchronously

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ValidasiScreens(),
        ));

        print('Successfully logged in');
      } on FirebaseException catch (error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: '${error.message}',
        );
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: '$error',
        );
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 70, bottom: 10),
              child: Column(
                children: [
                  Text("Aplikasi Pengaduan Sekolah",
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.w500))),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.asset(
                      'assets/images/pengaduan.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Masukkan email dengan benar';
                            } else {
                              return null;
                            }
                          },
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.purple),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.purple),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Email",
                              hintStyle: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormOnLogin();
                          },
                          controller: _passTextController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty || value.length <= 5) {
                              return 'Masukkan password dengan benar';
                            } else {
                              return null;
                            }
                          },
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.purple,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.purple),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.purple),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: "Password",
                              hintStyle: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPasswordScreen()));
                                  },
                                  child: Text("Lupa Password?",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.purple,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500)))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            
                            _submitFormOnLogin();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Login",
                                      style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500)),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Belum punya akun?",
                                style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500)),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrasiScreens()));
                                  },
                                  child: Text("Daftar di sini",
                                      style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                              color: Colors.purple,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500))))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
