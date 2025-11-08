import 'package:flutter/material.dart';
import '../../models/utilisateur.dart' as U;
import '../parts/dialogEdit.dart' as diaEdi;
import '../../Repository/user_repository.dart';
import '../../Repository/vehicule_repository.dart';
import '../user/profile.dart' as profile;
import '../../Service/Service.dart';

class Modifier_user extends StatefulWidget {
  late final UserRepository _userRepository;
  U.Utilisateur user;
  ApiService _apiService;
  Modifier_user(this._apiService, this.user) {
    _userRepository = UserRepository(_apiService);
  }

  @override
  State<StatefulWidget> createState() {
    return _Modifier_User();
  }
}

class _Modifier_User extends State<Modifier_user> {
  final _dropdownKeyRole = GlobalKey<FormFieldState>();
  final _dropdownKeyTypeUtilisateur = GlobalKey<FormFieldState>();
  late final TextEditingController _nom;
  late final TextEditingController _prenom;
  late final TextEditingController _email;
  late final TextEditingController _telephone;
  late final TextEditingController _adresse;
  late String _role;
  late String _type_utilisateur;

  String errorMessage = '';
  bool isLoading = false;
  Future<U.Utilisateur?> editUser(Map<String, dynamic> data) async {
    try {
      setState(() {
        isLoading = true;
      });
      U.Utilisateur? user = await widget._userRepository.patchUser(
        widget.user.id!,
        data: data,
      );
      setState(() {
        widget.user = user!;
      });
    } catch (e) {
      print("erreur akhoya ${e}");
      setState(() {
        errorMessage = 'Erreur Serveur';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Map<String, bool> etatEdit = {
    "nom": false,
    "prenom": false,
    "email": false,
    "telephone": false,
    "adresse": false,
  };

  @override
  void initState() {
    super.initState();

    _nom = TextEditingController();
    _prenom = TextEditingController();
    _email = TextEditingController();
    _telephone = TextEditingController();
    _adresse = TextEditingController();
    // _password = TextEditingController();
    _nom.text = widget.user.nom ?? "";
    _email.text = widget.user.email ?? "";
    // _password.text = widget.user.password ?? "";
    _prenom.text = widget.user.prenom ?? "";
    _telephone.text = widget.user.telephone ?? "";
    _adresse.text = widget.user.adresse ?? "";
    _role = widget.user.role!;
    _type_utilisateur = widget.user.type_utilisateur!;

    // tres import
  }

  @override
  void dispose() {
    // Libération des ressources
    _nom.dispose();
    _prenom.dispose();
    _email.dispose();
    _telephone.dispose();
    _adresse.dispose();
    // _password.dispose();
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
                builder:
                    (context) =>
                        profile.Profile(widget._apiService, widget.user),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("A propos"),
      ),
      body: SingleChildScrollView(
        child:
            isLoading
                ? CircularProgressIndicator()
                : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Nom
                      Container(
                        child: TextFormField(
                          readOnly: !etatEdit["nom"]!,
                          controller: _nom,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre Nom";
                            } else {
                              return null;
                            }
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "Nom",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.person, size: 28),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !etatEdit["nom"]! ? Icons.edit : Icons.save_as,
                                size: 28,
                              ),
                              onPressed: () {
                                if (etatEdit["nom"]!) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return diaEdi.ConfirmEditDialog(
                                        actionAModifier: " Nom",
                                        onConfirm:
                                            () => {
                                              setState(() {
                                                etatEdit["nom"] =
                                                    !etatEdit["nom"]! ?? false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                        onCancel:
                                            () => {
                                              setState(() {
                                                _nom.text = widget.user.nom!;
                                                etatEdit["nom"] =
                                                    !etatEdit["nom"]! ?? false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    etatEdit["nom"] =
                                        !etatEdit["nom"]! ?? false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // prenom
                      Container(
                        child: TextFormField(
                          readOnly: !etatEdit["prenom"]!,
                          controller: _prenom,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre prenom";
                            } else {
                              return null;
                            }
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "prenom",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.person_outline, size: 28),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !etatEdit["prenom"]!
                                    ? Icons.edit
                                    : Icons.save_as,
                                size: 28,
                              ),
                              onPressed: () {
                                if (etatEdit["prenom"]!) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return diaEdi.ConfirmEditDialog(
                                        actionAModifier: "prenom",
                                        onConfirm:
                                            () => {
                                              setState(() {
                                                etatEdit["prenom"] =
                                                    !etatEdit["prenom"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                        onCancel:
                                            () => {
                                              setState(() {
                                                _prenom.text =
                                                    widget.user.prenom!;
                                                etatEdit["prenom"] =
                                                    !etatEdit["prenom"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    etatEdit["prenom"] =
                                        !etatEdit["prenom"]! ?? false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Email
                      Container(
                        child: TextFormField(
                          readOnly: !etatEdit["email"]!,
                          controller: _email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre email";
                            } else {
                              return null;
                            }
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "email",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.email, size: 28),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !etatEdit["email"]!
                                    ? Icons.edit
                                    : Icons.save_as,
                                size: 28,
                              ),
                              onPressed: () {
                                if (etatEdit["email"]!) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return diaEdi.ConfirmEditDialog(
                                        actionAModifier: "email",
                                        onConfirm:
                                            () => {
                                              setState(() {
                                                etatEdit["email"] =
                                                    !etatEdit["email"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                        onCancel:
                                            () => {
                                              setState(() {
                                                _email.text =
                                                    widget.user.email!;
                                                etatEdit["email"] =
                                                    !etatEdit["email"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    etatEdit["email"] =
                                        !etatEdit["email"]! ?? false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // telphone
                      Container(
                        child: TextFormField(
                          readOnly: !etatEdit["telephone"]!,
                          controller: _telephone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre telephone";
                            } else {
                              return null;
                            }
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "telephone",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.phone, size: 28),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !etatEdit["telephone"]!
                                    ? Icons.edit
                                    : Icons.save_as,
                                size: 28,
                              ),
                              onPressed: () {
                                if (etatEdit["telephone"]!) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return diaEdi.ConfirmEditDialog(
                                        actionAModifier: "telephone",
                                        onConfirm:
                                            () => {
                                              setState(() {
                                                etatEdit["telephone"] =
                                                    !etatEdit["telephone"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                        onCancel:
                                            () => {
                                              setState(() {
                                                _telephone.text =
                                                    widget.user.telephone!;
                                                etatEdit["telephone"] =
                                                    !etatEdit["telephone"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    etatEdit["telephone"] =
                                        !etatEdit["telephone"]! ?? false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Adresse
                      Container(
                        child: TextFormField(
                          readOnly: !etatEdit["adresse"]!,
                          controller: _adresse,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez entrer votre adresse";
                            } else {
                              return null;
                            }
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "adresse",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.location_on, size: 28),
                            suffixIcon: IconButton(
                              icon: Icon(
                                !etatEdit["adresse"]!
                                    ? Icons.edit
                                    : Icons.save_as,
                                size: 28,
                              ),
                              onPressed: () {
                                if (etatEdit["adresse"]!) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return diaEdi.ConfirmEditDialog(
                                        actionAModifier: "adresse",
                                        onConfirm:
                                            () => {
                                              setState(() {
                                                etatEdit["adresse"] =
                                                    !etatEdit["adresse"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                        onCancel:
                                            () => {
                                              setState(() {
                                                _adresse.text =
                                                    widget.user.adresse!;
                                                etatEdit["adresse"] =
                                                    !etatEdit["adresse"]! ??
                                                    false;
                                              }),
                                              Navigator.pop(context),
                                            },
                                      );
                                    },
                                  );
                                } else {
                                  setState(() {
                                    etatEdit["adresse"] =
                                        !etatEdit["adresse"]! ?? false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      //  Choix de Role
                      Container(
                        child: DropdownButtonFormField(
                          key: _dropdownKeyRole,
                          value: _role,
                          items: [
                            DropdownMenuItem(
                              child: Text("Prestataire"),
                              value: "Prestataire",
                            ),
                            DropdownMenuItem(
                              child: Text("Client"),
                              value: "Client",
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;

                            final ancienneValeur = _role;
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return diaEdi.ConfirmEditDialog(
                                  actionAModifier: "role",
                                  onConfirm: () {
                                    setState(() => _role = v);

                                    Navigator.pop(dialogContext);
                                  },
                                  onCancel: () {
                                    setState(() {
                                      _role = ancienneValeur;
                                    });
                                    Navigator.pop(dialogContext);
                                    _dropdownKeyRole.currentState?.reset();
                                    Navigator.pop(dialogContext);
                                  },
                                );
                              },
                            );
                            ;
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "role",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(
                              Icons.supervised_user_circle,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: DropdownButtonFormField(
                          key: _dropdownKeyTypeUtilisateur,
                          value: _type_utilisateur,
                          items: [
                            DropdownMenuItem(
                              child: Text("Particulier"),
                              value: "Particulier",
                            ),
                            DropdownMenuItem(
                              child: Text("Entreprise"),
                              value: "Entreprise",
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;

                            final ancienneValeur = _type_utilisateur;
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return diaEdi.ConfirmEditDialog(
                                  actionAModifier: "Type d'utilisateur",
                                  onConfirm: () {
                                    setState(() => _type_utilisateur = v);

                                    Navigator.pop(dialogContext);
                                  },
                                  onCancel: () {
                                    setState(() {
                                      _type_utilisateur = ancienneValeur;
                                    });
                                    Navigator.pop(dialogContext);
                                    _dropdownKeyTypeUtilisateur.currentState
                                        ?.reset();
                                    Navigator.pop(dialogContext);
                                  },
                                );
                              },
                            );
                            ;
                          },

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),

                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 10.0,
                            ),
                            label: Text(
                              "type d'utilisateur",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                              selectionColor: Theme.of(context).primaryColor,
                            ),

                            focusColor: Colors.black,
                            prefixIcon: Icon(Icons.person_pin, size: 28),
                          ),
                        ),
                      ),

                      // enregistre les information
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return diaEdi.ConfirmEditDialog(
                                actionAModifier: "les information",
                                onConfirm: () {
                                  setState(
                                    () => etatEdit.updateAll(
                                      (key, value) => true,
                                    ),
                                  );
                                  editUser({
                                    "nom": _nom.text,
                                    "email": _email.text,
                                    "prenom": _prenom.text,
                                    "telephone": _telephone.text,
                                    "adresse": _adresse.text,
                                    "role": _role,
                                    "type_utilisateur": _type_utilisateur,
                                  });

                                  Navigator.pop(dialogContext);
                                },
                                onCancel: () {
                                  setState(() {});
                                  Navigator.pop(dialogContext);
                                },
                              );
                            },
                          );
                        },

                        icon: Icon(Icons.save, size: 18),
                        label: Text("Enregistrer les informations"),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
      ),
    );
  }
}
