// import 'dart:html';

import 'package:uanguanguang/helper/dbhelper.dart';
import 'package:uanguanguang/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uanguanguang/providers/user_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  String developerName = "Bintang Nur Auliya'";
  String developerNim = "2141764165";
  String dateApp = "28 September 2023";

  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to get user data
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Saat Ini",
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo)),
              ),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                labelStyle: TextStyle(color: Colors.blue),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _changePassword(user!);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)))),
              child: const Text("Simpan Password Baru"),
            ),
            SizedBox(height: 200),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // create bold heading style
                          const Text(
                            "About this App",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          const Text("Aplikasi ini dibuat oleh: "),
                          Text("Nama    : $developerName"),
                          Text("Nim     : $developerNim"),
                          Text("Tanggal : $dateApp"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo.shade900),
                  borderRadius: BorderRadius.circular(16.0)),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(User user) {
    String currentPasswordInput = currentPasswordController.text;
    String newPasswordInput = newPasswordController.text;

    if (currentPasswordInput == user.password) {
      // Password saat ini benar, simpan password baru
      dbHelper.changePassword(user.email!, newPasswordInput);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password berhasil diubah."),
      ));
    } else {
      // Password saat ini salah
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password saat ini salah. Ubah password gagal."),
      ));
    }
  }
}
