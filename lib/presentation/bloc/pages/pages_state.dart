part of 'pages_bloc.dart';

abstract class PagesState extends Equatable {
  const PagesState();

  @override
  List<Object> get props => [];
}

class PagesOne extends PagesState {}

class PagesTwo extends PagesState {}

class PagesThree extends PagesState {}

class PagesFour extends PagesState {}

class PagesFive extends PagesState {}
