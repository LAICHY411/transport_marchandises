import 'package:flutter/material.dart';
import 'pages/auth/login.dart' as login;
import 'pages/auth/inscription.dart' as signUp;
import 'pages/user/edit_user.dart' as edit;
import 'pages/user/profile.dart' as profile;

// Supprimer
import 'Repository/user_repository.dart';
import 'Service/Service.dart';
import 'models/utilisateur.dart';
import 'Repository/vehicule_repository.dart';
import 'pages/vehicules/detailsVehicle.dart';
import 'models/vehicule.dart';

late final ApiService _apiService = ApiService();
late final UserRepository _userRepository = UserRepository(_apiService);
late final VehiculeRepository _vehiculeRepository = VehiculeRepository(
  _apiService,
);
Utilisateur user = Utilisateur(
  nom: "Benali",
  prenom: "Youssef",
  email: "youssef.benali@example.com",
  password: "12345678",
  telephone: "+212612345678",
  adresse: "Casablanca, Maroc",
  role: "Prestataire",
  type_utilisateur: "Entreprise",
  image_profile:
      null, // ou Uint8List.fromList(...) si tu veux mettre une image binaire
  urlImageProfile:
      "https://th.bing.com/th?q=Profil+PNG&w=120&h=120&c=1&rs=1&qlt=70&o=7&cb=1&pid=InlineBlock&rm=3&mkt=en-XA&cc=MA&setlang=fr&adlt=strict&t=1&mw=247",
);
Vehicules voiture = Vehicules(
  id: 1,
  marque: "Renault",
  modele: "Clio",
  immatriculation: "AB-123-CD",
  capacite: 5.0,
  tarif_km: 0.85,
);

// end Suprimer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  Color myprimireColor = Colors.yellow[900]!;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login.Login(),
 
      title: 'TransiGo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        primaryColor: myprimireColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(myprimireColor),
          ),
        ),
      ),
    );
  }
}
