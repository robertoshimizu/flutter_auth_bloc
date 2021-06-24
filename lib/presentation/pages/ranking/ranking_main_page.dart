import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/presentation/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/rankingbloc_bloc.dart';

class RankingMainPage extends StatefulWidget {
  const RankingMainPage({Key key}) : super(key: key);

  @override
  _RankingMainPageState createState() => _RankingMainPageState();
}

class _RankingMainPageState extends State<RankingMainPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RankingblocBloc(),
      child: Column(
        children: [
          CatalogTabBar(
            tabController: _tabController,
          ),
          Flexible(
            child: BlocBuilder<RankingblocBloc, RankingblocState>(
                builder: (context, state) {
              if (state is RankingblocNome) {
                return RankingNamePage();
              } else if (state is RankingblocRanking) {
                return RankingRankingPage();
              } else if (state is RankingblocRelacionamento) {
                return RankingRelacionamentoPage();
              } else
                return RankingNamePage();
            }),
          ),
        ],
      ),
    );
  }
}

class CatalogTabBar extends StatelessWidget {
  final TabController tabController;
  const CatalogTabBar({Key key, @required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.black26,
      labelColor: Colors.black,
      indicatorWeight: 1,
      unselectedLabelColor: Colors.grey,
      tabs: <Widget>[
        Tab(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0,
            ),
            child: Text(
              'nome'.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Tab(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0,
            ),
            child: Text(
              'ranking'.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Tab(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0,
            ),
            child: Text(
              'relacionamento'.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      onTap: (tabIndex) {
        switch (tabIndex) {
          // Nome
          case 0:
            BlocProvider.of<RankingblocBloc>(context)
                .add(RankingblocEvent.nome);
            break;

          // Ranking
          case 1:
            BlocProvider.of<RankingblocBloc>(context)
                .add(RankingblocEvent.ranking);
            break;

          // Relacionamento
          case 2:
            BlocProvider.of<RankingblocBloc>(context)
                .add(RankingblocEvent.relacionamento);
            break;
        }
      },
    );
  }
}
