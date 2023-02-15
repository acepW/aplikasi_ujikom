import 'package:aplikasi_ujikom/screens/drawer.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_petugas/list_aduan_petugas_ditolak.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas_diproses.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas_diverivikasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaduanScreensPetugas extends StatefulWidget {
  const PengaduanScreensPetugas({super.key});

  @override
  State<PengaduanScreensPetugas> createState() =>
      _PengaduanScreensPetugasState();
}

class _PengaduanScreensPetugasState extends State<PengaduanScreensPetugas> {
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
                          builder: (context) => ListPengaduanPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin:Alignment.centerLeft ,
                        end:Alignment.centerRight ,
                        colors: [
                          Colors.black,
                          Colors.transparent
                        ])
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
                            "Aduan User",
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
                          builder: (context) => ListPengaduanDiperiksaPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin:Alignment.centerLeft ,
                        end:Alignment.centerRight ,
                        colors: [
                          Colors.yellow,
                          Colors.transparent
                        ])
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
                          builder: (context) =>
                              ListPengaduanVerifikasiPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin:Alignment.centerLeft ,
                        end:Alignment.centerRight ,
                        colors: [
                          Colors.green,
                          Colors.transparent
                        ])
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
                            "Di Verefikasi",
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
                          builder: (context) =>
                              ListPengaduanDiTolakPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin:Alignment.centerLeft ,
                        end:Alignment.centerRight ,
                        colors: [
                          Colors.yellow,
                          Colors.transparent
                        ])
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
