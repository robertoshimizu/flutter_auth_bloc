import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages.dart';

class SMSVerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _smsCode;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "appbar",
      //   ),
      // ),
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
                      "Código de verificação",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 16,
                    ),

                    // RoundedButton(text: "Avançar"),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        "Digite abaixo o código de confirmação enviado por SMS para o telefone: 11 99676-0000",
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      decoration: const InputDecoration(
                          labelText: 'Codigo',
                          labelStyle: TextStyle(
                              fontSize: 12, color: Color(0xff6A7B86))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor entre com um valor';
                        }
                        if (value.length < 6) {
                          return 'Numero incompleto';
                        }
                        _smsCode = value;
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    RoundedButton(
                      text: 'Avançar',
                      onPress: () {
                        BlocProvider.of<PhoneloginBloc>(context).add(
                          VerifyOtpEvent(otp: _smsCode),
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
