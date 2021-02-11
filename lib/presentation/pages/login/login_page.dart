import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/data/repository/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../locator.dart';
import '../../bloc/bloc.dart';
import '../pages.dart';

class PhoneLoginWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneloginBloc>(
      create: (context) =>
          PhoneloginBloc(authRepository: locator<DataAuthRepository>()),
      child: Scaffold(
        appBar: AppBar(),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // ignore: close_sinks
  PhoneloginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<PhoneloginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneloginBloc, PhoneloginState>(
      cubit: _loginBloc,
      listener: (context, loginState) {
        if (loginState is ExceptionState || loginState is OtpExceptionState) {
          String message;
          if (loginState is ExceptionState) {
            message = loginState.message;
          } else if (loginState is OtpExceptionState) {
            message = loginState.message;
          }
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(message), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<PhoneloginBloc, PhoneloginState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is PhoneloginInitial) {
            return PhoneFormPage();
          } else if (state is OtpSentState || state is OtpExceptionState) {
            return SMSVerificationView();
          } else if (state is LoadingState) {
            return LoadingIndicator();
          }
          // else if (state is LoginCompleteState) {
          //   return HomePage();
          // }
          else {
            return PhoneFormPage();
          }
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
