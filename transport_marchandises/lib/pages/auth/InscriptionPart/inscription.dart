import 'package:flutter/material.dart';
import '../../../models/utilisateur.dart' as U;
import '../../../utils/upload.dart' as upload;
import 'dart:typed_data';
import '../../../Service/Service.dart';
import '../../../Repository/user_repository.dart';
import '../../../Repository/vehicule_repository.dart';
import '../../user/profile.dart' as profile;

class Inscription1 extends StatefulWidget {
  final U.Utilisateur user;
  final VoidCallback onSuivant;
  const Inscription1(this.user, this.onSuivant, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _Inscription1();
  }
}

class _Inscription1 extends State<Inscription1> {
  bool _showpassword = false;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late final TextEditingController nom;
  late final TextEditingController prenom;
  late final TextEditingController email;
  late final TextEditingController password;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs
    nom = TextEditingController();
    prenom = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    nom.text = widget.user.nom ?? "";
    email.text = widget.user.email ?? "";
    password.text = widget.user.password ?? "";
    prenom.text = widget.user.prenom ?? "";
  }

  @override
  void dispose() {
    // Libération des ressources
    nom.dispose();
    prenom.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          child: Column(
            spacing: 20,
            children: [
              // input de first-Name
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: TextFormField(
                    controller: nom,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre nom";
                      } else {
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                      hintText: "nom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // input de last-Name
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: TextFormField(
                    controller: prenom,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre prenom";
                      } else {
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                      hintText: "Prenom",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // input gmail
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    //
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre email";
                      } else if (!value.contains("@gmail.com")) {
                        return "Adresse email invalide \n doit se terminer par @gmail.com";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // input password
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre password";
                      } else {
                        return null;
                      }
                    },
                    obscureText: !_showpassword,
                    decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.password_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showpassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _showpassword = !_showpassword;
                          });
                        },
                      ),
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
            "Next",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          icon: Icon(Icons.next_plan_outlined, color: Colors.white),

          onPressed: () {
            if (_key.currentState!.validate()) {
              widget.user.nom = nom.text;
              widget.user.prenom = prenom.text;
              widget.user.password = password.text;
              widget.user.email = email.text;
              widget.onSuivant();
            }
          },
        ),
      ],
    );
  }
}

// 2eme parte de inscription Telphone adresse Role type_utilisateur

class Inscription2 extends StatefulWidget {
  final U.Utilisateur user;
  final VoidCallback onSuivant;
  final VoidCallback onPrecedent;
  const Inscription2(
    this.user,
    this.onSuivant(),
    this.onPrecedent, {
    super.key,
  });
  @override
  State<StatefulWidget> createState() {
    return _Inscription2();
  }
}

