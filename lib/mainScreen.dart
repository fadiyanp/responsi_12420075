import 'package:flutter/material.dart';
import 'matches_model.dart';
import 'detailPage.dart';
import 'baseNetwork.dart';
import 'detail_matches_model.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class MatchesSource {
  static MatchesSource instance = MatchesSource();
  Future<List<dynamic>> LoadMatches() {
    return BaseNetwork.getList('matches');
  }
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piala Dunia 2022'),
      ),

      body: Container(
        child: FutureBuilder(
            future: MatchesSource.instance.LoadMatches(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                return _buildSuccessSection(snapshot.data);
              }
              return _buildLoadingSection();
            }),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(
        color: Color(0xff0800000),
      ),
    );
  }

  Widget _buildSuccessSection(List<dynamic> data) {
    return ListView.builder(
      itemCount: 48,
      itemBuilder: (BuildContext context, int index) {
        MatchesModel matchesModel = MatchesModel.fromJson(data[index]);
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  detail: matchesModel,
                ),
              ),
            );
          },
          child: Container(
            height: 100,
            width: 200,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // if you need this
                side: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 3,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: 70,
                      height: 50,
                      child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(
                              'https://countryflagsapi.com/png/${matchesModel!.homeTeam!.name!}')
                      )),

                  Text("${matchesModel!.homeTeam!.name!}"),
                  Text("${matchesModel!.homeTeam!.goals!} - ${matchesModel!.awayTeam!.goals!}"),
                  Text("${matchesModel!.awayTeam!.name!}"),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: 70,
                    height: 50,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                          'https://countryflagsapi.com/png/${matchesModel!.awayTeam!.name!}'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      //
    );
  }






}