import 'package:flutter/material.dart';
import 'package:movie_flex_app/utils/text.dart';

class Description extends StatefulWidget {
   final String name, description, bannerurl, posterurl, vote, launch_on;
  const  Description({required this.name, required this.description, required this.bannerurl, required this.posterurl, required this.vote, required this.launch_on });

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(children: [
                Positioned(child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(widget.bannerurl, fit: BoxFit.cover,),
                )),
                Positioned(bottom: 10,
                  child: modified_text(text: 'Average Rating -'+widget.vote, color: Colors.white, size: 16),)
              ],),
            ),
            SizedBox(height: 15,),
            Container(padding: EdgeInsets.all(10),            
            // ignore: unnecessary_null_comparison
            child: modified_text(text: widget.name!=null?widget.name:'Not Loaded', color: Colors.white, size: 10),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: modified_text(text: 'Releasing On -'+widget.launch_on, color: Colors.white, size: 14),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(widget.posterurl),
                ),
                Flexible(child: Container(
                  child: modified_text(text: widget.description, color: Colors.white, size: 18),
                ))
              ],
            )
          ],
        ),
      ),
    );
  
  }
}