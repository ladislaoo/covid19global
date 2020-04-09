import 'package:covid19global/models/SummaryCases.dart';
import 'package:flutter/material.dart';
import 'package:covid19global/providers/countries_provider.dart';
import 'package:provider/provider.dart';

//void main() => runApp(MyApp());
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CountryModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Countries _country=null;
 
  List<Country> _userSelection;
  //String _sort= ""
  Country _currentUser;
  String _screenStage;



  onChange(Country selectedUser) {
    setState(() {
      _currentUser = selectedUser;
    });

  }
  void onceSetupDropdown() async {
     CountryModel country = new CountryModel();
    _userSelection =  await country.fetchSummaryData(true);
    _screenStage = "loaded";
    setState(() {});
  }

  @override
  void initState() {
    _screenStage = "loading";
    super.initState();
    onceSetupDropdown();
    // _saveData(); // what is this for ?
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Covid 19 Global',
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Row(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Panorama Covid19'))
                ],
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "Por Pais",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Mundial",
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _tab1(context),
                _tab2(context),
              ],
            ),
          ),
        ));
  }

  Widget _tab1(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 0.16),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.10)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                /* Text(
                  "Matriz Av Leona Vicario",
                  style: TextStyle(fontSize: 25),
                ), */
               
                _countries(),
                SizedBox(height: 20.0),
           
               
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _tab2(BuildContext context) {
    return SingleChildScrollView(
      
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 0.16),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10.10)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                /* Text(
                  "Jardines del Sur",
                  style: TextStyle(fontSize: 25),
                ), */
                Text("Global"),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _countries() {
   // Country country = new Country();
    final countryModel = Provider.of<CountryModel>(context);
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _screenStage == "loaded"
                ? DropdownButton<Country>(
                    items: _userSelection
                        .map((user) => DropdownMenuItem<Country>(
                              child: Text(user.country),
                              value: user,
                            ))
                        .toList(),
                    onChanged: (value){
                      countryModel.setCountrySelected(value);
                      setState(() {
                        _currentUser = value;
                      });
                    },
                    isExpanded: true,
                    value: _currentUser,
                    hint: Text('Select Country'),
                  )
                : CircularProgressIndicator(),
            SizedBox(height: 20.0),
            countryModel.countrySelected != null
                ? Text(
                    "Name: " +
                        countryModel.countrySelected.country +
                        "\n totalConfirmed: " +
                        countryModel.countrySelected.totalConfirmed.toString() +
                        "\n Slug: " +
                        countryModel.countrySelected.slug +
                        "\n Date: " +
                        countryModel.countrySelected.date.toUtc().toString()
                        
                  )
                : Text("No Country selected"),
          ],
        ),
      );
  }

  
}
