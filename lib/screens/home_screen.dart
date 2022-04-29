import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login_screen.dart';
import '../services/medicine_data.dart';
import '../widgets/medicines_card.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? username = '';
  List<Map<dynamic, dynamic>> medicineInfo = [];
  bool isLocalDataLoading = true;
  bool isRemoteDataLoading = true;
  DateTime fullTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    getData();

    super.initState();
  }

  void logout(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  getData() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    final String? data = sharedPrefs.getString('username');
    setState(() {
      username = data;
      isLocalDataLoading = false;
    });
    final medicineData = await MedicineData.getData();
    setState(() {
      medicineInfo = medicineData;
      isRemoteDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome !!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout(context);
            },
          )
        ],
      ),
      body: isLocalDataLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          'Hii, ${username!}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        trailing: Text(
                          '${fullTime.hour.toString()} : ${fullTime.minute.toString()} :${fullTime.second.toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (isRemoteDataLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!isRemoteDataLoading)
                      Expanded(
                        child: MedicinesCard(medicineInfo: medicineInfo),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
