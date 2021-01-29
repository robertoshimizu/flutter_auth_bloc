import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Aprenda a cuidar melhor do seu dinheiro",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Text(
                      "Temos dicas de educação financeira para ajudar você a controlar seus gastos e ser uma pessoa mais planejada com seu dinheiro.",
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // new Image.asset('lib/application/pages/assets/images/dart.jpg'),
                  // SvgPicture.asset(
                  //     'lib/application/pages/assets/images/Group 2818.svg'),
                  // SvgPicture.network(
                  //   "https://www.svgrepo.com/show/2046/dog.svg",
                  //   placeholderBuilder: (context) => CircularProgressIndicator(),
                  //   height: 128.0,
                  // ),
                  SizedBox(
                    height: 16,
                  ),
                  RoundedButton(
                    text: 'Criar Conta',
                    onPress: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             CadastroNovoUsuarioEmail()));
                    },
                    enabled: true,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  RoundedButton(
                    text: 'Já sou cadastrado',
                    onPress: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(Login());
                    },
                    enabled: false,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
