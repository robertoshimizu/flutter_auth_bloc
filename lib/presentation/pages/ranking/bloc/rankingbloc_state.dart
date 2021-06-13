part of 'rankingbloc_bloc.dart';

abstract class RankingblocState extends Equatable {
  const RankingblocState();

  @override
  List<Object> get props => [];
}

class RankingblocNome extends RankingblocState {}

class RankingblocRanking extends RankingblocState {}

class RankingblocRelacionamento extends RankingblocState {}
