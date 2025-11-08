import 'package:flutter/material.dart';
import 'package:transport_marchandises/models/vehicule.dart';
import 'package:transport_marchandises/pages/vehicules/detailsVehicle.dart';
import '../../models/utilisateur.dart' as U;
import 'dart:typed_data';
import 'dart:io';
import '../../utils/upload.dart' as upload;
import 'package:image_picker/image_picker.dart';
import '../../Repository/user_repository.dart' as UserRep;
import '../../Repository/vehicule_repository.dart' as VehRep;
import '../user/edit_user.dart' as editprofile;
import '../vehicules/ajouterVehicule.dart' as addVehicule;
import '../../Service/Service.dart';
import '../vehicules/editVehicule.dart';
import '../../Service/Service.dart';

class Profile extends StatefulWidget {
  U.Utilisateur user;
  ApiService _apiService;
  late final UserRep.UserRepository _userRepository;
  late final VehRep.VehiculeRepository _vehiculeRepository;
  Profile(this._apiService, this.user) {
    _userRepository = UserRep.UserRepository(_apiService);
    _vehiculeRepository = VehRep.VehiculeRepository(_apiService);
  }

  @override
  State<StatefulWidget> createState() {
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  Uint8List? image;
  String errorMessage = '';
  bool isLoading = false;
  Future<void> updateImageProfile() async {
    if (image == null) return;
    try {
      setState(() {
        isLoading = true;
      });
      U.Utilisateur? user = await widget._userRepository.updateImage(
        widget.user.id!,
        image,
      );
      if (user != null) {
        widget.user = user;
      }
    } catch (e) {
      setState(() {
        errorMessage = "Erreur lorsque update Image";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> editVehicule(int id) async {
    try {
      final data = await widget._vehiculeRepository.getVehicule(id);
      if (data == null) {
        setState(() {
          errorMessage = "Erreur lors du téléchargement le véhicule ";
        });
        return;
      }
      setState(() {
        errorMessage = "";
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => EditVehicules(widget._apiService, widget.user, data),
        ),
      );
    } catch (e) {}
  }

  Future<void> detailsVehicule(int id) async {
    try {
      final data = await widget._vehiculeRepository.getVehicule(id);
      if (data == null) {
        setState(() {
          errorMessage = "Erreur lors du téléchargement le véhicule ";
        });
        return;
      }
      setState(() {
        errorMessage = "";
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  DetailsVehicules(widget._apiService, widget.user, data),
        ),
      );
    } catch (e) {
      errorMessage = "erreur details";
    }
  }

  Future<List<dynamic>?> lireVehicule() async {
    try {
      final data = await widget._vehiculeRepository.getVehiculesProfile();
      return data;
    } catch (e) {
      setState(() {
        errorMessage = "Erreur lors de l'affichage des véhicules : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              errorMessage == ''
                  ? Text('')
                  : Text(errorMessage, style: TextStyle(color: Colors.red)),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 23),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // il doit ajouter image ici
                    TextButton(
                      onPressed: () async {
                        image = await upload.SelectionImage();
                        await updateImageProfile();

                        setState(() {});
                      },

                      child: Container(
                        width: 120,
                        height: 120,
                        child: Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              // color: Colors.redAccent,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color.fromARGB(255, 236, 235, 235),
                              ),
                              child: Center(
                                child:
                                    widget.user.urlImageProfile != null
                                        ? Image.network(
                                          widget.user.urlImageProfile!,
                                          width: 120,
                                          height: 120,
                                        )
                                        : image == null
                                        ? CircleAvatar(
                                          radius: 120,
                                          child: Center(
                                            child: Icon(Icons.person, size: 60),
                                          ),
                                        )
                                        : Image.memory(
                                          image!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () async {
                                  image = await upload.SelectionImage();
                                  await updateImageProfile();
                                  setState(() {});
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(
                                      255,
                                      221,
                                      220,
                                      220,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 4),
                    Text(
                      widget.user.nom!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.user.email!,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.user.role!,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 320,
                        maxWidth: 500,
                        minHeight: 37,
                        maxHeight: 60,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => editprofile.Modifier_user(
                                    widget._apiService,
                                    widget.user,
                                  ),
                            ),
                          );
                        },
                        child: Text("Modifier le profil"),
                      ),
                    ),
                    SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 320,
                        maxWidth: 500,
                        minHeight: 37,
                        maxHeight: 60,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Mes Vehicules"),
                      ),
                    ),
                    SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 320,
                        maxWidth: 500,
                        minHeight: 37,
                        maxHeight: 60,
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Parametres"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              (widget.user.role == "Client")
                  ? Text("")
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mes Vehicules",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => addVehicule.AddVehicules(
                                      widget._apiService,
                                      widget.user,
                                    ),
                              ),
                            );
                          },
                          child: Text("add"),
                        ),
                      ),
                    ],
                  ),
              (widget.user.role == "Client")
                  ? Text("")
                  : FutureBuilder<List<dynamic>?>(
                    future: lireVehicule(),
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snap.hasError) {
                        return Text("Erreur : ${snap.error}");
                      } else if (snap.hasData && snap.data!.isNotEmpty) {
                        final vehicules = snap.data!;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vehicules.length,
                          itemBuilder: (context, index) {
                            final v = vehicules[index];
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10, width: 10),
                                    Icon(
                                      Icons.local_shipping,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            v['marque'] ?? 'Marque inconnue',
                                          ),
                                          Text(
                                            "Capacite : ${v['capacite']} tonne",
                                          ),
                                          Text(
                                            "tarif en km : ${v['tarif_km']} DH/km",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 10),
                                        IconButton.outlined(
                                          onPressed: () {
                                            editVehicule(v["id"]);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        IconButton.outlined(
                                          onPressed: () {
                                            detailsVehicule(v["id"]);
                                          },
                                          icon: Icon(
                                            Icons.info,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text("Aucun véhicule trouvé");
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
