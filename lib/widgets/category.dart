import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/bloc/genrebloc/genre_bloc.dart';
import 'package:flutter_moviedb/bloc/moviebloc/movie_bloc.dart';
import 'package:flutter_moviedb/models/genre.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:flutter_moviedb/widgets/loading.dart';

import 'movie_detail.dart';

class Category extends StatefulWidget {
  final int selectefGenre;

  const Category({Key key, this.selectefGenre = 28}) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedGenre;
  MovieBloc _movieBloc = MovieBloc();
  GenreBloc _genreBloc = GenreBloc();

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectefGenre;
    _movieBloc.add(MovieEventStart(selectedGenre, ''));
    _genreBloc.add(GenreEventStart());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _movieBloc),
        BlocProvider(create: (_) => _genreBloc),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BlocBuilder<GenreBloc, GenreState>(
            builder: (context, state) {
              if (state is GenreLoading) {
                return Container();
              } else if (state is GenreLoaded) {
                return _buildGenre(state.genreList);
              } else {
                return Container();
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'new playing'.toUpperCase(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontFamily: 'muli',
              ),
            ),
          ),
          SizedBox(height: 10),
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return isLoading();
              } else if (state is MovieLoaded) {
                return _buildMovieList(state.movieList);
              } else {
                return isLoading();
              }
            },
          ),
        ],
      ),
    );
  }

  //build genre
  Widget _buildGenre(List<Genre> genres) {
    return Column(
      children: [
        Container(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) =>
                VerticalDivider(color: Colors.transparent, width: 5),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              Genre genre = genres[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        genre = genres[index];
                        selectedGenre = genre.id;
                        context
                            .read<MovieBloc>()
                            .add(MovieEventStart(selectedGenre, ''));
                        print(selectedGenre);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        color: (genre.id == selectedGenre)
                            ? Colors.black45
                            : Colors.white,
                      ),
                      child: Text(
                        genre.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (genre.id == selectedGenre)
                              ? Colors.white
                              : Colors.black45,
                          fontFamily: 'muli',
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  //build movie List
  Widget _buildMovieList(List<Movie> movieList) {
    return Container(
      height: 300,
      child: ListView.separated(
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: 15,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          Movie movie = movieList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MovieDetailScreen(movie: movie);
                  }));
                },
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 180,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) => Container(
                      width: 180,
                      height: 250,
                      child: isLoading(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 180,
                child: Text(
                  movie.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'muli',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 14,
                    ),
                    Text(
                      movie.voteAverage,
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
