import 'package:flutter/material.dart';
import '../parts/headerAuth.dart';
import '../../Repository/user_repository.dart';
import '../../Service/Service.dart';
import '../user/profile.dart' as profil;
import '../../models/utilisateur.dart' as U;
import './inscription.dart' as singup;
import '../../Repository/vehicule_repository.dart';

class Login extends StatefulWidget {
  Login({super.key});
  late final ApiService _apiService = ApiService();
  late final UserRepository userRepository = UserRepository(_apiService);

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showpassword = false;
  bool isLoading = false;
  String errorMessage = '';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _showpassword = false;
  }

  Future<Map<String, String>?> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    print("email $email password $password");
    try {
      final tokenRefresh = await widget.userRepository.login(email, password);
      if (tokenRefresh != null) {
        print("je suis la ");
        try {
          U.Utilisateur? user = await widget.userRepository.getUserProfile();

          if (user == null) {
            setState(() {
              errorMessage = 'Erreur  user est null';
            });
          } else {
            print("user est ${user.toJSON()}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => profil.Profile(widget._apiService, user),
              ),
            );
          }
        } catch (e) {
          errorMessage = 'Erreur lorsque charge de user \n ${e}';
        }
      } else {
        setState(() {
          errorMessage = 'Email ou mot de passe incorrect';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erreur Serveur';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue[900], bottom: Headerauth()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 0,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    " Login ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    spacing: 20,
                    children: [
                      // input gmail
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 40,
                        ),
                        child: Container(
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez entrer votre email";
                              } else if (!value.endsWith("@gmail.com")) {
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
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 40,
                        ),
                        child: Container(
                          child: TextFormField(
                            controller: _passwordController,
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
                      if (errorMessage.isNotEmpty)
                        Text(errorMessage, style: TextStyle(color: Colors.red)),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
                // Botton Connect
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          login();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                // SignUP
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => singup.Inscription(),
                      ),
                    );
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
