import 'package:flutter/material.dart';
import '../../models/vehicule.dart';
import '../parts/headerAuth.dart';
import '../../Repository/vehicule_repository.dart';
import '../../Repository/user_repository.dart';
import '../../models/utilisateur.dart';
import '../../Service/Service.dart';
import '../user/profile.dart';
import '../../Service/Service.dart';

class EditVehicules extends StatefulWidget {
  late VehiculeRepository _vehiculeRepository;
  Utilisateur user;
  Vehicules vehicule;
  ApiService _apiService;
  EditVehicules(this._apiService, this.user, this.vehicule) {
    _vehiculeRepository = VehiculeRepository(_apiService);
  }

  @override
  State<StatefulWidget> createState() {
    return _EditVehicules();
  }
}

class _EditVehicules extends State<EditVehicules> {
  bool isLoading = false;
  String errorMessage = '';
  Future<void> editVehicule(Vehicules vehicule) async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });
      final newVehicule = await widget._vehiculeRepository.patchVehicule(
        widget.vehicule.id!,
        data: vehicule.toJSON(),
      );
      if (newVehicule == null) {
        errorMessage = "Erreur Vehicule est null ";
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (contex) => Profile(widget._apiService, widget.user),
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = "Erreur ${e}";
        isLoading = false;
      });
    }
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late final TextEditingController marque;
  late final TextEditingController modele;
  late final TextEditingController immatriculation;
  late final TextEditingController capacite;
  late final TextEditingController tarif_km;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs
    marque = TextEditingController();
    modele = TextEditingController();
    immatriculation = TextEditingController();
    capacite = TextEditingController();
    tarif_km = TextEditingController();
    marque.text = widget.vehicule.marque ?? '';
    modele.text = widget.vehicule.modele ?? '';
    immatriculation.text = widget.vehicule.immatriculation ?? '';
    capacite.text = widget.vehicule.capacite.toString() ?? '0.00';
    tarif_km.text = widget.vehicule.tarif_km.toString() ?? '0.00';
  }

  @override
  void dispose() {
    // Libération des ressources
    modele.dispose();
    immatriculation.dispose();
    capacite.dispose();
    tarif_km.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (contex) => Profile(widget._apiService, widget.user),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        bottom: Headerauth(height: 90, paddingBottom: 8),
        centerTitle: true,
        title: Text(
          "ADD Vehicule",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              isLoading
                  ? CircularProgressIndicator()
                  : Form(
                    key: _key,
                    child: Column(
                      spacing: 10,
                      children: [
                        // input de marque
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          child: Container(
                            child: TextFormField(
                              controller: marque,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer votre marque";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'marque ',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                hintText: "marque",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // input de modele
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          child: Container(
                            child: TextFormField(
                              controller: modele,
                              decoration: InputDecoration(
                                label: Text("modele"),
                                hintText: "modele ",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // input de immatriculation
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          child: Container(
                            child: TextFormField(
                              controller: immatriculation,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer votre immatriculation";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'immatriculation ',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: "immatriculation",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // input Capacite
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          child: Container(
                            child: TextFormField(
                              controller: capacite,
                              //
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer votre capacite";
                                } else if (double.tryParse(value) == null) {
                                  return "Veuillez entrer une valeur numérique, pas de caractères.";
                                } else {
                                  return null;
                                }
                              },

                              decoration: InputDecoration(
                                hintText: "capacite",
                                label: RichText(
                                  text: TextSpan(
                                    text: 'capacite ',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // input tarif_km
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                          child: Container(
                            child: TextFormField(
                              controller: tarif_km,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Veuillez entrer votre tarif_km";
                                } else if (double.tryParse(value) == null) {
                                  return "Veuillez entrer une valeur numérique, pas de caractères.";
                                } else {
                                  return null;
                                }
                              },

                              decoration: InputDecoration(
                                label: RichText(
                                  text: TextSpan(
                                    text: 'tarif_km ',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: "tarif_km",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ElevatedButton.icon(
                label: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.save, color: Colors.white),

                onPressed: () {
                  if (_key.currentState!.validate()) {
                    Vehicules? _vehicule = Vehicules(
                      marque: marque.text,
                      modele: modele.text,
                      immatriculation: immatriculation.text,
                      capacite: double.parse(capacite.text),
                      tarif_km: double.parse(tarif_km.text),
                    );
                    editVehicule(_vehicule);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
