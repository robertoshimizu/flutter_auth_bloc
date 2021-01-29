import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/domain/repository/auth_repository.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../pages.dart';

class PhoneLoginWrapper extends StatelessWidget {
  final AuthRepository authRepository;

  PhoneLoginWrapper({Key key, @required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneloginBloc>(
      create: (context) => PhoneloginBloc(authRepository: authRepository),
      child: BlocBuilder<PhoneloginBloc, PhoneloginState>(
        builder: (context, state) {
          print('PhoneLoginState is $state');
          if (state is PhoneloginInitial) {
            return PhoneFormPage();
          }
          if (state is OtpSentState) {
            return SMSVerificationView();
          }
          if (state is LoginCompleteState) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedIn());
            return HomePage();
          }
          return PhoneFormPage();
        },
      ),
    );
  }
}

class PhoneFormPage extends StatelessWidget {
  final mobileFormatter = new MaskTextInputFormatter(
      mask: '+55 (##) ##### ####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    String _phoneNumber;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.all(34),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Phone Auth",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: '(DDD) + Celular',
                          labelStyle: TextStyle(
                              fontSize: 12, color: Color(0xff6A7B86))),
                      inputFormatters: [
                        mobileFormatter,
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor entre com um valor';
                        }
                        if (value.length < 15) {
                          return 'Numero incompleto';
                        }
                        _phoneNumber = value;
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        "Enviaremos um código SMS para validar sua conta.",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RoundedButton(
                      text: 'Avançar',
                      onPress: () {
                        BlocProvider.of<PhoneloginBloc>(context).add(
                          SendOtpEvent(
                            phoNo: _phoneNumber,
                          ),
                        );
                      },
                      enabled: true,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