class _Inscription2 extends State<Inscription2> {
  String? _role;
  String? type_utilisateur;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late final TextEditingController telephone;
  late final TextEditingController adresse;

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs
    telephone = TextEditingController();
    adresse = TextEditingController();
    telephone.text = widget.user.telephone ?? '';
    adresse.text = widget.user.adresse ?? '';
  }

  @override
  void dispose() {
    // Libération des ressources
    adresse.dispose();
    telephone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _key,
          child: Column(
            spacing: 20,
            children: [
              // input de telephone
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: TextFormField(
                    controller: telephone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre telephone";
                      } else {
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                      hintText: "telephone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // input de adresse
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: TextFormField(
                    controller: adresse,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer votre adresse";
                      } else {
                        return null;
                      }
                    },

                    decoration: InputDecoration(
                      hintText: "adresse",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              // choisir le role
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: DropdownButtonFormField<String>(
                  value: _role,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez choisir votre Role";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Rôle",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _role = value;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: "Prestataire",
                      child: Text("Prestataire"),
                    ),
                    DropdownMenuItem(value: "Client", child: Text("Client")),
                  ],
                ),
              ),
              // input type utilisateur
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez choisir votre type_utilisateur";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "type_utilisateur",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: type_utilisateur,
                    items: [
                      DropdownMenuItem(
                        value: "Particulier",
                        child: Text("Particulier"),
                      ),
                      DropdownMenuItem(
                        value: "Entreprise",
                        child: Text("Entreprise"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        type_utilisateur = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(10)),
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              label: Text(
                "Precedent",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Icon(Icons.chevron_left, color: Colors.white),

              onPressed: () {
                widget.onPrecedent();
              },
            ),
            ElevatedButton.icon(
              label: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Icon(Icons.next_plan_outlined, color: Colors.white),

              onPressed: () {
                if (_key.currentState!.validate()) {
                  widget.user.adresse = adresse.text;
                  widget.user.role = _role;
                  widget.user.telephone = telephone.text;
                  widget.user.type_utilisateur = type_utilisateur;
                  widget.onSuivant();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class Inscription3 extends StatefulWidget {
  final U.Utilisateur user;
  final VoidCallback onSuivent;
  final VoidCallback onPrecedent;
  const Inscription3(this.user, this.onSuivent, this.onPrecedent, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _Inscription3();
  }
}

class _Inscription3 extends State<Inscription3> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  image = await upload.SelectionImage();
                  setState(() {});
                },

                child: Container(
                  width: 200,
                  height: 200,
                  // color: Colors.redAccent,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(255, 236, 235, 235),
                  ),
                  child: Center(
                    child:
                        image == null
                            ? CircleAvatar(
                              radius: 200,
                              child: Center(child: Icon(Icons.image, size: 60)),
                            )
                            : Image.memory(
                              image!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    label: Text(
                      "Precedent",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icon(Icons.chevron_left, color: Colors.white),

                    onPressed: () {
                      widget.onPrecedent();
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (image == null) {
                        image = await upload.SelectionImage();
                        setState(() {});
                      } else {
                        widget.user.image_profile = image;
                        widget.onSuivent();
                      }
                    },
                    child:
                        image == null
                            ? Text("Ajouter une photo")
                            : Text("Suivent"),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () {
              widget.onSuivent();
            },
            child: const Text(
              "Passer",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

// 4 etape Inscription pour valide tous les information
class Inscription4 extends StatefulWidget {
  late final ApiService _apiService = ApiService();
  late final UserRepository _userRepository = UserRepository(_apiService);

  U.Utilisateur user;
  final VoidCallback onPresident;
  Inscription4(this.user, this.onPresident, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _Inscription4();
  }
}

class _Inscription4 extends State<Inscription4> {
  U.Utilisateur? user;
  bool isLoading = false;
  String errorMessage = '';

  Future<U.Utilisateur?> createUser() async {
    //
    if (widget.user == null) return null;
    if (widget.user.nom?.isNotEmpty == true &&
        widget.user.prenom?.isNotEmpty == true &&
        widget.user.email?.isNotEmpty == true &&
        widget.user.telephone?.isNotEmpty == true &&
        widget.user.adresse?.isNotEmpty == true &&
        widget.user.role?.isNotEmpty == true &&
        widget.user.type_utilisateur?.isNotEmpty == true &&
        widget.user.password?.isNotEmpty == true) {
      {
        try {
          setState(() {
            isLoading = true;
          });
          user = await widget._userRepository.postUser(widget.user);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => profile.Profile(widget._apiService, user!),
            ),
          );
        } catch (e) {
          setState(() {
            errorMessage = "Erreur Serveur $e";
            print("errer => $e");
          });
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      setState(() {
        errorMessage = "il doit saisir tous les information";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          isLoading
              ? CircularProgressIndicator()
              : Column(
                spacing: 10,
                children: [
                  errorMessage != ''
                      ? Text(
                        errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : SizedBox(),

                  Container(
                    width: 170,
                    height: 170,
                    // color: Colors.redAccent,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(85),
                      color: const Color.fromARGB(255, 236, 235, 235),
                    ),
                    child: Center(
                      child:
                          widget.user.image_profile == null
                              ? CircleAvatar(
                                radius: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.people, size: 60),
                                    Text("pas selection"),
                                  ],
                                ),
                              )
                              : Image.memory(
                                widget.user.image_profile!,
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                            child: Text(
                              "Nom: ${widget.user.nom}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Colors.blue[900],
                          child: Center(
                            child: Text(
                              "prenom: ${widget.user.prenom}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                            child: Text(
                              "Email: ${widget.user.email}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Colors.blue[900],
                          child: Center(
                            child: Text(
                              "Telphone: ${widget.user.telephone}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                            child: Text(
                              "Role: ${widget.user.role}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Colors.blue[900],
                          child: Center(
                            child: Text(
                              "Type utilisateur: ${widget.user.type_utilisateur}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          color: Colors.blue[900],
                          child: Center(
                            child: Text(
                              "Adresse: ${widget.user.adresse}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Botton pour Termine au Corrget les information
                  ElevatedButton(
                    onPressed: () {
                      createUser();
                    },
                    child: Text("Terminer"),
                  ),
                ],
              ),
    );
  }
}
