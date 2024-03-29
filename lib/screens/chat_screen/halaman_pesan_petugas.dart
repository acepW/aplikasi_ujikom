import 'package:aplikasi_ujikom/global_methods.dart';
import 'package:aplikasi_ujikom/model/user_model.dart';
import 'package:aplikasi_ujikom/screens/chat_screen/halaman_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HalamanPesanPetugas extends StatefulWidget {
  UserModel userModel;
  HalamanPesanPetugas(this.userModel);

  @override
  State<HalamanPesanPetugas> createState() => _HalamanPesanPetugasState();
}

class _HalamanPesanPetugasState extends State<HalamanPesanPetugas> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              //   child: Container(
              //     height: 40,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(5),
              //         color: Colors.purple.withOpacity(0.10)),
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 16),
              //       child: TextField(
              //         style: GoogleFonts.poppins(
              //             textStyle: const TextStyle(
              //                 fontSize: 12, fontWeight: FontWeight.w500)),
              //         decoration: InputDecoration(
              //           border: InputBorder.none,
              //           icon: Icon(
              //             Icons.search,
              //             size: 15,
              //           ),
              //           hintText: 'Cari Pesan...',
              //           hintStyle: GoogleFonts.poppins(
              //               textStyle: const TextStyle(
              //                   fontSize: 12,
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.w500)),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('akun')
                        .doc(widget.userModel.uid)
                        .collection('messages')
                        .orderBy("last_date", descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length < 1) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 200, left: 20, right: 20),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/empty.png'))),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Cari Teman Klick",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.rubik(
                                                textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Icon(
                                          Icons.search,
                                          size: 30,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var friendId = snapshot.data.docs[index].id;
                              var lastMsg =
                                  snapshot.data.docs[index]['last_msg'];

                              bool isMe = snapshot.data.docs[index]
                                      ['sender_id'] ==
                                  widget.userModel.uid;
                              var last = snapshot.data.docs[index]['last_date']
                                  .toDate();

                              String messageType =
                                  snapshot.data.docs[index]['type'];
                              bool messageSeenMe =
                                  snapshot.data.docs[index]['isSeen'];
                              bool messageSeenFriend = snapshot.data.docs[index]
                                      ['isSeen'] ==
                                  friendId;

                              Widget messageWidget = Container();
                              Widget messageSeenWidgetMe = Container();
                              Widget messageSeenWidgetfriend = Container();

                              switch (messageSeenMe) {
                                case false:
                                  messageSeenWidgetMe = Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.purple),
                                    child: Center(
                                        child: Text("1",
                                            style: GoogleFonts.rubik(
                                                textStyle: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)))),
                                  );

                                  break;

                                case true:
                                  messageSeenWidgetMe = Container();

                                  break;
                              }

                              switch (messageSeenFriend) {
                                case false:
                                  messageSeenWidgetfriend = Container(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.done_all,
                                      color: Colors.grey,
                                    ),
                                  );

                                  break;

                                case true:
                                  messageSeenWidgetfriend = Container(
                                    height: 20,
                                    width: 20,
                                    child: Icon(
                                      Icons.done_all,
                                      color: Colors.purple,
                                    ),
                                  );

                                  break;
                              }

                              switch (messageType) {
                                case 'text':
                                  messageWidget = Container(
                                    height: 18,
                                    width: 300,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      "$lastMsg",
                                      style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  );
                                  break;

                                case 'img':
                                  messageWidget = Container(
                                    height: 18,
                                    width: 300,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Foto",
                                          style: GoogleFonts.rubik(
                                              textStyle: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                  );
                                  break;
                              }

                              return FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection('akun')
                                    .doc(friendId)
                                    .get(),
                                builder:
                                    (context, AsyncSnapshot asyncSnapshot) {
                                  if (asyncSnapshot.hasData) {
                                    var friend = asyncSnapshot.data;

                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: InkWell(
                                        onTap: () async {
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('akun')
                                                .doc(widget.userModel.uid)
                                                .collection('messages')
                                                .doc(friend['uid'])
                                                .update({"isSeen": true});
                                          } on FirebaseException catch (error) {
                                            GlobalMethods.errorDialog(
                                                subtitle: '${error.message}',
                                                context: context);
                                          } catch (error) {
                                            GlobalMethods.errorDialog(
                                                subtitle: '$error',
                                                context: context);
                                          } finally {}
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HalamanChat(
                                                          myName: widget
                                                              .userModel.name,
                                                          // fcmtoken:
                                                          //     friend['fcmtoken'],
                                                          currentUser: widget
                                                              .userModel.uid,
                                                          friendId:
                                                              friend['uid'],
                                                          friendName:
                                                              friend['name'],
                                                          friendEmail: friend['email'],    
                                                          friendImage: friend[
                                                                      'photoUrl']
                                                                  .toString()
                                                                  .isEmpty
                                                              ? 'https://i.stack.imgur.com/l60Hf.png'
                                                              : friend[
                                                                  'photoUrl'],
                                                          myImage: widget
                                                                  .userModel
                                                                  .photoUrl
                                                                  .toString()
                                                                  .isEmpty
                                                              ? 'https://i.stack.imgur.com/l60Hf.png'
                                                              : widget.userModel
                                                                  .photoUrl,
                                                          friendUsername: friend[
                                                              'username'])));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:5 ,right:5,bottom: 10 ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.purple),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      blurRadius: 10,
                                                      offset: Offset(2, 2))
                                                ]),
                                            height: 72,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24, right: 24),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        friend['photoUrl']
                                                                .toString()
                                                                .isEmpty
                                                            ? 'https://i.stack.imgur.com/l60Hf.png'
                                                            : friend['photoUrl']),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              height: 21,
                                                              width: 300,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    friend[
                                                                        'name'],
                                                                    style: GoogleFonts.rubik(
                                                                        textStyle: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            messageWidget
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            DateFormat.jm()
                                                                .format(last),
                                                            style:
                                                                GoogleFonts.rubik(
                                                              textStyle:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                            ),
                                                          ),
                                                          SizedBox(height: 5),
                                                          isMe
                                                              ? messageSeenWidgetfriend
                                                              : messageSeenWidgetMe
                                                        ],
                                                      ),
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
                                  return LinearProgressIndicator();
                                },
                              );
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
