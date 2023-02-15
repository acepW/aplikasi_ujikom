import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_petugas/widget/detail_aduan_petugas.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/widget/aduan_card.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/widget/detail_aduan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPengaduanVerifikasiPetugas extends StatefulWidget {
  const ListPengaduanVerifikasiPetugas({super.key});

  @override
  State<ListPengaduanVerifikasiPetugas> createState() =>
      _ListPengaduanVerifikasiPetugasState();
}

class _ListPengaduanVerifikasiPetugasState
    extends State<ListPengaduanVerifikasiPetugas> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
          title: Text("Pengaduan Di Verifikasi",
              style: GoogleFonts.rubik(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500))),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('aduan')
                  .where('status', isEqualTo: 'di verifikasi')
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length < 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text("Belum Ada Aduanmu",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String judul = snapshot.data.docs[index]['judul'];
                        String deskripsi =
                            snapshot.data.docs[index]['deskripsi'];
                        var time =
                            snapshot.data.docs[index]['createdAt'].toDate();
                        String imageUrl = snapshot.data.docs[index]['imageUrl'];
                        String name = snapshot.data.docs[index]['name'];
                        String pengaduId =
                            snapshot.data.docs[index]['pengaduId'];
                        String photoUrl = snapshot.data.docs[index]['photoUrl'];
                        String postId = snapshot.data.docs[index]['postId'];
                        String status = snapshot.data.docs[index]['status'];
                        return CardAduan(judul: judul, deskripsi: deskripsi, onTap: (){
                          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailAduanPetugas(
                                        judul: judul,
                                        deskripsi: deskripsi,
                                        postId: postId,
                                        status: status,
                                        imageUrl: imageUrl,
                                        name: name,
                                        tanggal: time)));
                        }, time: time);
                      });
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              },
            )),
      ),
    );
  }
}
