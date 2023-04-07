import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import 'home.dart';
import 'login.dart';
import 'models/register_request_model.dart';
import 'utilities/constant.dart';

class InscriptionScreen extends StatefulWidget {
  final Function(int, String, String)
      onChangedStep; // ? la je suis definie une methode obligatoire le changestep qui a un int "index" puis les deux string mdp login
  const InscriptionScreen({
    Key? key,
    required this.onChangedStep,
  }) : super(key: key);

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  bool _isSecret = true; // ? boolean pour cacher le mdp je crois
  final emailcontroller = TextEditingController();
  final mdpcontroller = TextEditingController();

  var dropdownValue = "";
  List<String> listDropDownWhereToSend = [];

  String MessageErreur = "";

  final mdpusername = TextEditingController();

  @override
  initState() {
    setDropDownWhereToSend();
    dropdownValue = listDropDownWhereToSend[0];
  }

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
                      Color(0xFFDD6CFF),
                      Color(0xFFF295FF),
                      Color(0xFFF295FF),
                      Color(0xFFF8C6FF),
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
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        IconButton(
                          icon: const Icon(size: 35, Icons.arrow_back_sharp),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen(
                                          onChangedStep:
                                              (inta, stringa, string) {},
                                        )));
                          },
                        ),
                      ]),
                      Text(
                        'Inscriptions',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Entrez votre Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _signInWithGoogle() async {
    int valeurclasse = 3;
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

    RegisterRequestModel model = RegisterRequestModel(
      username: mdpusername.text,
      password: mdpcontroller.text,
      email: emailcontroller.text,
      classe: valeurclasse.toString(),
    );

    String marcel = await APIService.register(model);
    if (marcel != "404") {
      showInSnackBar("✅");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(
                  onChangedStep: (inta, stringa, string) {},
                )),
      );
    } else {
      MessageErreur = "Erreur de connexion ";
      showInSnackBar(MessageErreur);
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
          if (await _signInWithGoogle())
            {widget.onChangedStep(1, "", "")}
          else
            {},
        },
        //padding: EdgeInsets.all(15.0),
        /* shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ), */
        // color: Colors.white,
        child: const Text(
          'Valider',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void setDropDownWhereToSend() {
    listDropDownWhereToSend.add("6ème");
    listDropDownWhereToSend.add("5ème");
    listDropDownWhereToSend.add("4ème");
    listDropDownWhereToSend.add("3ème");
  }

  Widget _buildAnn() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
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
        Text(
          "Nom d'utilisateur",
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpusername,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFFDD45F2),
              ),
              hintText: "Entrez votre nom d'utilisateur",
              hintStyle: TextStyle(
                color: Colors.white54,
                fontFamily: 'OpenSans',
              ),
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
        Text(
          'Mot de passe',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpcontroller,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Entrez votre mot de passe',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
