import 'package:flutter/material.dart';
import 'package:movie_flex_app/utils/text.dart';

class TopRated extends StatefulWidget {
  final List toprated;
  const TopRated({required Key key, required this.toprated}) : super (key: key);

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
 @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        modified_text(text: 'Top Rated Movies',size: 14, color: Colors.white,),
        SizedBox(height: 10,),
        Container(
          height:270,
          child: ListView.builder(itemCount: widget.toprated.length,

          scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () {

                },
                child: Container(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(image: DecorationImage(
                          image: NetworkImage(
                            'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'+widget.toprated[index]['poster_path'],
                            )
                        )),
                      ),
                      // Container(child: modified_text(text: toprated[index]['title']!=null?
                      // toprated[index]['title']:'Loading', color: null,),)
                    ],
                  ),
                ),
              );
            }) ,
        )
      ],),      
    );
  }
}