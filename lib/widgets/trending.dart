import 'package:flutter/material.dart';
import 'package:movie_flex_app/description.dart';
import 'package:movie_flex_app/utils/text.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({required Key key, required this.trending}) : super (key: key);
 @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        modified_text(text: 'Trending Movies',size: 14, color: Colors.white,),
        SizedBox(height: 10,),
        Container(
          height:270,
          child: ListView.builder(itemCount: trending.length,

          scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(name: trending[index]['title'],
                 bannerurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['backdrop_path'],
                  posterurl: 'https://image.tmdb.org/t/p/w500'+trending[index]['poster_path'],
                  description: trending[index]['overview'],
                  vote: trending[index]['vote_average'].toString(),
                  launch_on: trending[index]['release_date'],
                  )));
                },
                child: 
                trending[index]['title']!=null?Container(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(image: DecorationImage(
                          image: NetworkImage(
                            'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed'+trending[index]['poster_path'],
                            )
                        )),
                      ),
                      Container(child: modified_text(text: trending[index]['title']!=null?
                      trending[index]['title']:'Loading', color: Colors.white, size: 16,),)
                    ],
                  ),
                ):Container(),
              );
            }) ,
        )
      ],),      
    );
  }
}