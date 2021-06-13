import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'rankingbloc_state.dart';

enum RankingblocEvent { nome, ranking, relacionamento }

class RankingblocBloc extends Bloc<RankingblocEvent, RankingblocState> {
  RankingblocBloc() : super(RankingblocNome());

  @override
  Stream<RankingblocState> mapEventToState(
    RankingblocEvent event,
  ) async* {
    switch (event) {
      case RankingblocEvent.nome:
        yield RankingblocNome();
        break;

      case RankingblocEvent.ranking:
        yield RankingblocRanking();
        break;

      case RankingblocEvent.relacionamento:
        yield RankingblocRelacionamento();
        break;
    }
  }
}
