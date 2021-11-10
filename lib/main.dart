import 'package:flutter/material.dart';
import 'package:movie_flex_app/utils/text.dart';
import 'package:movie_flex_app/widgets/toprated.dart';
import 'package:movie_flex_app/widgets/trending.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
      primaryColor: Colors.green,
      ),
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List topratedmovies = [];
  List trendingmovies = [];
  final String apikey = '';
  String image = "";
  String name = "";
  String details = "";
  String date = "";
  double? rating;
  String time ="";
  final readaccesstoken = '';

  int _selectedIndex = 0;
  @override
  void initState(){
    loadmovies();
    getSupport();
    super.initState();
  }
  loadmovies() async{
   await getSupport().then((value) async{
     setState(() {
       topratedmovies = [];
       topratedmovies.addAll(value);
       print("///Toprated Movies///"+ topratedmovies.toString());
     });
   }).catchError((e){
     print("ERROR");
   });
  }
loadNowPlaying() async{
   await geNowPlaying().then((value) async{
     setState(() {
       topratedmovies = [];
       topratedmovies.addAll(value);
       print("///Toprated Movies///"+ topratedmovies.toString());
     });
   }).catchError((e){
     print("ERROR");
   });
  }

 OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
    return OutlineInputBorder( //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.grey,
          width: 3,
        )
    );
  }

  OutlineInputBorder myfocusborder(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.greenAccent,
          width: 3,
        )
    );
  }
   void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex==1){
        loadNowPlaying();
      }else{
        loadmovies();
      }
      print("//Index///"+index.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Colors.orange.shade200,
        appBar: AppBar(
          backgroundColor: Colors.orange.shade200,
          elevation: 0,
          title: TextField(
            decoration: InputDecoration(hintText: "Search",
          // ic
           enabledBorder: myinputborder(),
          //  focusedBorder: myfocusborder(),
          ),
          ),
        ),
        body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: topratedmovies.length,
                scrollDirection: Axis.vertical,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () {
                         name = topratedmovies[index]["title"];
                         details = topratedmovies[index]["overview"];
                         image = 'https://image.tmdb.org/t/p/w342'+topratedmovies[index]['poster_path'];
                         date = topratedmovies[index]['release_date'];
                         rating = topratedmovies[index]["vote_average"];
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(image: image,description: details,time: date,ratting: rating!, name: name,)));
                      },
                      child: Card(
                      color: Colors.orange.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height:  MediaQuery.of(context).size.height*0.2,
                                width:  MediaQuery.of(context).size.width*0.2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w342'+topratedmovies[index]['poster_path']
                                  )
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(topratedmovies[index]["title"].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900,color: Colors.black),),
                                    SizedBox(height: 10,),
                                    Text(topratedmovies[index]["overview"].toString(),style: TextStyle(fontSize: 11,color: Colors.black),),
                                  ],
                                ),
                              )
                            ),
                          ],
                        ),
                      )
                    );
                  }) ,
              ),
            )
          ],),
        ),      
      ),
        bottomNavigationBar:  BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.media_bluetooth_off),
                title: Text('Now Playing'),
                backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Top Rated'),
                backgroundColor: Colors.yellowAccent
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
        ),
    );
  }
}


/// FOR TOP RATED API
 Future<dynamic> getSupport() async {

    var response = await http.post(
      Uri.parse("https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"),///ONLY NEED TO CHANGE THE LINK FOR THE NOW PLAYING AND US THIS IN THE NEXT PAGE ACC TO RESPONSE
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      //insert data into ModelClass
      print("///Data///"+json['results'].toString());
       return json['results'];
    } else {
      // show error
      print("Try Again");
    }
  }

/// FOR NOW PLAYING API
 Future<dynamic> geNowPlaying() async {
    var response = await http.post(
      Uri.parse("https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"),///ONLY NEED TO CHANGE THE LINK FOR THE NOW PLAYING AND US THIS IN THE NEXT PAGE ACC TO RESPONSE
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      //insert data into ModelClass
      print("///Data///"+json['results'].toString());
       return json['results'];
    } else {
      // show error
      print("Try Again");
    }
  }




//TAB  BAR WORK  
class MyStatefulWidget extends StatefulWidget {
 
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 0;
  // ignore: unused_field
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
  ];
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(decoration: InputDecoration(hintText: "Search",icon: Icon(Icons.search)),),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.media_bluetooth_off),
                title: Text('Now Playing'),
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(              
                icon: Icon(Icons.star),
                title: Text('Top Rated'),                
                backgroundColor: Colors.yellow
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}





//////////////////////////////////////// Details Screen 
class DetailScreen extends StatefulWidget {
 String image;
 String name;
 String description;
 String time;
 double ratting;

   DetailScreen({ Key? key,required this.image,required this.name,required this.description , required this.time , required this.ratting }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedIndex=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print("//Index///"+index.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("back"),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
      children: [
               Container(
                height:  MediaQuery.of(context).size.height,
                width:  MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                widget.image
                )
                )
                ),
                ),
  //               DraggableScrollableSheet(
  //   initialChildSize: 0.3,
  //   minChildSize: 0.3,
  //   maxChildSize: 0.4,
  //   builder: (BuildContext context, ScrollController scrollController) {
  //     return Container(
  //       color: Colors.white,
  //     );
  //   },
  // ),
       Positioned(
         top: MediaQuery.of(context).size.height*0.55,
         left: MediaQuery.of(context).size.width*0.05,
         right: MediaQuery.of(context).size.width*0.05,
         child: Container(
           height: MediaQuery.of(context).size.height*0.4,
           width: MediaQuery.of(context).size.width*0.8,
           color: Colors.transparent.withOpacity(0.5),
           child: Padding(
             padding: const EdgeInsets.only(left: 16,right: 16,top: 8),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Text(widget.name,style: TextStyle(fontSize: 20),),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.ratting.toString(),style: TextStyle(fontSize: 12),),
                    Text(widget.time,style: TextStyle(fontSize: 12))
                  ],
                ),
                 SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Text(widget.description,style: TextStyle(fontSize: 15),)
               ],
             ),
           ),
         ),
       )
      ],
    ),
     bottomNavigationBar:  BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.media_bluetooth_off),
                title: Text('Now Playing'),
                backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Top Rated'),
                backgroundColor: Colors.orange
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
       
    ); }
}
