import 'package:aplikasi_ujikom/auth_method.dart';
import 'package:aplikasi_ujikom/provider/user_provider.dart';
import 'package:aplikasi_ujikom/screens/chat_screen/chat_page.dart';
import 'package:aplikasi_ujikom/screens/chat_screen/pesan_baru.dart';
import 'package:aplikasi_ujikom/screens/chat_screen/pesan_baru_page.dart';
import 'package:aplikasi_ujikom/screens/drawer.dart';
import 'package:aplikasi_ujikom/screens/login_screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).refreshUser();
    return Scaffold(
      drawer: Drawer(
        width: 200,
        child: DrawerHome(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Aplikasi Ujikom",
            style: GoogleFonts.rubik(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))),
      ),
      body: HalamanChatPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HalamanPesanBaruPage();
          }));
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.search),
      ),
    );
  }
}
