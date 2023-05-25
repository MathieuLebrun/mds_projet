import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mds_project/views/inscription.dart';
import 'package:mds_project/models/login_request_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mds_project/services/persistancehandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utilities/constant.dart';
import 'package:http/http.dart' as http;

import '../services/api_service.dart';
import '../models/login_request_model.dart';
import '../mainScreen.Dart';
import '../models/login_response_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late PersistanceHandler persistanceHandler;
  bool _isSecret = true; // ? boolean pour cacher le mdp je crois
  late String _login;
  final emailcontroller = TextEditingController();
  final mdpcontroller = TextEditingController();

  String _motdepasse = '';
  late String MessageErreur = '';
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffffffff),
                      Color(0xFFffffb9),
                      Color(0xFFffffb9),
                      Color(0xFfcc55ea)
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          emailcontroller.text = "teo@garbarinoo.co";
                          mdpcontroller.text = "1234567";
                        },
                        child: Text("BYPASS BY T£OX",
                            style: TextStyle(
                              color: Color(0xFF505050),
                              fontFamily: 'Asdaen',
                            )),
                      ),
                      const Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Color(0xFF383838),
                          fontFamily: 'Asdaen',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        padding: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2)),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildLogo(),
                      _buildEmailTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention la connexion a echoué'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(MessageErreur),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _signInWithGoogle() async {
    LoginRequestModel model = LoginRequestModel(
      username: emailcontroller.text,
      password: mdpcontroller.text,
    );

    var response = await APIService.login(model);
    if (response.statusCode == 200) {
      var loginResponse = loginResponseJson(response.body);
      PersistanceHandler().setTokenEDP(loginResponse.accesToken);
      PersistanceHandler().setID(loginResponse.id);
      PersistanceHandler().setUsername(loginResponse.username);
      PersistanceHandler().setEmail(loginResponse.email);
      return true;
    } else {
      MessageErreur = "Connexion refusé";
      _showMyDialog();
      return false;
    }
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          decoration: kBoxDecorationStyle,
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            key: const Key('email'),
            style: const TextStyle(
              color: Color(0xFF505050),
              fontFamily: 'Asdaen',
            ),
            decoration: const InputDecoration(
              labelText: 'Email',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpcontroller,
            obscureText: true,
            key: const Key('mdp'),
            style: TextStyle(
              color: Color(0xFF505050),
              fontFamily: 'Asdean',
            ),
            decoration: const InputDecoration(
              labelText: 'Mot de passe',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        key: const Key('login'),
        // elevation: 5.0,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () async => {
          if (await _signInWithGoogle())
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => mainScreen())),
            }
          else
            {},
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF8C6FF),
                Color(0xFFF295FF),
                Color(0xFFF295FF),
                Color(0xFFDD6CFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Center(
            child: Text(
              'SE CONNECTER',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Asdean',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
        child: Image.asset(
      'assets/images/LogoAppMob.png', // Chemin relatif vers l'image
      width: 175, // Largeur souhaitée de l'image
      height: 175, // Hauteur souhaitée de l'image
    ));
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => InscriptionScreen())),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Vous n\'avez pas de compte? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'S\'inscrire',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
