import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/model/ConnectionStatus.dart';
import 'package:news_app/views/popular_tab_view.dart';
import 'package:news_app/views/trending_tab_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late StreamSubscription<ConnectivityResult> subscription;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if(result!=ConnectivityResult.none){
        Provider.of<ConnectionStatusView>(context,listen: false).connected=true;
      }else{
        Provider.of<ConnectionStatusView>(context,listen: false).connected=false;
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    print('HomeViewBuilder');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child:
              Column(
                children: [
                  Consumer<ConnectionStatusView>(
                    builder: (_, value, __) {
                      print('Builder Consumer');
                      return ListTile(
                              title: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: !value.connected?Colors.red:Color.fromRGBO(192, 192, 192, 0),
                                ),
                                child: Text(
                                  !value.connected?'OFFLINE':'',
                                  textAlign: TextAlign.center,
                                  style: kNonActiveTabStyle.copyWith(color: Colors.black),
                                ),
                              ),
                            );
                          },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: kGrey1,
                      unselectedLabelStyle: kNonActiveTabStyle,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
                      tabs: [
                        Tab(text: "Popular",),
                        Tab(text: "Tendencia"),
                        //Tab(text: "Recent"),
                      ],
                    ),
                  ),
                ],
              )
        ),
        body: TabBarView(
          children: [
            PopularTabView(),
            TrendingTabView(),
           // RecentTabView(),
          ],
        ),
      ),
    );
  }

}
