import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';

class ProfileIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  bottom: 38.0,
                ),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/lockup-eu-indico.png'),
                    height: size.height * 0.16,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                'Ok, agora vamos preencher rapidamente o seu perfil',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Em seguida você poderá começar a indicar seus amigos para serviços profissionais.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              startButtons(
                Color(0xff84BC75),
                'próxima',
                context,
                () {
                  Navigator.pushNamed(context, 'first_profile1');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
