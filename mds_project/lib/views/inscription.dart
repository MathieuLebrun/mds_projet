import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/api_service.dart';

import './login.dart';
import '../models/register_request_model.dart';
import '../utilities/constant.dart';

class InscriptionScreen extends StatefulWidget {
  // ? la je suis definie une methode obligatoire le changestep qui a un int "index" puis les deux string mdp login
  const InscriptionScreen({
    Key? key,
  }) : super(key: key);

  @override
  InscriptionScreenState createState() => InscriptionScreenState();
}

class InscriptionScreenState extends State<InscriptionScreen> {
  final emailcontroller = TextEditingController();
  final mdpcontroller = TextEditingController();

  var dropdownValue = "";
  List<String> listDropDownWhereToSend = [];

  String messageErreur = "";

  final mdpusername = TextEditingController();

  @override
  initState() {
    super.initState();
    setDropDownWhereToSend();
    dropdownValue = listDropDownWhereToSend[0];
  }

//View
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
                decoration: const BoxDecoration(
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
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        IconButton(
                          icon: const Icon(size: 35, Icons.arrow_back_sharp),
                          onPressed: () {
                            if (context.mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            }
                          },
                        ),
                      ]),
                      const Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Asdean',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        padding: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2)),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildEmailTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildUserName(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildAnn(),
                      const SizedBox(
                        height: 30,
                      ),
                      _buildInscInBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLilbulle1(),
                          _buildLilbulle2(),
                        ],
                      ),
                      _buildbulleMain(),
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

  //Controleurs

//Fonction qui construit le champs Email
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
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

//Fonction qui valide l'inscriptions
  Future<bool> _register() async {
    int valeurclasse = 3;
    // dans un premier temps je recupére la valeur du dropdown
    switch (int.parse(dropdownValue[0])) {
      case 5:
        {
          valeurclasse = 5;
        }
        break;

      case 3:
        {
          valeurclasse = 3;
        }
        break;
      case 6:
        {
          valeurclasse = 6;
        }
        break;
      case 4:
        {
          valeurclasse = 4;
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }
    // je crée un model avec les données de chaque controleur
    RegisterRequestModel model = RegisterRequestModel(
      username: mdpusername.text,
      password: mdpcontroller.text,
      email: emailcontroller.text,
      classe: valeurclasse.toString(),
    );
    //j'effectue la requete depuis la classe api service
    String response = await APIService.register(model);
    if (response != "404") {
      // si le status code et bon j'affiche une notifications validée
      showInSnackBar("✅");
      if (context.mounted) {
        // et je passe a l'écran de connexion
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } else {
      messageErreur = "Erreur d'inscriptions ";
      showInSnackBar(
          messageErreur); //sinon j'affiche une notifications d'erreurs
      return false;
    }

    return false;
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color(0xFFDD45F2);
    }
    return const Color(0xFFDD45F2);
  }

  Widget _buildbulleMain() {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF8C6FF),
            Color(0xFFDD6CFF),
          ],
        ),
      ),
    );
  }

  Widget _buildLilbulle1() {
    return Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFDD6CFF),
            //  Color(0xFFF8C6FF),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildLilbulle2() {
    return Container(
      margin: const EdgeInsets.fromLTRB(150, 0, 0, 0),
      width: 65,
      height: 65,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFDD6CFF),
            //  Color(0xFFF8C6FF),
            Color(0xFFF8C6FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

//construction du bouton inscription
  Widget _buildInscInBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
        // elevation: 5.0,
        onPressed: () async => {
          if (await _register())
            {MaterialPageRoute(builder: (context) => const LoginScreen())}
          else
            {},
        },
        //padding: EdgeInsets.all(15.0),
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ), */
        // color: Colors.white,
        child: const Text(
          'Continuer',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Asdean',
          ),
        ),
      ),
    );
  }

//remplissage des années dans la liste du dropdown
  void setDropDownWhereToSend() {
    listDropDownWhereToSend.add("6ème");
    listDropDownWhereToSend.add("5ème");
    listDropDownWhereToSend.add("4ème");
    listDropDownWhereToSend.add("3ème");
  }

//Methode construction drop down des années
  Widget _buildAnn() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Sélectionnez une année',
            style: kLabelStyle,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFFF295FF),
              value: dropdownValue,
              items: listDropDownWhereToSend
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpusername,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              labelText: "Nom d'utilisateur",
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
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpcontroller,
            obscureText: true,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
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
}
