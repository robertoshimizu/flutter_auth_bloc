import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pages_state.dart';

enum PagesEvent { one, two, three, four, five }

class PagesBloc extends Bloc<PagesEvent, PagesState> {
  PagesBloc() : super(PagesOne());

  @override
  Stream<PagesState> mapEventToState(
    PagesEvent event,
  ) async* {
    switch (event) {
      case PagesEvent.one:
        yield PagesOne();
        break;

      case PagesEvent.two:
        yield PagesTwo();
        break;

      case PagesEvent.three:
        yield PagesThree();
        break;

      case PagesEvent.four:
        yield PagesFour();
        break;

      case PagesEvent.five:
        yield PagesFive();
        break;
    }
  }
}
