import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_moviedb/bloc/moviedetailbloc/movie_detail_bloc.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:flutter_moviedb/models/movie_detail.dart';
import 'package:flutter_moviedb/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => MovieDetailBloc()..add(MovieDetailEventStart(movie.id)),
        child: Scaffold(
          body: _buildDetailBody(context),
        ));
  }

  Widget _buildDetailBody(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return isLoading();
        } else if (state is MovieDetailLoaded) {
          final movieDetail = state.detail;
          return SingleChildScrollView(
            child: Stack(
              children: [
                ClipPath(
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return isLoading();
                      },
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: GestureDetector(
                        onTap: () async {
                          final youtubeUrl =
                              'https://www.youtube.com/embed/${movieDetail.trailerId}';
                          if (await canLaunch(youtubeUrl)) {
                            await launch(youtubeUrl);
                          }
                        },
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.play_circle_outline,
                                color: Colors.yellow,
                                size: 65,
                              ),
                              Text(
                                movieDetail.title.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 200),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Overview'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 35,
                            child: Text(
                              movieDetail.overview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Release date'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    movieDetail.releaseDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'run time'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    movieDetail.runtime + ' minutes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'budget'.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    movieDetail.budget,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: Colors.yellow[800],
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Screenshots'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            height: 155,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  movieDetail.movieImage.backdrops.length,
                              separatorBuilder: (context, index) {
                                return VerticalDivider(
                                  color: Colors.transparent,
                                  width: 5,
                                );
                              },
                              itemBuilder: (context, index) {
                                Screenshot image =
                                    movieDetail.movieImage.backdrops[index];
                                return Container(
                                  child: Card(
                                    elevation: 3,
                                    borderOnForeground: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                        fit: BoxFit.cover,
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
                                        placeholder: (context, url) =>
                                            isLoading(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Casts'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Container(
                            height: 110,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: movieDetail.castList.length,
                              separatorBuilder: (context, index) =>
                                  VerticalDivider(
                                color: Colors.transparent,
                                width: 5,
                              ),
                              itemBuilder: (context, index) {
                                Cast cast = movieDetail.castList[index];
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        elevation: 3,
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                                            imageBuilder:
                                                (context, imageBuilder) {
                                              return Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                  image: DecorationImage(
                                                    image: imageBuilder,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                            placeholder: (context, url) =>
                                                Container(
                                              width: 80,
                                              height: 80,
                                              child: isLoading(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            cast.name.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            cast.character.toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return isLoading();
        }
      },
    );
  }
}
