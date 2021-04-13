import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/bloc/bloc.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return FirstProfile1();
        } else
          return Text('A definir');
      },
    );
  }
}
