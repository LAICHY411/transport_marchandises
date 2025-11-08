import 'package:flutter/material.dart';
import '../../models/vehicule.dart';
import '../parts/headerAuth.dart';
import '../../Repository/vehicule_repository.dart';
import '../../Repository/user_repository.dart';
import '../../models/utilisateur.dart';
import '../../Service/Service.dart';
import '../user/profile.dart';
import 'editVehicule.dart';
import '../../Repository/reservation_repository.dart';
import '../parts/dialogEdit.dart';

class DetailsVehicules extends StatefulWidget {
  late VehiculeRepository _vehiculeRepository;
  late UserRepository _userRepository;
  late ReservationRepository _reservationRepository;
  Utilisateur user;
  Vehicules vehicule;
  ApiService _apiService;
  DetailsVehicules(this._apiService, this.user, this.vehicule) {
    _vehiculeRepository = VehiculeRepository(_apiService);
    _userRepository = UserRepository(_apiService);
    _reservationRepository = ReservationRepository(_apiService);
  }

  @override
  State<StatefulWidget> createState() {
    return _DetailsVehicules();
  }
}

class _DetailsVehicules extends State<DetailsVehicules> {
  // ReservationRepository _reservationRepository=ReservationRepository(apiService);
  bool isLoading = false;

  String errorMessage = '';
  Future<void> getVehicule(int id) async {
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

  Future<void> deleteVehicule(int id) async {
    widget._vehiculeRepository.delete(id);
    setState(() {});
  }

  Future<List<dynamic>?> getReservationsVehicule() async {
    setState(() {
      isLoading = true;
    });
    try {
      List? reservations = await widget._reservationRepository
          .getReservationVehicule(widget.vehicule.id);
      return reservations;
    } catch (e) {
      errorMessage = "erreyr list des reservation $e";
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
    modele.text = widget.vehicule.modele ?? 'Pas de modèle';
    immatriculation.text = widget.vehicule.immatriculation ?? '';
    capacite.text = '${widget.vehicule.capacite.toString()} tonne' ?? '0.00';
    tarif_km.text = '${widget.vehicule.tarif_km.toString()} Dh/km' ?? '0.00';
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
        bottom: Headerauth(height: 80, paddingBottom: 16),
        centerTitle: true,
        title: Text(
          "Details Vehicule",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? CircularProgressIndicator()
                  : Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      height: 360,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Colors.red,
                                        ),
                                        child:
                                            (widget.user.urlImageProfile !=
                                                    null)
                                                ? Image.network(
                                                  widget.user.urlImageProfile!,
                                                  width: 40,
                                                  height: 40,
                                                )
                                                : Center(
                                                  child: Icon(Icons.person),
                                                ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.user.prenom} ${widget.user.nom}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.user.email!,
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton.outlined(
                                        onPressed: () {
                                          getVehicule(widget.vehicule.id!);
                                        },
                                        icon: Icon(Icons.edit),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(width: 5),
                                      IconButton.outlined(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ConfirmEditDialog(
                                                actionAModifier:
                                                    "supprimer cette vehicule",
                                                onConfirm:
                                                    () => {
                                                      setState(() {
                                                        deleteVehicule(
                                                          widget.vehicule.id!,
                                                        );
                                                      }),
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => Profile(
                                                                widget
                                                                    ._apiService,
                                                                widget.user,
                                                              ),
                                                        ),
                                                      ),
                                                    },
                                                onCancel:
                                                    () => {
                                                      Navigator.pop(context),
                                                    },
                                              );
                                            },
                                          );
                                          deleteVehicule(widget.vehicule.id!);
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.only(right: 60),
                              child: TextField(
                                controller: marque,
                                readOnly: true,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(right: 60),
                              child: TextField(
                                controller: modele,
                                readOnly: true,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(right: 60),
                              child: TextField(
                                controller: immatriculation,
                                readOnly: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 60),
                              child: TextField(
                                controller: capacite,
                                readOnly: true,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(right: 60),
                              child: TextField(
                                controller: tarif_km,
                                readOnly: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("Add Reservation"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20),
              Text(
                "Reservations",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Start Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "End Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "actions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      color: const Color.fromARGB(255, 48, 47, 47),
                      height: 2,
                      width: double.infinity,
                    ),
                    FutureBuilder<List<dynamic>?>(
                      future: getReservationsVehicule(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snap.hasError) {
                          return Text("Erreur : ${snap.error}");
                        } else if (snap.hasData && snap.data!.isNotEmpty) {
                          final reservation = snap.data!;
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reservation.length,
                            itemBuilder: (context, index) {
                              final v = reservation[index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    v["date_reservation"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    v["heure_debut"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    v["heure_fin"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton.outlined(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (context, index) => Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: const Color.fromARGB(255, 87, 87, 87),
                                ),
                          );
                        } else {
                          return Text("pas de réservations");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
