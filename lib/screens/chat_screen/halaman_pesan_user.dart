import 'package:aplikasi_ujikom/model/user_model.dart';
import 'package:aplikasi_ujikom/screens/chat_screen/halaman_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class HalamanPesanUser extends StatelessWidget {
  UserModel userModel;
  HalamanPesanUser(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20,left: 24,right: 24),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Pilih Petugas",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            height:300 ,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('akun')
                  .where('role', isEqualTo: 'petugas')
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length < 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/empty.png'))),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                    
                      itemBuilder: (context, index) {
                        String friendId = snapshot.data.docs[index]['uid'];
                        String friendName = snapshot.data.docs[index]['name'];
                        String friendEmail = snapshot.data.docs[index]['email'];
                        String friendImage =
                            snapshot.data.docs[index]['photoUrl'];
                        String friendUsername =
                            snapshot.data.docs[index]['username'];
          
                        return Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5,bottom: 10 ),
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
                            child: Padding(
                              padding: EdgeInsets.only(left: 24,right: 24),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HalamanChat(
                                            myImage: userModel.photoUrl,
                                            myName: userModel.name,
                                            // fcmtoken: (snapshot.data! as dynamic).docs[index]
                                            //     ['fcmtoken'],
                                            currentUser: userModel.uid,
                                            friendId: friendId,
                                            friendName: friendName,
                                            friendEmail: friendEmail,
                                            
                                            friendImage: friendImage
                                                    .toString()
                                                    .isEmpty
                                                ? 'https://i.stack.imgur.com/l60Hf.png'
                                                : friendImage,
                                            friendUsername: friendUsername))),
                                child: Container(
                                  height: 72,
                                  child: Row(
                                    children: [
                                      friendImage.toString().isEmpty
                                          ? CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                  'https://i.stack.imgur.com/l60Hf.png'),
                                            )
                                          : CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                friendImage,
                                              )),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 21,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      friendName,
                                                      style: GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 18,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      friendEmail,
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              color: Colors.black
                                                                  .withOpacity(0.5),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight.w500)),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(Icons.keyboard_arrow_right_outlined)
                                    ],
                                  ),
                                ),
                              ),
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
              },
            ),
          ),


          
        ],
      ),
    );
  }
}
