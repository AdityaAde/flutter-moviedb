import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/bloc/moviebloc/movie_bloc.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:flutter_moviedb/widgets/category.dart';
import 'package:flutter_moviedb/widgets/loading.dart';
import 'package:flutter_moviedb/widgets/movie_detail.dart';
import 'package:flutter_moviedb/widgets/trending_person.dart';

class GetNowPlay extends StatefulWidget {
  @override
  _GetNowPlayState createState() => _GetNowPlayState();
}

class _GetNowPlayState extends State<GetNowPlay> {
  MovieBloc _movieBloc = MovieBloc();
  @override
  void initState() {
    super.initState();
    _movieBloc.add(MovieEventStart(0, ''));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(create: (_) => _movieBloc),
      ],
      child: Scaffold(
        body: _movieList(context),
      ),
    );
  }

  Widget _movieList(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoading) {
                      return Center(
                        child: isLoading(),
                      );
                    } else if (state is MovieLoaded) {
                      List<Movie> movies = state.movieList;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider.builder(
                            itemCount: movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              Movie movie = movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return MovieDetailScreen(movie: movie);
                                  }));
                                },
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    ClipRRect(
                                      child: CachedNetworkImage(
                                        imageUrl: 'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                        height: MediaQuery.of(context).size.height / 3,
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => isLoading(),
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 15,
                                        left: 15,
                                      ),
                                      child: Text(
                                        movie.title.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              pauseAutoPlayOnTouch: true,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 50),
                                Category(),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        child: isLoading(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
