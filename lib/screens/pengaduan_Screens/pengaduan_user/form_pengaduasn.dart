import 'dart:typed_data';

import 'package:aplikasi_ujikom/auth_method.dart';
import 'package:aplikasi_ujikom/firestore_methods.dart';
import 'package:aplikasi_ujikom/global_methods.dart';
import 'package:aplikasi_ujikom/model/user_model.dart';
import 'package:aplikasi_ujikom/screens/home_screens.dart';
import 'package:aplikasi_ujikom/screens/login_screens.dart';
import 'package:aplikasi_ujikom/storage_method.dart';
import 'package:aplikasi_ujikom/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BuatPengaduanScreens extends StatefulWidget {
  const BuatPengaduanScreens({super.key});

  @override
  State<BuatPengaduanScreens> createState() => _BuatPengaduanScreensState();
}

class _BuatPengaduanScreensState extends State<BuatPengaduanScreens> {
  Uint8List? _image;

  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();

  Uint8List? _pickedImage;
  String? imageUrl;
  Uint8List webImage = Uint8List(8);

  bool _obscureText = true;
  @override
  void dispose() {
    _judulController.dispose();

    _deskripsiController.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      final _uuid = const Uuid().v4();
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('akun')
          .doc(user!.uid)
          .get();
      UserModel userModel = UserModel.fromSnap(userData);
      try {
        setState(() {
          _isLoading = true;
        });
        if (_pickedImage == null) {
          imageUrl = '';
        } else {
          imageUrl = await StorageMethods()
              .uploadImageToStorage("aduanImages", _pickedImage!, true);
        }

        await FirebaseFirestore.instance.collection('aduan').doc(_uuid).set({
          'postId': _uuid,
          'photoUrl': userModel.photoUrl,
          'imageUrl': imageUrl,
          'name': userModel.name,
          'pengaduId': userModel.uid,
          'judul': _judulController.text,
          'deskripsi': _deskripsiController.text,
          'status': "di periksa",
          'createdAt': DateTime.now(),
        });
        _clearForm();
        Fluttertoast.showToast(
          msg: "Uploaded succefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: ,
          // textColor: ,
          // fontSize: 16.0
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
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

  void _clearForm() {
    _judulController.clear();
    _deskripsiController.clear();
    _pickedImage = null;
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _judulController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid Judul";
                    } else {
                      return null;
                    }
                  },
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Judul Pengaduan",
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid  Deskripsi";
                    } else {
                      return null;
                    }
                  },
                  maxLines: 20,
                  minLines: 1,
                  controller: _deskripsiController,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Deskripsi Pengaduan",
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Tambahkan Gambar Jika Ada",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.width > 650
                        ? 350
                        : MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: _pickedImage == null
                        ? dottedBorder(color: Colors.black)
                        : Container(
                            height: 200,
                            width: 270,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: MemoryImage(_pickedImage!),
                                )),
                          ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _pickedImage = null;
                        webImage = Uint8List(8);
                      });
                    },
                    child: Text("Clear",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)))),
                TextButton(
                    onPressed: () {},
                    child: Text(" Update Image",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)))),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    _uploadForm();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Submit",
                              style: GoogleFonts.poppins(
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
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget dottedBorder({
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
          dashPattern: const [6.7],
          borderType: BorderType.RRect,
          color: color,
          radius: const Radius.circular(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_outlined,
                  color: color,
                  size: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (() async {
                      try {
                        Uint8List file = await pickImage(ImageSource.gallery);
                        if (file != null) {
                          setState(() {
                            _pickedImage = file;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    }),
                    child: Text("Chose an Image",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w400))))
              ],
            ),
          )),
    );
  }
}
