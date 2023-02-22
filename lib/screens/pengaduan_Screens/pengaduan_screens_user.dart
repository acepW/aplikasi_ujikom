import 'package:aplikasi_ujikom/screens/drawer.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/form_pengaduasn.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/list_pengaduan.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/list_pengaduan_diproses.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/list_pengaduan_ditolak.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/list_pengaduan_diverifkasi.dart';
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
            style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                   color: Colors.blue
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Buatlah",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Sebuah Aduan",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                      ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Semua",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Aduan Anda",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
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
                          builder: (context) => ListPengaduanUserDiProses()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.purple,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aduan",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Di Proses",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
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
                          builder: (context) => ListPengaduanUserDiVerifikasi()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aduan",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Di Verifikasi",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
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
                          builder: (context) => ListPengaduanUserDiTolak()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aduan",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Di Tolak",
                            style: GoogleFonts.rubik(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
