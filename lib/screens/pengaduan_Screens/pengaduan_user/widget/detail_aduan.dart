import 'package:aplikasi_ujikom/global_methods.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_user/form_pengaduan_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class DetailAduanUSer extends StatefulWidget {
  const DetailAduanUSer(
      {super.key,
      required this.judul,
      required this.deskripsi,
      required this.postId,
      required this.status,
      required this.imageUrl,
      required this.name,
      required this.tanggal});
  final String judul, deskripsi, postId, status, imageUrl, name;
  final DateTime tanggal;

  @override
  State<DetailAduanUSer> createState() => _DetailAduanUSerState();
}

class _DetailAduanUSerState extends State<DetailAduanUSer> {
  @override
  Widget build(BuildContext context) {
    Widget status = Container();
    switch (widget.status) {
      case "di periksa":
        status = Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text("Sedang Di Periksa",
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))),
          ),
        );
        break;
      case "di verifikasi":
        status = Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text("Di Verifikasi",
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))),
          ),
        );
        break;
      case "di tolak":
        status = Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text("Di Tolak",
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))),
          ),
        );
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconlyLight.arrowLeft2,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Ditulis oleh ${widget.name}",
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))),
                      Spacer(),
                      IconButton(
                          onPressed: () async {
                            await QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              title: 'Yakin Hapus Aduan?',
                              text: "",
                              confirmBtnText: 'Yes',
                              customAsset: "assets/error.gif",
                              cancelBtnText: 'No',
                              onConfirmBtnTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('aduan')
                                    .doc(widget.postId)
                                    .delete();

                                return Navigator.pop(context);
                              },
                              confirmBtnColor: Colors.green,
                            );
                            return Navigator.pop(context);
                          },
                          icon: Icon(IconlyLight.delete)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EditPengaduanScreens(
                                judul: widget.judul,
                                deskripsi: widget.deskripsi,
                                image: widget.imageUrl,
                                id: widget.postId,
                              );
                            }));
                          },
                          icon: Icon(IconlyLight.edit))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Pada ${DateFormat.yMd().add_jm().format(widget.tanggal)}",
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [status],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.judul,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: Text(widget.deskripsi,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400))),
                        ),
                      ),
                      widget.imageUrl == ""
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.network(
                                    widget.imageUrl,
                                    fit: BoxFit.contain,
                                  )),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5,
                  color: Colors.purple,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text("Tanggapan",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rubik(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('aduan')
                                .doc(widget.postId)
                                .collection('tanggapan')
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.docs.length < 1) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text("Belum ada Tanggapan",
                                        style: GoogleFonts.rubik(
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500))),
                                  );
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.docs.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      String name =
                                          snapshot.data.docs[index]['name'];
                                      String tanggapan = snapshot
                                          .data.docs[index]['tanggapan'];
                                      var time = snapshot
                                          .data.docs[index]['createdAt']
                                          .toDate();

                                      String userId =
                                          snapshot.data.docs[index]['userId'];
                                      String photoUrl =
                                          snapshot.data.docs[index]['photoUrl'];
                                      String tanggapanId = snapshot
                                          .data.docs[index]['tanggapanId'];

                                      return Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              photoUrl == ""
                                                  ? CircleAvatar(
                                                      radius: 25,
                                                      backgroundImage: NetworkImage(
                                                          'https://i.stack.imgur.com/l60Hf.png'),
                                                    )
                                                  : CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              photoUrl)),
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                    name,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts.rubik(
                                                                        textStyle: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold))),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                    tanggapan,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: GoogleFonts.rubik(
                                                                        textStyle: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400))),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.purple,
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
