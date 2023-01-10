import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function(int, String, String)
      onChangedStep; // ? la je suis definie une methode obligatoire le changestep qui a un int "index" puis les deux string mdp login
  const LoginScreen({
    Key? key,
    required this.onChangedStep,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSecret = true; // ? boolean pour cacher le mdp je crois
  String _login = '';
  String _motdepasse = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connexion'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      child: Column(
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                setState(() => _login = value),
                            decoration: const InputDecoration(
                                hintText: 'Ex:john.Dupont@gmail.com',
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          )
                        ],
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          const Text(
                            'Mot de passe',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                setState(() => _motdepasse = value),
                            obscureText: _isSecret,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () =>
                                      setState(() => _isSecret = !_isSecret),
                                  child: Icon(
                                    !_isSecret
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                hintText: 'Ex:124474',
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        widget.onChangedStep(1, _login, _motdepasse),
                      },
                      child: Text(
                        'envoyer'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
