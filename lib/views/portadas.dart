import 'package:flutter/material.dart';
import 'package:news_app/model/ConnectionStatus.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/model/noticias_provider.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/dialog_offline.dart';
import 'package:news_app/widgets/primary_card.dart';
import 'package:provider/provider.dart';
class PortadasWidget extends StatelessWidget {
  const PortadasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noticiasP=NoticiasProvider();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer()
            ],
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: noticiasP.getNewsRT(8),
          builder: (context, AsyncSnapshot<List<Noticias>> snapshot2) {
            if(snapshot2.hasData&&snapshot2.data!.length==0){
                return PrimaryCard(news: Noticias('','Cargando','','assets/78454-loader.gif','',-1,-1,0));
              }
            if(snapshot2.hasData){
              return ListView.builder(
                itemCount: snapshot2.data!.length,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index2) {
                  return InkWell(
                    onTap: () {                     
                        if(Provider.of<ConnectionStatusView>(context,listen: false).connected){
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>ReadNewsView(news: snapshot2.data![index2]),
                          ),
                        );
                        }else{
                          showDialog(context: context,
                           builder: (contex){
                             return dilogOffline(context);
                           });
                        }  
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.5,
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: PrimaryCard(news: snapshot2.data![index2]),
                    ),
                  );
                },
              );
            }//else{
            return PrimaryCard(news: Noticias('Cargando','','','assets/78454-loader.gif','',-1,-1,1),);
            //}
          },
        )
      ),
    );
  }

  ListView showListNewsWidget(AsyncSnapshot<List<Noticias>> snapshot) {
    return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if(Provider.of<ConnectionStatusView>(context,listen: false).connected){
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>ReadNewsView(news: snapshot.data![index]),
                          ),
                        );
                        }else{
                          showDialog(context: context,
                           builder: (contex){
                             return dilogOffline(context);
                           });
                        }                           
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12.0),
                        child:  PrimaryCard(news: snapshot.data![index]),
                      ),
                    );
                  },
                );
  }
}