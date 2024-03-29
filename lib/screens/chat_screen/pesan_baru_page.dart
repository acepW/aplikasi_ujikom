import 'package:aplikasi_ujikom/model/user_model.dart';

import 'package:aplikasi_ujikom/screens/chat_screen/pesan_baru.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HalamanPesanBaruPage extends StatelessWidget {
  const HalamanPesanBaruPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Widget> chatPage() async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('akun')
            .doc(user.uid)
            .get();
        UserModel userModel = UserModel.fromSnap(userData);
        return
         PesanBaruScreen(
          userModel,
        );
      } else {
        return Container();
      }
    }

    return FutureBuilder(
        future: chatPage(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        });
  }
}
