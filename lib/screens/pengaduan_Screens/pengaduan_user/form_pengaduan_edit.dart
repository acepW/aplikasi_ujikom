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

class EditPengaduanScreens extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final String image;
  final String id;
  const EditPengaduanScreens({super.key, required this.judul, required this.deskripsi, required this.image, required this.id});

  @override
  State<EditPengaduanScreens> createState() => _EditPengaduanScreensState();
}

class _EditPengaduanScreensState extends State<EditPengaduanScreens> {
  Uint8List? _image;

  final _formKey = GlobalKey<FormState>();
   final TextEditingController judulTextController =
      TextEditingController(text: "");
      final TextEditingController deskripsiTextController =
      TextEditingController(text: "");


  Uint8List? _pickedImage;
  String? imageUrl;
  Uint8List webImage = Uint8List(8);

  bool _obscureText = true;
@override
  void initState() {
    // TODO: implement initState
    judulTextController.text = widget.judul;
    deskripsiTextController.text = widget.deskripsi;
    super.initState();
  }

  @override
  void dispose() {
    judulTextController.dispose();

    deskripsiTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;



void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

     

    
      try {
        setState(() {
          _isLoading = true;
        });
        if (_pickedImage == null) {
          imageUrl = widget.image;
        } else {
          imageUrl = await StorageMethods()
              .uploadImageToStorage("aduanImages", _pickedImage!, true);
        }

        await FirebaseFirestore.instance.collection('aduan').doc(widget.id).update({
         
          'imageUrl': imageUrl,
         
          'judul': judulTextController.text,
          'deskripsi': deskripsiTextController.text,
          
        });
       
        Fluttertoast.showToast(
          msg: "Edit succefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: ,
          // textColor: ,
          // fontSize: 16.0
        );
        Navigator.pop(context);
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
               
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: judulTextController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid Judul";
                    } else {
                      return null;
                    }
                  },
                  maxLength: 30,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      
                      hintText: "Judul Pengaduan",
                      hintStyle: GoogleFonts.rubik(
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
                  maxLines: 50,
                  minLines: 1,
                  controller: deskripsiTextController,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "Deskripsi Pengaduan",
                      hintStyle: GoogleFonts.rubik(
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
                    style: GoogleFonts.rubik(
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
                    child:widget.image != ""
                            ? Container(
                            height: 200,
                            width: 270,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(widget.image),
                                )),
                          )
                            : _pickedImage == null
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
                        style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w400)))),
                TextButton(
                    onPressed: ()async {
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
                    },
                    child: Text(" Update Image",
                        style: GoogleFonts.rubik(
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
                              "Edit",
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
                    onPressed: () async {
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
                    },
                    child: Text("Chose an Image",
                        style: GoogleFonts.rubik(
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
