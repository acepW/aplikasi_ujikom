import 'package:aplikasi_ujikom/const/firebase_const.dart';
import 'package:aplikasi_ujikom/global_methods.dart';
import 'package:aplikasi_ujikom/model/user_model.dart';
import 'package:aplikasi_ujikom/provider/user_provider.dart';

import 'package:aplikasi_ujikom/screens/home_screens.dart';
import 'package:aplikasi_ujikom/screens/pengaduan_Screens/pengaduan_screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    
    {'page': PengaduanScreens(), 'title': 'Pengaduan Screen'},
    {'page': const HomeScreens(), 'title': 'Home Screen'},
    
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).refreshUser();

    return Scaffold(
      /* appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
      ), */
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black12,
        selectedItemColor: Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 0 ? IconlyBold.category : IconlyLight.category,color: Colors.purple,),
            label: "Pengaduan",
          ),
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 1 ? IconlyBold.message : IconlyLight.message,color: Colors.purple,),
            label: "Chat",
          ),
          
        ],
      ),
    );
  }
}
