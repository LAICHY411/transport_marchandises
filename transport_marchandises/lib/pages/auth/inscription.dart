import 'InscriptionPart/inscription.dart';
import 'package:flutter/material.dart';
import '../parts/headerAuth.dart';
import '../../models/utilisateur.dart' as U;

class Inscription extends StatefulWidget {
  U.Utilisateur? user = U.Utilisateur();
  Inscription({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Inscription();
  }
}

class _Inscription extends State<Inscription> {
  int _etape = 0;

  U.Utilisateur user = U.Utilisateur();

  late List<Widget> inscriptions;
  @override
  void initState() {
    super.initState();
    inscriptions = [
      Inscription1(user, () => setState(() => _etape = 1)),

      Inscription2(
        user,
        () => setState(() => _etape = 2),
        () => setState(() => _etape = 0),
      ),
      Inscription3(
        user,
        () => setState(() => _etape = 3),
        () => setState(() => _etape = 1),
      ),
      Inscription4(user, () => setState(() => _etape = 2)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(
          "SIGNUP",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        bottom: Headerauth(height: 90, paddingBottom: 8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: inscriptions[_etape],
        ),
      ),
    );
  }
}
