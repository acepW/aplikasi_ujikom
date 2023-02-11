import 'package:aplikasi_ujikom/screens/drawer.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/form_pengaduasn.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/list_pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaduanScreensUser extends StatefulWidget {
  const PengaduanScreensUser({super.key});

  @override
  State<PengaduanScreensUser> createState() => _PengaduanScreensUserState();
}

class _PengaduanScreensUserState extends State<PengaduanScreensUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
            children: [DrawerHome()],
          )),
        ),
        appBar: AppBar(
           backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Pengaduan",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500))),
        ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuatPengaduanScreens()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: Colors.purple,
                child: Center(
                  child: Text(
                    "Buat Aduan",
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListPengaduanUser()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                color: Colors.purple,
                child: Center(
                  child: Text(
                    "Aduan Saya",
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
