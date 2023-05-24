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
                        "S'inscrire",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Asdean',
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
            style: TextStyle(
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

  Widget _buildbulleMain() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
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
      decoration: BoxDecoration(
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
      margin: EdgeInsets.fromLTRB(150, 0, 0, 0),
      width: 65,
      height: 65,
      decoration: BoxDecoration(
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
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpusername,
            style: TextStyle(
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
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: mdpcontroller,
            obscureText: true,
            style: TextStyle(
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
